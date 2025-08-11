--[[
 * @description Zoom to 5 seconds around edit cursor (2.5 seconds on each side)
 * @version 1.0
 * @author Mike DelGaudio
 * @authorURI http://boothjunkie.com
 * @donation https://www.buymeacoffee.com/boothjunkie
 * @license MIT
 * @about
 *   This script zooms the arrange view to a 5-second window centered around the edit cursor
 *   (2.5 seconds on each side). It prevents negative start times and updates the arrange view immediately.
 * @reaper 6.0
]]

function main()
    -- Get the current edit cursor position
    local cursor_pos = reaper.GetCursorPosition()
    
    -- Calculate start and end times for 5-second window  
    local zoom_duration = 5.0 -- Total duration in seconds
    local half_duration = zoom_duration / 2.0
    local start_time = cursor_pos - half_duration
    local end_time = cursor_pos + half_duration
    
    -- Ensure we don't go below zero
    
    if start_time < 0 then
        start_time = 0
        end_time = zoom_duration
    
    end
    
    -- Set the view to show this time range 
    reaper.GetSet_ArrangeView2(0, true, 0, 0, start_time, end_time)
    -- Update the display
    reaper.UpdateArrange()
    
    end
    
    -- Run the main function
    
    main()