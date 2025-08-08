--[[
 * @description BJ_Set all tracks to defined height
 * @version 1.0
 * @author Mike DelGaudio
 * @authorURI http://boothjunkie.com
 * @about
 *    Sets the height of all tracks in the project to a default value.
 *    Configure the defaultHeight variable at the beginning of the script, then run this action to adjust all tracks to this height.
 * @instructions
 *   Change the `defaultHeight` value at the top of the script to define your preferred track height.
 * @donation https://www.buymeacoffee.com/boothjunkie
 * @license MIT
 * @reaper 6.0
]]


-- Configuration variable
local defaultHeight = 200 -- Default height for all tracks in pixels

function set_all_tracks_to_default_height()
    local trackCount = reaper.CountTracks(0)

    -- Loop through all tracks in the project
    for i = 0, trackCount - 1 do
        local track = reaper.GetTrack(0, i)
        reaper.SetMediaTrackInfo_Value(track, "I_HEIGHTOVERRIDE", defaultHeight)
    end

    reaper.TrackList_AdjustWindows(false) -- Adjust the track list
end

-- Execute the script
reaper.Undo_BeginBlock() -- Begin undo block
set_all_tracks_to_default_height()
reaper.Undo_EndBlock("Set all tracks to defined height", -1) -- End undo block with a descriptive action name

