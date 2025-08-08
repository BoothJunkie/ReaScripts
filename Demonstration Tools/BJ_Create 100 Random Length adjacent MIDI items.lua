--[[
 * @description BJ_Create 100 random length adjacent MIDI Items
 * @version 1.0
 * @author Mike DelGaudio
 * @authorURI http://boothjunkie.com
 * @about
 *    This script simulates a recorded and edited chapter in an audiobook or e-learning project for use in demonstrations.
 *    Select the track and place the edit cursor where you want to add the items, then run the script.
 * @donation https://www.buymeacoffee.com/boothjunkie
 * @license MIT
 * @reaper 7.0
]]



function CreateRandomMIDIItemsWithCrossfade()
  -- Get the active project
  local project = reaper.EnumProjects(-1)
  
  -- Get the selected track (assumes the first selected track)
  local selectedTrack = reaper.GetSelectedTrack(project, 0)
  
  -- If no track is selected, select the first track
  if not selectedTrack then
    selectedTrack = reaper.GetTrack(project, 0)
    if selectedTrack then
      reaper.SetOnlyTrackSelected(selectedTrack)
      reaper.ShowMessageBox("No track was selected. Automatically selected the first track.", "Debug", 0)
    else
      reaper.ShowMessageBox("No tracks available in the project.", "No Tracks", 0)
      return
    end
  end
  
  -- Get the current play cursor position
  local cursorPosition = reaper.GetCursorPosition()
  
  -- reaper.ShowMessageBox("starting to create MIDI items", "Debug", 0)
  -- Begin undo block
  reaper.Undo_BeginBlock()
  
  -- Create 100 MIDI items
  for i = 1, 100 do
    -- Generate a random length between 5 and 30 seconds
    local itemLength = math.random(5, 30)
    
    -- Calculate the crossfade time in seconds (10 milliseconds)
    local crossfadeTime = 0.01
    
    -- Create a new MIDI item on the selected track
    local newItem = reaper.CreateNewMIDIItemInProj(selectedTrack, cursorPosition - crossfadeTime, cursorPosition + itemLength)
    
    -- Update the cursor position for the next item
    cursorPosition = cursorPosition + itemLength - crossfadeTime
    
  
  end
  --reaper.ShowMessageBox("Created MIDI items", "Debug", 0)
  -- End undo block
  reaper.Undo_EndBlock("Create 100 Random MIDI Items with Crossfade", -1)
  
  -- Update the arrangement view
  reaper.UpdateArrange()
  
  --reaper.ShowMessageBox("Script completed.", "Debug", 0)
end

-- Run the script
CreateRandomMIDIItemsWithCrossfade()







