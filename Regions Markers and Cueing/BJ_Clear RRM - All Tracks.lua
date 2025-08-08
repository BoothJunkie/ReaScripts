--[[
 * @description BJ_Clear RRM - All Tracks
 * @version 1.1
 * @author Mike DelGaudio
 * @authorURI http://boothjunkie.com
 * @donation https://www.buymeacoffee.com/boothjunkie
 * @license MIT
 * @about
 *    Clears all region-to-track assignments in the Region Render Matrix.
 *    Useful for resetting export states in large, complex sessions.
 * @reaper 6.0
]]

-- Function to clear all selections in the Region Render Matrix for all tracks
function clear_all_region_render_matrix()
    -- Count the number of markers and regions in the project
    local retval, num_markers, num_regions = reaper.CountProjectMarkers(0)
    
    -- Iterate through all regions
    for i = 0, num_markers + num_regions - 1 do
        local retval, isrgn, pos, rgnend, name, markrgnindexnumber = reaper.EnumProjectMarkers(i)
        if isrgn then
            -- Iterate through all tracks in the project
            local num_tracks = reaper.CountTracks(0)
            for j = 0, num_tracks - 1 do
                local track = reaper.GetTrack(0, j)
                -- Unselect the region in the Region Render Matrix for the current track
                reaper.SetRegionRenderMatrix(0, markrgnindexnumber, track, -1)
            end
            -- Also unselect the region for the master track
            reaper.SetRegionRenderMatrix(0, markrgnindexnumber, reaper.GetMasterTrack(0), -1)
        end
    end
end

-- Begin undo block
reaper.Undo_BeginBlock()

-- Execute the function
clear_all_region_render_matrix()

-- End undo block with a descriptive name
reaper.Undo_EndBlock("Clear All Selections in Region Render Matrix (All Tracks)", -1)
