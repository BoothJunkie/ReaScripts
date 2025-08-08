--[[
 * @description BJ_Quick Markers (Accessible Dockable Interface)
 * @version 2.2
 * @author Mike DelGaudio
 * @authorURI http://boothjunkie.com
 * @about
 *    Adds markers with predefined, color-coded keywords via a dockable GUI.
 *    Includes prompt mode for additional context and colorblind-friendly visual design.
 * @donation https://www.buymeacoffee.com/boothjunkie
 * @license MIT
 * @reaper 6.0
]]


-- Begin Undo Block
reaper.Undo_BeginBlock()

-- ===========================
-- Configuration
-- ===========================

local marker_types = {
    { keyword = "breath", color = reaper.ColorToNative(0, 158, 115) | 0x1000000 }, -- Teal
    { keyword = "pron",   color = reaper.ColorToNative(86, 180, 233) | 0x1000000 }, -- Blue
    { keyword = "click",  color = reaper.ColorToNative(230, 159, 0) | 0x1000000 }, -- Orange
    { keyword = "noise",  color = reaper.ColorToNative(213, 94, 0) | 0x1000000 },  -- Red
    { keyword = "pace",   color = reaper.ColorToNative(204, 121, 167) | 0x1000000 }, -- Purple
    { keyword = "volume", color = reaper.ColorToNative(0, 114, 178) | 0x1000000 }, -- Dark Blue
    { keyword = "retake", color = reaper.ColorToNative(86, 180, 233) | 0x1000000 }, -- Sky Blue
    { keyword = "fade",   color = reaper.ColorToNative(204, 121, 167) | 0x1000000 }, -- Pink
    { keyword = "cut",    color = reaper.ColorToNative(140, 140, 140) | 0x1000000 }, -- Gray
    { keyword = "note",   color = reaper.ColorToNative(240, 228, 66) | 0x1000000 }  -- Yellow
}

-- ===========================
-- GUI Variables
-- ===========================

local window_open = true
local mouse_down = false -- Debounce flag
local fallback_icon = "+" -- Icon for prompt mode

-- ===========================
-- Help Function
-- ===========================

function show_help()
    local help_text = [[
Quick Markers Script - Help

Features:
1. Quick Markers:
   - Click any button to add a marker with a predefined keyword and color.

2. Prompted Markers:
   - Hold SHIFT and click a button to add extra text to the marker.
   - Example: Clicking 'RETAKE' with SHIFT and entering 'happy' creates: RETAKE - happy.

3. Visual Feedback:
   - Buttons display a '+' icon when SHIFT is held to indicate "Prompt Mode."

Accessibility:
- Uses colorblind-friendly colors for maximum visibility.
- Dynamic text contrast ensures readability on all button colors.

Feedback:
- Contact the script author for suggestions or improvements.
]]

    reaper.ShowConsoleMsg(help_text)
end

-- ===========================
-- GUI Functions
-- ===========================

function init_window()
    gfx.init("Quick Markers", 200, 550, 1)  -- Dockable window, fixed height for help button
    gfx.clear = 3355443  -- Background color
    gfx.setfont(1, "Arial", 14) -- Default font
end

function draw_contrasting_text(x, y, text, r, g, b)
    -- Calculate brightness and set text color (black or white)
    local brightness = (r * 299 + g * 587 + b * 114) / 1000
    gfx.set(brightness > 0.5 and 0 or 1, brightness > 0.5 and 0 or 1, brightness > 0.5 and 0 or 1, 1)
    gfx.x, gfx.y = x, y
    gfx.drawstr(text)
end

function draw_button(x, y, w, h, label, color, is_shift_pressed, is_help)
    local r, g, b

    if is_help then
        -- Style for Help Button (Neutral Gray)
        r, g, b = 0.6, 0.6, 0.6
    else
        -- Marker Colors
        r, g, b = reaper.ColorFromNative(color & 0xFFFFFF)
        r, g, b = r/255, g/255, b/255
    end

    local gui_label = label
    if is_shift_pressed and not is_help then
        gui_label = gui_label .. " " .. fallback_icon -- Add "+" icon for prompt mode
    end

    -- Draw button
    gfx.set(r, g, b, 1)
    gfx.rect(x, y, w, h, true)
    gfx.set(r*0.8, g*0.8, b*0.8, 1)
    gfx.rect(x, y, w, h, false)
    local text_x = x + (w - gfx.measurestr(gui_label)) / 2
    local text_y = y + (h - gfx.texth) / 2

    -- Ensure text contrast for readability
    draw_contrasting_text(text_x, text_y, gui_label, r*255, g*255, b*255)

    -- Click detection with debounce
    if gfx.mouse_cap & 1 == 1 then
        if not mouse_down and gfx.mouse_x >= x and gfx.mouse_x <= x + w and gfx.mouse_y >= y and gfx.mouse_y <= y + h then
            mouse_down = true
            if is_help then
                show_help()
            else
                -- Marker Creation Code
                local position = reaper.GetCursorPosition()
                local marker_text = label

                -- Prompt for additional text if SHIFT is pressed
                if is_shift_pressed then
                    local retval, user_input = reaper.GetUserInputs("Add Marker", 1, "Marker Text:", "")
                    if retval and user_input ~= "" then
                        marker_text = marker_text .. " - " .. user_input
                    end
                end

                -- Add marker with color
                reaper.AddProjectMarker2(0, false, position, 0, marker_text, -1, color)
            end
        end
    else
        mouse_down = false
    end
end

function main()
    gfx.clear = 3355443
    local width, height = gfx.w, gfx.h
    local btn_height, spacing = 30, 5
    local start_y, btn_width = 10, width - 20
    local is_shift_pressed = gfx.mouse_cap & 8 ~= 0

    for i, marker in ipairs(marker_types) do
        local y_pos = start_y + (i-1) * (btn_height + spacing)
        draw_button(10, y_pos, btn_width, btn_height, marker.keyword:upper(), marker.color, is_shift_pressed, false)
    end

    -- Small Help Button
    draw_button(width - 30, height - 35, 20, 20, "?", 0x808080, false, true)

    gfx.update()
    if gfx.getchar() >= 0 then
        reaper.defer(main)
    end
end

init_window()
main()

-- End Undo Block
reaper.Undo_EndBlock("Add Quick Marker", -1)

