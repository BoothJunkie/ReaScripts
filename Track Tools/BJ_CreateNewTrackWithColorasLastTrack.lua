--[[
 * @description BJ_CreateNewTrackWithColorAsLastTrack
 * @version 1.0
 * @author Mike DelGaudio
 * @authorURI http://boothjunkie.com
 * @about
 *    Mimics the "Insert New Track" function, but inserts a new track at the bottom of the track list with a random color.
 * @instructions
 *    Run the script. A new track will be added at the end of the project.
 * @license MIT
 * @donation https://www.buymeacoffee.com/boothjunkie
 * @reaper 6.0
]]


function CreateNewTrackWithColor()
    -- Begin the undo block
    reaper.Undo_BeginBlock()

    -- Specify the index where you want to insert the new track
    local index = reaper.CountTracks(0) -- This will add the track to the end of the track list

    -- Insert the track at the specified index
    reaper.InsertTrackAtIndex(index, true)

    -- Get the newly created track
    local newTrack = reaper.GetTrack(0, index)

    -- Set a random color for the new track
    local color = reaper.ColorToNative(math.random(255), math.random(255), math.random(255)) | 0x1000000
    reaper.SetMediaTrackInfo_Value(newTrack, "I_CUSTOMCOLOR", color)

    -- End the undo block
    reaper.Undo_EndBlock("Create New Track With Color", -1)
end

-- Run the script
CreateNewTrackWithColor()

