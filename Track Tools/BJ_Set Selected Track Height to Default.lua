--[[
 * @description BJ_Set Selected Track height to Default
 * @version 1.0
 * @author Mike DelGaudio
 * @authorURI http://boothjunkie.com
 * @about
 *   Resets the height of any selected track to its default value.
 *   Instructions: Select the tracks you want to reset and run this action.
 * @donation https://www.buymeacoffee.com/boothjunkie
 * @license MIT
 * @reaper 6.0
]]


function reset_selected_tracks_height()
  -- Loop through all selected tracks and reset their height to default
  local count = reaper.CountSelectedTracks(0)
  for i = 0, count - 1 do
    local track = reaper.GetSelectedTrack(0, i)
    reaper.SetMediaTrackInfo_Value(track, "I_HEIGHTOVERRIDE", 0)
  end
  reaper.TrackList_AdjustWindows(false)
end

-- Example usage:
reset_selected_tracks_height() -- resets all selected tracks to their default height
