--[[
 * @description BJ_Open Project Path in Finder / Explorer
 * @version 1.0
 * @author Mike DelGaudio
 * @authorURI http://boothjunkie.com
 * @donation https://www.buymeacoffee.com/boothjunkie
 * @license MIT
 * @about
 *    Opens the system file manager (Finder on macOS or Explorer on Windows) at the directory of the current project file.
 *    Replicates the familiar "Show in Finder" or "Open in Explorer" functionality common in many DAWs and apps.
 * @reaper 6.0
]]


-- Get the current project file path
proj_path = ""
_, proj_path = reaper.EnumProjects(-1, proj_path)

-- Extract the directory from the project path
project_dir = proj_path:match("^(.*[\\/])")

-- Check if the project path is valid
if project_dir == nil or project_dir == "" then
  reaper.ShowMessageBox("The project hasn't been saved yet.", "Error", 0)
else
  -- Platform-specific code to open the file manager
  if reaper.GetOS():find("OSX") then
    -- macOS: Open Finder at the project path
    os.execute('open "' .. project_dir .. '"')
  else
    -- Windows: Open Explorer at the project path
    os.execute('explorer "' .. project_dir .. '"')
  end
end

-- Mark the script for undo
reaper.Undo_BeginBlock()
reaper.Undo_EndBlock("Show in Finder/Explorer", -1)

