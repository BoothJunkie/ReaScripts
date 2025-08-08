--[[
 * @description BJ_Add Last Region to RRM (Master)
 * @version 1.0
 * @author Mike DelGaudio
 * @authorURI http://boothjunkie.com
 * @donation https://www.buymeacoffee.com/boothjunkie
 * @license MIT
 * @about
 *    Adds the most recently created region to the Region Render Matrix for the Master track.
 *    Intended for workflows like audiobook pickups, where each region is rendered individually.
 *    Used in tandem with BJ_Clear RRM - All Tracks to progressively build a custom render queue.
 * @reaper 6.0
]]


-- Function to select the most recent region in the Region Render Matrix
function select_latest_region_for_master_mix()
    local retval, num_markers, num_regions = reaper.CountProjectMarkers(0)
    
    local last_region_index = -1
    local last_region_number = -1

    -- Iterate through all regions to find the most recent one
    for i = 0, num_markers + num_regions - 1 do
        local retval, isrgn, pos, rgnend, name, markrgnindexnumber = reaper.EnumProjectMarkers(i)
        if isrgn and markrgnindexnumber > last_region_number then
            last_region_number = markrgnindexnumber
            last_region_index = i
        end
    end

    if last_region_index ~= -1 then
        -- Set the latest region for Master Mix rendering
        reaper.SetRegionRenderMatrix(0, last_region_number, reaper.GetMasterTrack(0), 1)
    end
end

reaper.Undo_BeginBlock()
select_latest_region_for_master_mix()
reaper.Undo_EndBlock("Mark Latest Region for Master Mix", -1)

