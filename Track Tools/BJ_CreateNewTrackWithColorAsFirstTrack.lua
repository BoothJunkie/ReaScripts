--[[
 * @description BJ_CreateNewTrackWithColorAsFirstTrack
 * @version 1.0
 * @author Mike DelGaudio
 * @authorURI http://boothjunkie.com
 * @about
 *    Inserts a new track as the first track in the project and assigns it a random color.
 * @instructions
 *    Just run the script. The new track will appear at the top of the project.
 * @license MIT
 * @donation https://www.buymeacoffee.com/boothjunkie
 * @reaper 6.0
]]

function CreateNewTrackWithColorAsFirstTrack()
    -- Begin the undo block
    reaper.Undo_BeginBlock()

    -- Specify the index to insert the new track at the beginning
    local index = 0

    -- Insert the track at the beginning of the track list
    reaper.InsertTrackAtIndex(index, true)

    -- Get the newly created track
    local newTrack = reaper.GetTrack(0, index)

    -- Set a random color for the new track
    local color = reaper.ColorToNative(math.random(255), math.random(255), math.random(255)) | 0x1000000
    reaper.SetMediaTrackInfo_Value(newTrack, "I_CUSTOMCOLOR", color)

    -- End the undo block
    reaper.Undo_EndBlock("Create New Track With Color As First Track", -1)
end

-- Run the script
CreateNewTrackWithColorAsFirstTrack()

