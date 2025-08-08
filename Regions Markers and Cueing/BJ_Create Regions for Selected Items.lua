--[[
 * @description BJ_Create Regions for Selected Items
 * @version 1.0
 * @author Mike DelGaudio
 * @authorURI http://boothjunkie.com
 * @donation https://www.buymeacoffee.com/boothjunkie
 * @license MIT
 * @about
 *    Creates a region for each selected media item in the project.
 *    Useful when preparing externally delivered audio files for editing, QA, or region-based rendering.
 * @reaper 6.0
]]


-- Begin Undo block
reaper.Undo_BeginBlock()

-- Get the total number of selected items
local numSelectedItems = reaper.CountSelectedMediaItems(0)

-- Check if there are any selected items
if numSelectedItems == 0 then
  reaper.ShowMessageBox("No items selected. Please select items and try again.", "Error", 0)
else
  -- Loop through all selected items
  for i = 0, numSelectedItems - 1 do
    -- Get the current media item
    local item = reaper.GetSelectedMediaItem(0, i)

    -- Get the item's start and end positions
    local itemStart = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
    local itemLength = reaper.GetMediaItemInfo_Value(item, "D_LENGTH")
    local itemEnd = itemStart + itemLength

    -- Create a region for the item
    reaper.AddProjectMarker2(0, true, itemStart, itemEnd, "", -1, 0)
  end
end

-- End Undo block
reaper.Undo_EndBlock("BJ_Create Regions for Selected Items", -1)

-- Update the arrangement view
reaper.UpdateArrange()


