--[[
 * @description BJ_Final Run Time Calculator
 * @version 2.3
 * @author Mike DelGaudio (Booth Junkie)
 * @about
 *    This script calculates the total run time of items on each track in a REAPER project,
 *    excluding silence, and displays this information along with the file path in a message box.
 *    Useful for voice actors, producers, and audio engineers who need to quickly calculate
 *    and document the total run time of their REAPER projects.
 * @donation https://www.buymeacoffee.com/boothjunkie
 * @license MIT
 * @reaper 6.0
--]]




--This section is appended to the bottom of the FRT report. Markdown format may be used between the square brackets
footer=[[

***

*Final Runtime Calculations calculated from  actual files in project* 


]]

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

local function formatTime(totalSeconds)
    local totalMinutes = math.floor((totalSeconds / 60) * 100 + 0.5) / 100
    return totalMinutes
end

local projectLengthInfo = ""
local totalMinutes = 0
local numTracks = reaper.CountTracks(0)

for i = 0, numTracks - 1 do
    local track = reaper.GetTrack(0, i)
    local _, trackName = reaper.GetSetMediaTrackInfo_String(track, "P_NAME", "", false)
    local trackLengthInSeconds = calculateTrackLength(track)
    local trackLengthInMinutes = formatTime(trackLengthInSeconds)

    projectLengthInfo = projectLengthInfo .. (i + 1) .. ". " .. (trackName ~= "" and trackName .. ": " or "") .. trackLengthInMinutes .. " minutes\n"
    totalMinutes = totalMinutes + trackLengthInMinutes
end

-- Get the project name and path
local _, projectPath = reaper.EnumProjects(-1, "")
local projectName = projectPath:match("^.+[/\\](.+)$")
local projectDir = projectPath:match("^(.+)[/\\]")

-- Create the file name
local fileName = projectDir .. "/FRT-" .. projectName .. ".md"

-- Format and Insert the Header
local header = "# *Final Runtime Report*\n## Project: " .. projectName .. "\n## Total Run Time:\t" .. totalMinutes .. "\tMinutes\n\n## Breakdown by Track\n"
header = header .. "\n"
projectLengthInfo = header .. projectLengthInfo  .. "\n\n" .. footer

-- Write to the file
local file = io.open(fileName, "w")
if file then
    file:write(projectLengthInfo)
    file:close()
end

-- Display a simplified message box
local simpleMessageBoxText = "Project: " .. projectName .. "\nTotal Run Time:\t" .. totalMinutes .. "\tMinutes\n" .. string.rep("-", 30) .. "\n" .. "See details in " .. fileName
reaper.ShowMessageBox(simpleMessageBoxText, "Track Lengths", 0)

reaper.Undo_EndBlock("Calculate Total Lengths for All Tracks and Display in Message Box with File Path", -1)

