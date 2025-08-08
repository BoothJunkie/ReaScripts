--[[
 * @description BJ_Censor Beep of Time Selection Length
 * @version 1.0
 * @author Mike DelGaudio
 * @authorURI http://boothjunkie.com
 * @donation https://www.buymeacoffee.com/boothjunkie
 * @license MIT
 * @about
 *    Creates a MIDI item with a C6 note and ReaSynth that spans the current time selection.
 *    Designed for podcast editors and content creators who need to censor language or sensitive content.
 *    Non-destructive and fast: select a time range, select a track, run script.
 * @reaper 6.0
]]


function insertMIDIItemWithReaSynthForTimeSelection()
    -- Check if there is a time selection
    local startTime, endTime = reaper.GetSet_LoopTimeRange(false, false, 0, 0, false)
    if startTime == endTime then
        reaper.ShowMessageBox("No time selection made. Please make a time selection and run the script again.", "Error", 0)
        return
    end

    -- Get the currently selected track
    local track = reaper.GetSelectedTrack(0, 0)
    if track == nil then
        reaper.ShowMessageBox("No track selected. Please select a track and run the script again.", "Error", 0)
        return
    end

    -- Set MIDI note parameters
    local note = 84 -- MIDI note number for C6
    local velocity = 100 -- Velocity of the note

    -- Unselect all items
    reaper.Main_OnCommand(40289, 0) -- Command ID for "Unselect all items"

    -- Create a new MIDI item
    local item = reaper.CreateNewMIDIItemInProj(track, startTime, endTime)
    reaper.SetMediaItemSelected(item, true) -- Select the new item

    local take = reaper.GetMediaItemTake(item, 0)

    -- Convert time selection positions to PPQ (Pulses Per Quarter note)
    local start_ppq = reaper.MIDI_GetPPQPosFromProjTime(take, startTime)
    local end_ppq = reaper.MIDI_GetPPQPosFromProjTime(take, endTime)

    -- Insert the note
    reaper.MIDI_InsertNote(
        take, -- MIDI take
        false, -- selected
        false, -- muted
        start_ppq, -- start position in PPQ
        end_ppq, -- end position in PPQ
        0, -- channel
        note, -- pitch
        velocity, -- velocity
        true -- noSort
    )

    -- Add ReaSynth to the take
    local fx_index = reaper.TakeFX_AddByName(take, "ReaSynth", 1)

    -- Check if ReaSynth was added successfully
    if fx_index == -1 then
        reaper.ShowConsoleMsg("Failed to add ReaSynth to the take.\n")
    end

    -- Update the item and arrange view
    reaper.UpdateArrange()
end

reaper.Undo_BeginBlock()
insertMIDIItemWithReaSynthForTimeSelection()
reaper.Undo_EndBlock("BJ_Censor Beep of Time Selection Length", -1)

