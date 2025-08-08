--[[ 
* @description BJ_Item Creator (Configurable Item Generator)
*@version 1.4
* @author Mike DelGaudio
* @authorURI http://boothjunkie.com
* @about
*  This script creates either MIDI or empty items on the active track based on user input.
*   The user can specify the item type (1 for MIDI, 2 for empty), number of items, item length, space between items, whether to create regions, item name pattern, and see help for item patterns.
*   The item name pattern can include a base name with a placeholder for numbering (e.g., "Item %02d" for zero-padded numbers).
* @donation https://www.buymeacoffee.com/boothjunkie
* @license MIT
* @reaper 6.0
--]]

-- Prompt user for input
local captions = "Item type (1 for MIDI, 2 for empty),Number of items,Item length (seconds),Space between (seconds),Create regions? (1=yes, 0=no),Item name pattern,Item pattern help,extrawidth=250"
local default_values = "1,500,5,3,0,Item %02d,No Padding:'%d' · Pad w/zeros (ex: 01):'%02d' or (021):'%03d' etc"

local retval, user_input = reaper.GetUserInputs("Create Items", 7, captions, default_values)

if not retval then return end -- If the user cancels, exit the script

-- Split the user input into variables
local item_type, num_items, item_length, space_between, create_regions, item_name_pattern, item_pattern_help = user_input:match("([^,]+),([^,]+),([^,]+),([^,]+),([^,]+),([^,]+),([^,]+)")

-- Convert the input strings to numbers
item_type = tonumber(item_type)
num_items = tonumber(num_items)
item_length = tonumber(item_length)
space_between = tonumber(space_between)
create_regions = tonumber(create_regions)

-- Validate item type
if item_type ~= 1 and item_type ~= 2 then
    reaper.ShowMessageBox("Invalid item type. Please specify either '1' for MIDI or '2' for empty.", "Error", 0)
    return
end

-- Validate create regions input
if create_regions ~= 0 and create_regions ~= 1 then
    reaper.ShowMessageBox("Invalid input for creating regions. Please specify either '1' for yes or '0' for no.", "Error", 0)
    return
end

-- Function to create items on the active track with naming patterns and optional regions
function create_items_on_active_track(item_type, num_items, item_length, space_between, create_regions, item_name_pattern)
    -- Get the currently selected track
    local track = reaper.GetSelectedTrack(0, 0)
    
    if not track then
        reaper.ShowMessageBox("No track selected. Please select a track.", "Error", 0)
        return
    end
    
    -- Start undo block
    reaper.Undo_BeginBlock()
    
    -- Initial position
    local position = reaper.GetCursorPosition()
    
    for i = 1, num_items do
        local item
        if item_type == 1 then
            -- Create MIDI item
            item = reaper.CreateNewMIDIItemInProj(track, position, position + item_length, false)
        elseif item_type == 2 then
            -- Create empty item
            item = reaper.AddMediaItemToTrack(track)
            reaper.SetMediaItemInfo_Value(item, "D_POSITION", position)
            reaper.SetMediaItemInfo_Value(item, "D_LENGTH", item_length)
        end
        
        -- Optionally set item name based on pattern
        local item_name = ""
        if item_name_pattern ~= "" and item then
            item_name = string.format(item_name_pattern, i)
            reaper.ULT_SetMediaItemNote(item, item_name)
        end

        -- Optionally create region around item
        if create_regions == 1 then
            reaper.AddProjectMarker2(0, true, position, position + item_length, item_name, -1, 0)
        end
        
        -- Update position for next item
        position = position + item_length + space_between
    end
    
    -- End undo block
    reaper.Undo_EndBlock("Create Items on Active Track", -1)
end

-- Call the function with user input
create_items_on_active_track(item_type, num_items, item_length, space_between, create_regions, item_name_pattern)
