--[[
 * @description BJ_Insert 30 Seconds of Space Between Selected Items
 * @version 1.0
 * @author Mike DelGaudio
 * @authorURI http://boothjunkie.com
 * @donation https://www.buymeacoffee.com/boothjunkie
 * @license MIT
 * @about
 *    Shifts selected media items so that each has 30 seconds of space between it and the next.
 *    Especially useful after importing VO chunks or external takes where visual clarity is needed before region creation.
 * @reaper 6.0
]]


-- Start undo block
reaper.Undo_BeginBlock()

local num_items = reaper.CountSelectedMediaItems(0)
if num_items < 2 then
  reaper.MB("Please select at least two items.", "Insert Blank Space", 0)
  return
end

-- Collect items in a table
local items = {}
for i = 0, num_items - 1 do
  local item = reaper.GetSelectedMediaItem(0, i)
  local pos = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
  table.insert(items, {item = item, pos = pos})
end

-- Sort items by position
table.sort(items, function(a, b) return a.pos < b.pos end)

local space = 30 -- seconds of blank space
local time_offset = 0

for i = 2, #items do
  local prev = items[i - 1]
  local current = items[i]
  local prev_end = reaper.GetMediaItemInfo_Value(prev.item, "D_POSITION") +
                   reaper.GetMediaItemInfo_Value(prev.item, "D_LENGTH")
  local new_pos = prev_end + space
  reaper.SetMediaItemInfo_Value(current.item, "D_POSITION", new_pos)
end

reaper.UpdateArrange()
reaper.Undo_EndBlock("Insert 30 seconds of space between selected items", -1)

