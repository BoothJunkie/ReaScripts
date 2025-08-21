--[[
 * @description BJ_YouTube Chapter Maker
 * @version 1.1
 * @author Mike DelGaudio (Booth Junkie)
 * @about
 *    This script creates YouTube chapter timestamps for each region in a REAPER project.
 *    For each region, it finds markers starting with "CHAP=" and generates timestamps
 *    relative to the region start. Creates YOUTUBE-[RegionName].txt files in project directory.
 * @donation https://www.buymeacoffee.com/boothjunkie
 * @license MIT 
 * @reaper 6.0
--]]

reaper.Undo_BeginBlock()

local function formatTimeForYouTube(totalSeconds)
    local minutes = math.floor(totalSeconds / 60)
    local seconds = math.floor(totalSeconds % 60)
    return string.format("%d:%02d", minutes, seconds)
end

local function sanitizeFileName(name)
    -- Remove/replace characters that aren't safe for filenames
    return name:gsub("[<>:\"/\\|?*]", "_")
end

-- Get project path info
local _, projectPath = reaper.EnumProjects(-1, "")
local projectDir = projectPath:match("^(.+)[/\\]")

if not projectDir then
    reaper.ShowMessageBox("Could not determine project directory. Please save your project first.", "Error", 0)
    return
end

local regionCount, markerCount = reaper.CountProjectMarkers(0)
local processedRegions = 0
local totalChapters = 0

-- Check if there are any regions
local hasRegions = false
for i = 0, regionCount + markerCount - 1 do
    local retval, isrgn, pos, rgnend, name, markrgnindexnumber = reaper.EnumProjectMarkers(i)
    if isrgn then
        hasRegions = true
        break
    end
end

if hasRegions then
    -- Process each region (existing logic)
    for i = 0, regionCount + markerCount - 1 do
        local retval, isrgn, pos, rgnend, name, markrgnindexnumber = reaper.EnumProjectMarkers(i)
        
        if isrgn and name ~= "" then
            local chapters = {}
            local regionStart = pos
            local regionEnd = rgnend
            
            -- Find all markers within this region that start with "CHAP="
            for j = 0, regionCount + markerCount - 1 do
                local mretval, misrgn, mpos, mrgnend, mname, mmarkrgnindexnumber = reaper.EnumProjectMarkers(j)
                
                if not misrgn and mpos >= regionStart and mpos <= regionEnd then
                    if mname:match("^CHAP=") then
                        local chapterTitle = mname:match("^CHAP=(.+)$")
                        if chapterTitle then
                            local relativeTime = mpos - regionStart
                            local timeString = formatTimeForYouTube(relativeTime)
                            table.insert(chapters, {time = relativeTime, timeString = timeString, title = chapterTitle})
                        end
                    end
                end
            end
            
            -- Sort chapters by time
            table.sort(chapters, function(a, b) return a.time < b.time end)
            
            -- Ensure we have a 0:00 chapter (YouTube requirement)
            if #chapters > 0 then
                if chapters[1].time > 0 then
                    -- Insert a 0:00 chapter at the beginning
                    table.insert(chapters, 1, {
                        time = 0, 
                        timeString = "0:00", 
                        title = name -- Use region name as default first chapter
                    })
                end
                
                -- Create file content
                local content = ""
                for _, chapter in ipairs(chapters) do
                    content = content .. chapter.timeString .. " " .. chapter.title .. "\n"
                end
                
                -- Create filename
                local safeRegionName = sanitizeFileName(name)
                local fileName = projectDir .. "/YOUTUBE-" .. safeRegionName .. ".txt"
                
                -- Write file
                local file = io.open(fileName, "w")
                if file then
                    file:write(content)
                    file:close()
                    processedRegions = processedRegions + 1
                    totalChapters = totalChapters + #chapters
                else
                    reaper.ShowMessageBox("Could not write file: " .. fileName, "Error", 0)
                end
            end
        end
    end
else
    -- No regions found - process entire timeline
    local chapters = {}
    
    -- Find all markers that start with "CHAP="
    for i = 0, regionCount + markerCount - 1 do
        local retval, isrgn, pos, rgnend, name, markrgnindexnumber = reaper.EnumProjectMarkers(i)
        
        if not isrgn and name:match("^CHAP=") then
            local chapterTitle = name:match("^CHAP=(.+)$")
            if chapterTitle then
                local timeString = formatTimeForYouTube(pos)
                table.insert(chapters, {time = pos, timeString = timeString, title = chapterTitle})
            end
        end
    end
    
    -- Sort chapters by time
    table.sort(chapters, function(a, b) return a.time < b.time end)
    
    if #chapters > 0 then
        -- Ensure we have a 0:00 chapter (YouTube requirement)
        if chapters[1].time > 0 then
            -- Get project name for default chapter title
            local _, projectPath = reaper.EnumProjects(-1, "")
            local projectName = projectPath:match("^.+[/\\](.+)%.RPP$") or "Introduction"
            
            table.insert(chapters, 1, {
                time = 0, 
                timeString = "0:00", 
                title = projectName
            })
        end
        
        -- Create file content
        local content = ""
        for _, chapter in ipairs(chapters) do
            content = content .. chapter.timeString .. " " .. chapter.title .. "\n"
        end
        
        -- Create filename using project name
        local _, projectPath = reaper.EnumProjects(-1, "")
        local projectName = projectPath:match("^.+[/\\](.+)%.RPP$") or "Project"
        local fileName = projectDir .. "/YOUTUBE-" .. sanitizeFileName(projectName) .. ".txt"
        
        -- Write file
        local file = io.open(fileName, "w")
        if file then
            file:write(content)
            file:close()
            processedRegions = 1  -- Count as one "region" for reporting
            totalChapters = #chapters
        else
            reaper.ShowMessageBox("Could not write file: " .. fileName, "Error", 0)
        end
    end
end

-- Show results and open file browser
local message = "YouTube Chapter Files Created!\n\n"
message = message .. "Regions processed: " .. processedRegions .. "\n"
message = message .. "Total chapters: " .. totalChapters .. "\n"
message = message .. "Files saved to: " .. projectDir

reaper.ShowMessageBox(message, "YouTube Chapter Maker", 0)

-- Open the project directory in the system file browser
if processedRegions > 0 then
    local osType = reaper.GetOS()
    if osType:match("Win") then
        -- Windows: use explorer
        os.execute('explorer "' .. projectDir:gsub("/", "\\") .. '"')
    elseif osType:match("OSX") then
        -- macOS: use open command
        os.execute('open "' .. projectDir .. '"')
    else
        -- Linux: try xdg-open (most common)
        os.execute('xdg-open "' .. projectDir .. '"')
    end
end

reaper.Undo_EndBlock("Create YouTube Chapter Files", -1)