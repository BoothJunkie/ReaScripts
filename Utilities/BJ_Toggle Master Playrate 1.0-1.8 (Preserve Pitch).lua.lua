--[[
 * @description BJ_Toggle Master Playrate between 1.0 and 1.8 (Preserve Pitch)
 * @version 1.0
 * @author Mike DelGaudio
 * @authorURI http://boothjunkie.com
 * @donation https://www.buymeacoffee.com/boothjunkie
 * @license MIT
 * @about
 *    Toggles the master playrate between 1.0x and 1.8x speed while preserving pitch.
 *    Intended for rapid review of long-form recordings (e.g., audiobooks, e-learning).
 *    Pitch is preserved automatically on first run.
 * @reaper 6.0
]]

isPitchPreserved = reaper.GetToggleCommandState(40671)

-- Check if "Preserve pitch in audio items when changing master playrate" is off
if isPitchPreserved == 0 then 
    -- If it's off, turn it on
    reaper.Main_OnCommandEx(40671, 0, 1)
end

-- Check current playrate
currentPlayrate = reaper.Master_GetPlayRate(0)

-- Define a small tolerance for the playrate comparison
local tolerance = 0.01

-- If playrate is currently around 1.0, set it to 1.8; otherwise, set it back to 1.0
if math.abs(currentPlayrate - 1.0) < tolerance then
    reaper.CSurf_OnPlayRateChange(1.8)
else 
    reaper.CSurf_OnPlayRateChange(1.0)
end

