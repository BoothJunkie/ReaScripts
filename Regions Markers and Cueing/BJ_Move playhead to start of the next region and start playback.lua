--[[
 * @description BJ_Move Playhead to Start of Next Region and Start Playback
 * @version 1.0
 * @author Mike DelGaudio
 * @authorURI http://boothjunkie.com
 * @donation https://www.buymeacoffee.com/boothjunkie
 * @license MIT
 * @about
 *    Moves the play cursor to the start of the next region in the timeline and starts playback immediately.
 *    Intended for fast cue-to-cue proofing of long-form recordings or audiobooks with regions.
 * @reaper 6.0
]]


reaper.Undo_BeginBlock()

-- Get current play cursor
current_pos = reaper.GetPlayPosition()

-- Count project markers and regions
retval, num_markers, num_regions = reaper.CountProjectMarkers(0)

-- Find next region after current_pos
next_region_start = nil
for i = 0, num_markers + num_regions - 1 do
    retval, isrgn, pos, rgnend, name, markrgnindexnumber = reaper.EnumProjectMarkers(i)
    if isrgn and pos > current_pos then
        if next_region_start == nil or pos < next_region_start then
            next_region_start = pos
        end
    end
end

-- Move play cursor and start playback if next region found
if next_region_start ~= nil then
    reaper.SetEditCurPos(next_region_start, true, false) -- move view too
    reaper.OnPlayButton()
else
    reaper.ShowMessageBox("No next region found.", "Info", 0)
end

reaper.Undo_EndBlock("Go to next region and play", -1)

