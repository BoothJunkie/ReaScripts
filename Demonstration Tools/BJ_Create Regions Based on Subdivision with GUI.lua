-- @description Create Regions Based on Subdivision with GUI
-- @version 1.1
-- @changelog Added ReaImGui-based GUI for selecting subdivisions
-- @about
--   # Create Regions Based on Subdivision with GUI
--   This script creates consecutive regions for each beat in a measure based on user-defined subdivisions within a selected time range in Reaper.
--   Subdivisions include whole, half, quarter, eighth, sixteenth, thirty-second, and sixty-fourth notes.
--   To use, make a time selection in the ruler, run the script, and select the desired subdivision value from the GUI.

-- Load ReaImGui
if not reaper.ImGui_CreateContext then
    reaper.ShowMessageBox("ReaImGui not found. Please ensure ReaImGui is installed via ReaPack.", "Error", 0)
    return
end

local ctx = reaper.ImGui_CreateContext('Create Regions Based on Subdivision', 0)

-- Check if all necessary ReaImGui functions are available
local required_functions = {
    'ImGui_CreateContext',
    'ImGui_DestroyContext',
    'ImGui_NewFrame',
    'ImGui_EndFrame',
    'ImGui_Render',
    'ImGui_ShowDemoWindow',
    'ImGui_Begin',
    'ImGui_End',
    'ImGui_Text',
    'ImGui_BeginCombo',
    'ImGui_EndCombo',
    'ImGui_Selectable',
    'ImGui_Button'
}

for _, func in ipairs(required_functions) do
    if not reaper[func] then
        reaper.ShowMessageBox("ReaImGui function " .. func .. " not found. Please ensure ReaImGui is installed and up-to-date.", "Error", 0)
        return
    end
end

-- Define valid subdivisions
local subdivisions = {1, 2, 4, 8, 16, 32, 64}
local subdivision_labels = {"Whole", "Half", "Quarter", "Eighth", "Sixteenth", "Thirty-second", "Sixty-fourth"}
local selected_subdivision = 3  -- Default to "Quarter"

-- Main function to create regions
local function create_regions(subdivision)
    -- Get the time selection
    local start_time, end_time = reaper.GetSet_LoopTimeRange(false, false, 0, 0, false)

    -- Ensure there is a time selection
    if start_time ~= end_time then
        -- Begin the undo block
        reaper.Undo_BeginBlock()

        -- Get the project tempo
        local bpm = reaper.Master_GetTempo()

        -- Calculate the length of one beat in seconds
        local beat_length = 60 / bpm

        -- Calculate the length of the selected note in seconds
        local selected_note_length = beat_length * (4 / subdivision)

        -- Initialize the start of the region
        local region_start = start_time

        -- Create regions for each selected note length within the time selection
        while region_start < end_time do
            local region_end = region_start + selected_note_length
            reaper.AddProjectMarker2(0, true, region_start, region_end, "", -1, 0)
            region_start = region_end
        end

        -- End the undo block
        reaper.Undo_EndBlock("Create Regions Based on Subdivision", -1)
    else
        reaper.ShowMessageBox("Please make a time selection in the ruler.", "Error", 0)
    end

    reaper.UpdateArrange()
end

-- GUI loop function
local function loop()
    -- Start new frame
    reaper.ImGui_NewFrame(ctx)

    -- Create a new window
    if reaper.ImGui_Begin(ctx, 'Create Regions Based on Subdivision', true) then
        -- Dropdown menu for subdivisions
        reaper.ImGui_Text(ctx, 'Select Subdivision:')
        if reaper.ImGui_BeginCombo(ctx, 'Subdivision', subdivision_labels[selected_subdivision]) then
            for i = 1, #subdivision_labels do
                if reaper.ImGui_Selectable(ctx, subdivision_labels[i], i == selected_subdivision) then
                    selected_subdivision = i
                end
            end
            reaper.ImGui_EndCombo(ctx)
        end

        -- Create Regions button
        if reaper.ImGui_Button(ctx, 'Create Regions') then
            create_regions(subdivisions[selected_subdivision])
        end

        reaper.ImGui_End(ctx)
    end

    -- Render the frame
    reaper.ImGui_Render(ctx)

    -- Schedule the next loop iteration
    reaper.defer(loop)
end

-- Start the loop
loop()

