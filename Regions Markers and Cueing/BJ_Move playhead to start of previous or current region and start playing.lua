--[[
 * @description BJ_Move Playhead to Start of Previous or Current Region and Start Playback
 * @version 1.0
 * @author Mike DelGaudio
 * @authorURI http://boothjunkie.com
 * @donation https://www.buymeacoffee.com/boothjunkie
 * @license MIT
 * @about
 *    Moves the play cursor to the start of the previous or current region and starts playback.
 *    Complements the “next region” script for bidirectional region-based navigation.
 * @reaper 6.0
]]

reaper.Undo_BeginBlock()

-- Get current play cursor
current_pos = reaper.GetPlayPosition()

-- Count project markers and regions
retval, num_markers, num_regions = reaper.CountProjectMarkers(0)

-- Find previous or current region
previous_region_start = nil
previous_region_end = nil

for i = 0, num_markers + num_regions - 1 do
    retval, isrgn, pos, rgnend, name, markrgnindexnumber = reaper.EnumProjectMarkers(i)
    if isrgn and pos <= current_pos then
        if previous_region_start == nil or pos > previous_region_start then
            previous_region_start = pos
            previous_region_end = rgnend
        end
    end
end

-- Move play cursor and start playback if found
if previous_region_start ~= nil then
    reaper.SetEditCurPos(previous_region_start, true, false)
    reaper.OnPlayButton()
else
    reaper.ShowMessageBox("No previous region found.", "Info", 0)
end

reaper.Undo_EndBlock("Go to previous region and play", -1)

