--[[
 * @description BJ_Delete Regions Within Time Selection
 * @version 1.0.2
 * @author Mike DelGaudio
 * @authorURI http://boothjunkie.com
 * @donation https://www.buymeacoffee.com/boothjunkie
 * @license MIT
 * @about
 *    Deletes any regions that are fully or partially within the current time selection.
 *    Useful for cleanup during revision, region replacement, or preparing pickups.
 * @reaper 6.0
]]

-- Begin undo block
reaper.Undo_BeginBlock()

-- Get the time selection
local time_sel_start, time_sel_end = reaper.GetSet_LoopTimeRange(false, false, 0, 0, false)

-- Print time selection boundaries
-- reaper.ShowConsoleMsg("Time selection: start=" .. time_sel_start .. ", end=" .. time_sel_end .. "\n")

-- Initialize a list to store regions to be deleted
local regions_to_delete = {}

-- Function to get and check regions
local function get_regions_to_delete()
    -- Get the number of regions and markers
    local _, num_markers, num_regions = reaper.CountProjectMarkers(0)
    
    -- Iterate through all regions and markers
    for i = 0, num_markers + num_regions - 1 do
        local retval, isrgn, pos, rgnend, name, markrgnindexnumber = reaper.EnumProjectMarkers(i)
        if isrgn then
            -- reaper.ShowConsoleMsg("Region " .. markrgnindexnumber .. ": pos=" .. pos .. ", rgnend=" .. rgnend .. "\n")
            if pos >= time_sel_start and rgnend <= time_sel_end then
                -- Region fully contained within time selection
                table.insert(regions_to_delete, markrgnindexnumber)
                --reaper.ShowConsoleMsg("  -> Fully contained, marked for deletion.\n")
            elseif pos >= time_sel_start and pos < time_sel_end then
                -- Region touches the start boundary of time selection
                table.insert(regions_to_delete, markrgnindexnumber)
               -- reaper.ShowConsoleMsg("  -> Touches start boundary, marked for deletion.\n")
            elseif rgnend > time_sel_start and rgnend <= time_sel_end then
                -- Region touches the end boundary of time selection
                table.insert(regions_to_delete, markrgnindexnumber)
                --reaper.ShowConsoleMsg("  -> Touches end boundary, marked for deletion.\n")
            end
        end
    end
end

-- Get the regions to delete
get_regions_to_delete()

-- Delete the regions in the list
for i = #regions_to_delete, 1, -1 do
    local region_index = regions_to_delete[i]
    --reaper.ShowConsoleMsg("Deleting region " .. region_index .. "\n")
    reaper.DeleteProjectMarker(0, region_index, true)
end

-- Update the arrange view to reflect the changes
reaper.UpdateArrange()

-- End undo block
reaper.Undo_EndBlock("Delete regions within time selection", -1)

