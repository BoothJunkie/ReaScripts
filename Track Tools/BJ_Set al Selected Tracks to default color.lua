--[[
 * @description BJ_Set Selected Tracks to Default Color
 * @version 1.0
 * @author Mike DelGaudio
 * @authorURI http://boothjunkie.com
 * @donation https://www.buymeacoffee.com/boothjunkie
 * @license MIT
 * @about
 *    Removes any custom color from selected tracks, restoring Reaper's default track color.
 *    Complements "BJ_Set Selected Tracks to Random Colors" by reverting changes.
 * @reaper 6.0
]]


-- Start undo block
reaper.Undo_BeginBlock()

-- Count selected tracks
local num_sel_tracks = reaper.CountSelectedTracks(0)

for i = 0, num_sel_tracks - 1 do
  local track = reaper.GetSelectedTrack(0, i)
  if track then
    reaper.SetMediaTrackInfo_Value(track, "I_CUSTOMCOLOR", 0)
  end
end

-- End undo block
reaper.Undo_EndBlock("Reset selected tracks to default color", -1)

-- Refresh track list
reaper.TrackList_AdjustWindows(false)

