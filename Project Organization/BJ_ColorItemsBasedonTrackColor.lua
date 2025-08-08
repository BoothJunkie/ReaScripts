--[[
 * @description BJ_ColorItemsBasedonTrackColor
 * @version 1.0
 * @author Mike DelGaudio
 * @authorURI http://boothjunkie.com
 * @about
 *    Will color any items on a track to the color of the track panel.
 *    Select tracks with items that you want to color. You can select items across multiple tracks.
 *    This mimics the default behavior of items on colored tracks, except that the color will remain if
 *    the item moves to a new track, which helps identify if items have moved to new tracks inadvertently.
 * @donation https://www.buymeacoffee.com/boothjunkie
 * @license MIT
 * @reaper 6.0+
]]


function ColorItemsBasedOnTrackColor()
    -- Begin the undo block
    reaper.Undo_BeginBlock()

    local trackCount = reaper.CountTracks(0)

    -- Loop through all tracks
    for i = 0, trackCount - 1 do
        local track = reaper.GetTrack(0, i)
        local trackColor = reaper.GetMediaTrackInfo_Value(track, "I_CUSTOMCOLOR")

        if trackColor ~= 0 then
            local itemCount = reaper.CountTrackMediaItems(track)

            -- Loop through all items on the track
            for j = 0, itemCount - 1 do
                local item = reaper.GetTrackMediaItem(track, j)
                reaper.SetMediaItemInfo_Value(item, "I_CUSTOMCOLOR", trackColor)
            end
        end
    end

    -- End the undo block
    reaper.Undo_EndBlock("Color Items Based On Track Color", -1)
end

-- Run the script
ColorItemsBasedOnTrackColor()

