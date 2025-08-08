--[[
 * @description BJ_CreateNewTrackWithColorAfterFirstSelectedTrack
 * @version 1.0
 * @author Mike DelGaudio
 * @authorURI http://boothjunkie.com
 * @about
 *    Mimics the "Insert New Track" function, but inserts a new track with a random color after the first selected track.
 *    If multiple tracks are selected, the new track will appear after the top-most selected track.
 * @instructions
 *    Select the track you want the new track to appear below, then run the script.
 * @license MIT
 * @donation https://www.buymeacoffee.com/boothjunkie
 * @reaper 6.0
]]

function CreateNewTrackWithColorAfterSelected()
    -- Begin the undo block
    reaper.Undo_BeginBlock()

    -- Find the index of the first selected track
    local selectedTrack = reaper.GetSelectedTrack(0, 0) -- Get the first selected track
    local index = 0 -- Default to the start if no track is selected
    if selectedTrack then
        index = reaper.GetMediaTrackInfo_Value(selectedTrack, "IP_TRACKNUMBER")
    end

    -- Insert the track after the selected track (or at the start)
    reaper.InsertTrackAtIndex(index, true)

    -- Get the newly created track
    local newTrack = reaper.GetTrack(0, index)

    -- Set a random color for the new track
    local color = reaper.ColorToNative(math.random(255), math.random(255), math.random(255)) | 0x1000000
    reaper.SetMediaTrackInfo_Value(newTrack, "I_CUSTOMCOLOR", color)

    -- End the undo block
    reaper.Undo_EndBlock("Create New Track With Color After Selected", -1)
end

-- Run the script
CreateNewTrackWithColorAfterSelected()

