--[[
 * @description BJ_Create 500 Items
 * @version 1.0
 * @author Mike DelGaudio
 * @authorURI http://boothjunkie.com
 * @about
 *    This script simulates a long e-learning project for use in demonstrations bu adding 500 items on a track, separated by a few seconds of silence between items. 
 *    Select the track and place the edit cursor where you want to add the items, then run the script.
 * @donation https://www.buymeacoffee.com/boothjunkie
 * @license MIT
 * @reaper 6.0
]]


-- Define the function to create empty items on the active track
function create_empty_items_on_active_track(num_items, item_length, space_between)
    -- Get the currently selected track
    local track = reaper.GetSelectedTrack(0, 0)
    
    if not track then
        reaper.ShowMessageBox("No track selected. Please select a track.", "Error", 0)
        return
    end
    
    -- Initial position
    local position = reaper.GetCursorPosition()
    
    for i = 1, num_items do
        -- Create empty item
        reaper.CreateNewMIDIItemInProj(track, position, position + item_length, false)
        
        -- Update position for next item
        position = position + item_length + space_between
    end
end

-- Create 500 5-second items with 3 seconds of space in between
create_empty_items_on_active_track(500, 5, 3)

