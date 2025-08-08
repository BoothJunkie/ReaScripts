--[[
 * @description BJ_Move Edit Cursor to Timestamp Relative to Current Region (with Marker Prompt)
 * @version 1.0
 * @author Mike DelGaudio
 * @authorURI http://boothjunkie.com
 * @donation https://www.buymeacoffee.com/boothjunkie
 * @license MIT
 * @about
 *    Prompts you for a mm:ss timestamp relative to the current region,
 *    then moves the edit cursor to that offset and optionally opens the marker dialog.
 *    Perfect for audiobook pickups or long-form review, where corrections reference
 *    a chapter-based timeline.
 * @reaper 6.0
]]


function main()

  -- Prompt for timestamp (mm:ss)
  local ok, timestr = reaper.GetUserInputs("Pickup timestamp", 1, "Time in mm:ss", "")
  if not ok or timestr == "" then return end

  -- Parse timestamp
  local min, sec = timestr:match("^(%d+):(%d+)$")
  if not min then
    reaper.ShowMessageBox("Invalid time format. Use mm:ss.", "Error", 0)
    return
  end
  local offset_sec = tonumber(min) * 60 + tonumber(sec)

  -- Get edit cursor position
  local cursor_pos = reaper.GetCursorPosition()

  -- Scan all regions to find one containing the cursor
  local retval, num_markers, num_regions = reaper.CountProjectMarkers(0)
  local region_found = false
  for i = 0, num_markers + num_regions - 1 do
    local retval, isrgn, pos, rgnend, name, idx = reaper.EnumProjectMarkers(i)
    if isrgn and cursor_pos >= pos and cursor_pos <= rgnend then
      -- Found the region
      local target_pos = pos + offset_sec
      reaper.SetEditCurPos(target_pos, true, false)
      -- Call REAPER's marker insertion/edit dialog
      reaper.Main_OnCommand(40171, 0)
      region_found = true
      break
    end
  end

  if not region_found then
    reaper.ShowMessageBox("Cursor is not inside any region.", "Error", 0)
  end

end

reaper.Undo_BeginBlock()
main()
reaper.Undo_EndBlock("Move edit cursor to pickup timestamp and add marker", -1)

