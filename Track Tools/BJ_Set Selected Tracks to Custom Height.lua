--[[
 * @description BJ_Set Selected Tracks to custom height
 * @version 1.0
 * @author Mike DelGaudio
 * @authorURI http://boothjunkie.com
 * @about
 *    Sets the height of any selected track to a given pixel height.
 *    Useful for quick resizing of track heights for editing and using free item positioning.
 *    This script serves as the basis for other Booth Junkie Track Resizing actions.
 *    You can copy this script to a new file, rename it, and change the number in the last line to set a different height.
 * @instructions
 *    Edit the bottom line of the script and change the number in the parentheses to the track height you want, then save.
 *    Whenever you run the action, it will set selected tracks to the specified height.
 *    You can make multiple copies of this script if you want several different heights as quick actions.
 * @donation https://www.buymeacoffee.com/boothjunkie
 * @license MIT
 * @reaper 6.0
]]


preferred_height = 500 -- Change this to whatever height you want then CTRL+S to save it. 

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
set_selected_tracks_height(preferred_height)  
