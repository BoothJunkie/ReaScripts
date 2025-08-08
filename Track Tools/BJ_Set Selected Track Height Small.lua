-- @description BJ_Set Selected Track height to Small
-- @version 1.0
-- @author Mike DelGaudio
-- @authorURI http://boothjunkie.com
-- @about
--   Sets the height of any selected track to 100 pixels.
--   Useful for quick resizing of track heights for editing and using free item positioning.
--   Select the track you want to make small-sized and run this action.
-- @donation https://www.buymeacoffee.com/boothjunkie
-- @license MIT
-- @reaper 6.0

function set_selected_tracks_height(height)
    -- Loop through all selected tracks and set their height
    local count = reaper.CountSelectedTracks(0)
    for i = 0, count - 1 do
        local track = reaper.GetSelectedTrack(0, i)
        reaper.SetMediaTrackInfo_Value(track, "I_HEIGHTOVERRIDE", height)
    end
    reaper.TrackList_AdjustWindows(false)
end

-- Example usage:
set_selected_tracks_height(100)  -- sets all selected tracks to 'Medium' height

