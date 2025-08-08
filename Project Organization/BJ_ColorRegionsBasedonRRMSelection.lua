--[[
 * @description BJ_ColorRegionsbasedonRRMSelection
 * @version 1.0
 * @author Mike DelGaudio
 * @authorURI http://boothjunkie.com
 * @about
 *    Will color regions to match the color of the track based on selection in the Region Render Matrix.
 *    Use the Region Render Matrix and select regions that you want colored the same as the track.
 *    This is helpful for projects with many regions on multiple tracks that need to be rendered according to the Region Render Matrix.
 *    If a region is selected on multiple tracks, the topmost track color takes precedence.
 * @donation https://www.buymeacoffee.com/boothjunkie
 * @license MIT
 * @reaper 6.0
]]


function ColorRegionsBasedOnRRM()
    -- Begin the undo block
    reaper.Undo_BeginBlock()

    local project = 0 -- Current project
    local _, numMarkers, numRegions = reaper.CountProjectMarkers(project)

    for i = 0, numMarkers + numRegions - 1 do
        local retval, isRegion, pos, rgnend, name, regionIndex = reaper.EnumProjectMarkers3(project, i)
        if isRegion then
            local trackIndex = 0
            while true do
                local track = reaper.EnumRegionRenderMatrix(project, regionIndex, trackIndex)
                if track == nil then break end

                local trackColor = reaper.GetMediaTrackInfo_Value(track, "I_CUSTOMCOLOR")
                if trackColor ~= 0 then
                    reaper.SetProjectMarkerByIndex(project, i, isRegion, pos, rgnend, regionIndex, name, trackColor)
                    break -- Assuming we color the region based on the first track found
                end

                trackIndex = trackIndex + 1
            end
        end
    end

    -- End the undo block
    reaper.Undo_EndBlock("Color Regions Based On RRM", -1)
end

ColorRegionsBasedOnRRM()

