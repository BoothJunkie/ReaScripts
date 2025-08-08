--[[
 * @description BJ_Calculate FRT of All Items on a Single Track
 * @version 1.0
 * @author Mike DelGaudio
 * @authorURI http://boothjunkie.com
 * @about
 *    Calculates the final runtime (FRT) of all items on each track in the project.
 *    Outputs a plain text summary showing duration in minutes, and saves it to the project folder.
 *    Also copies the summary to your clipboard for easy pasting into invoices, emails, or notes.
 * @donation https://www.buymeacoffee.com/boothjunkie
 * @license MIT
 * @reaper 6.0
]]--

reaper.Undo_BeginBlock()

local function calculateTrackLength(track)
    local itemCount = reaper.CountTrackMediaItems(track)
    local totalLength = 0

    for i = 0, itemCount - 1 do
        local item = reaper.GetTrackMediaItem(track, i)
        local itemLength = reaper.GetMediaItemInfo_Value(item, "D_LENGTH")
        totalLength = totalLength + itemLength
    end

    return totalLength
end

local projectLengthInfo = ""
local numTracks = reaper.CountTracks(0)

for i = 0, numTracks - 1 do
    local track = reaper.GetTrack(0, i)
    local _, trackName = reaper.GetSetMediaTrackInfo_String(track, "P_NAME", "", false)
    local trackLengthInSeconds = calculateTrackLength(track)
    local trackLengthInMinutes = math.floor((trackLengthInSeconds / 60) * 100 + 0.5) / 100

    projectLengthInfo = projectLengthInfo .. "Track " .. (i+1) .. " (" .. trackName .. "): " .. trackLengthInMinutes .. " minutes\n"
end

-- Get the project name and path
local _, projectPath = reaper.EnumProjects(-1, "")
local projectName = projectPath:match("^.+[/\\](.+)$")
local projectDir = projectPath:match("^(.+)[/\\]")

-- Create the file name
local fileName = projectDir .. "/FRT-" .. projectName .. ".txt"

-- Write to the file
local file = io.open(fileName, "w")
if file then
    file:write(projectLengthInfo)
    file:close()
else
    reaper.ShowMessageBox("Failed to write to file: " .. fileName, "Error", 0)
end

-- Copy to clipboard
reaper.CF_SetClipboard(projectLengthInfo)

-- Optionally, display a message box as confirmation
reaper.ShowMessageBox("Information copied to clipboard and saved to file:\n" .. fileName, "Track Lengths", 0)

-- Open file explorer to the directory
-- On Windows: explorer.exe, on macOS: open
-- We'll detect the OS:
if reaper.GetOS():match("Win") then
    -- Windows
    reaper.ExecProcess('explorer "'..projectPath..'"', -1)
  else
    -- macOS/Linux
    local os =  reaper.GetOS()
    reaper.ShowMessageBox( projectDir, "Success", 0)
    io.popen("open '"..projectDir.."'")
  end

reaper.Undo_EndBlock("Calculate Total Lengths for All Tracks and Save to File", -1)

