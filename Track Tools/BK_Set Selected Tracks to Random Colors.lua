--[[
 * @description BJ_Set Selected Tracks to Random Colors
 * @version 1.0
 * @author Mike DelGaudio
 * @authorURI http://boothjunkie.com
 * @donation https://www.buymeacoffee.com/boothjunkie
 * @license MIT
 * @about
 *    Applies a unique random color to each selected track.
 *    Useful for visual organization when working with large projects, dialog stems, or temp tracks.
 * @reaper 6.0
]]


-- Start undo block
reaper.Undo_BeginBlock()

-- Count selected tracks
local num_sel_tracks = reaper.CountSelectedTracks(0)

for i = 0, num_sel_tracks - 1 do
  local track = reaper.GetSelectedTrack(0, i)
  if track then
    -- Generate a random color using 0xRRGGBB format
    local r = math.random(0, 255)
    local g = math.random(0, 255)
    local b = math.random(0, 255)
    local color = reaper.ColorToNative(r, g, b) | 0x1000000 -- enable custom color flag

    reaper.SetMediaTrackInfo_Value(track, "I_CUSTOMCOLOR", color)
  end
end

-- End undo block
reaper.Undo_EndBlock("Set random colors to selected tracks", -1)

-- Refresh track list
reaper.TrackList_AdjustWindows(false)

