--[[
 * @description BJ_Create Regions for Selected Items (Named by Filename)
 * @version 1.0
 * @author Mike DelGaudio
 * @authorURI http://boothjunkie.com
 * @donation https://www.buymeacoffee.com/boothjunkie
 * @license MIT
 * @about
 *    Creates a region for each selected media item, naming each region using the item’s source filename.
 *    Ideal for batch organizing externally delivered assets like ADR, VO pickups, or dialogue chunks.
 * @reaper 6.0
]]

-- Start undo block
reaper.Undo_BeginBlock()

-- Get number of selected items
local itemCount = reaper.CountSelectedMediaItems(0)

for i = 0, itemCount - 1 do
  local item = reaper.GetSelectedMediaItem(0, i)
  local take = reaper.GetActiveTake(item)

  if take and not reaper.TakeIsMIDI(take) then
    local source = reaper.GetMediaItemTake_Source(take)
    local sourcePath = reaper.GetMediaSourceFileName(source, "")
    local filename = sourcePath:match("^.+[\\/](.+)$") or sourcePath

    local pos = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
    local len = reaper.GetMediaItemInfo_Value(item, "D_LENGTH")

    reaper.AddProjectMarker2(0, true, pos, pos + len, filename, -1, 0)
  end
end

-- End undo block
reaper.Undo_EndBlock("Create regions for selected items using filenames", -1)

