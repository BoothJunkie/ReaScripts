--[[
 * @description BJ_Add MIDI Beep to selected Tracks at Edit Cursor
 * @version 1.0
 * @author Mike DelGaudio
 * @authorURI http://boothjunkie.com
 * @about
 *    Adds a new MIDI item with a 32nd note at C5 placed at the Edit Cursor and a ReaSynth plugin for selected tracks, for use as an audible marker or separator.
 *    Place edit cursor at desired point, and select at least one track. (First track will be autoselected if only one track exists in project)
 *    THis is useful when sending the audio to an editor, so they can "see" the audiible marker in the waveform. 
 * @donation https://www.buymeacoffee.com/boothjunkie
 * @license MIT
 * @reaper 6.0
]]

-- Start logging to Reaper's console
function debugMsg(msg)
    reaper.ShowConsoleMsg(tostring(msg) .. "\n")
end

-- debugMsg("Script started")

-- Start undo block
reaper.Undo_BeginBlock()

-- Get the number of selected tracks
num_tracks = reaper.CountSelectedTracks(0)
-- debugMsg("There are ".. num_tracks .. " tracks")

-- Check if there is only one track in the project
if reaper.CountTracks(0) == 1 and num_tracks == 0 then
    -- Select the only track
    only_track = reaper.GetTrack(0, 0)
    reaper.SetTrackSelected(only_track, true)
    num_tracks = 1
end

if num_tracks == 0 then
    ret = reaper.ShowMessageBox("No Track(s) selected to add a beep. Please select at least one track to continue. ",  "No Track(s) Selected", 0)
    return
end  

-- debugMsg("Number of selected tracks: " .. num_tracks)

-- Get the position of the edit cursor
cursor_pos = reaper.GetCursorPosition()

-- Iterate over each selected track
for i = 0, num_tracks-1 do
    -- Get the track
    track = reaper.GetSelectedTrack(0, i)
    --debugMsg("Selected track is " .. i)

    if track == nil then
        debugMsg("Failed to get track " .. i)
        
    else
        -- debugMsg("Got track " .. i)

        -- Add a new MIDI item at the cursor position, 1/32 note long
        newItem = reaper.CreateNewMIDIItemInProj(track, cursor_pos, cursor_pos + 0.0625, false)
        -- debugMsg("after creating the midi item, the retval  is "..tostring(retval))

        if newItem == nil then
            -- debugMsg("Failed to create new MIDI item in track " .. i)
        else
            -- debugMsg("Created new MIDI item in track " .. i)

            -- Get the take from the new item
            take = reaper.GetMediaItemTake(newItem, 0)
            
            if take == nil then
                -- debugMsg("Failed to get active take for media item " .. i)
            else
                -- Insert a C4 note into the MIDI take
                local selected = false
                local muted = false
                local startppqpos = 0
                local endppqpos = 120 -- Adjust this value according to your project's PPQ setting
                local chan = 0
                local pitch = 72
                local vel = 127
                local noSort = false
                
                retval = reaper.MIDI_InsertNote(take, selected, muted, startppqpos, endppqpos, chan, pitch, vel, noSort)
                if retval == false then
                    -- debugMsg("Failed to add C4 note to media item " .. i)
                else
                    -- debugMsg("Added C4 note to media item " .. i)

                    -- Add the ReaSynth effect to the take
                    retval = reaper.TakeFX_AddByName(take, "ReaSynth (Cockos)", 1)

                    if retval == -1 then
                        -- debugMsg("Failed to add ReaSynth to media item " .. i)
                    else
                        -- debugMsg("Added ReaSynth to media item " .. i .. " at FX index " .. retval)
                    end
                end
            end
        end
    end
end

-- Refresh the Reaper UI
reaper.UpdateArrange()
reaper.Undo_EndBlock("BJ_Add MIDI Beep to selected Tracks at Edit Cursor", -1)
-- End undo block, name it "BJ_Add MIDI Beep to selected Tracks at Edit Cursor"

