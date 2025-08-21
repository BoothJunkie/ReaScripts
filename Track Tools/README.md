### BJ_CreateNewTrackWithColorAfterFirstSelectedTrack

Inserts a new track **after the first selected track** and assigns it a **random color**.

**Use case:**  
Helpful when building organized sessions and you want new tracks to stand out visually or follow a coloring scheme.

**Behavior:**
- Inserts a single new track after the first selected track.
- If multiple tracks are selected, it still inserts only one — after the **topmost** selected one.
- If no tracks are selected, inserts the new track at the top of the project.
- The new track receives a randomly generated color.

**How to use:**
1. Select a track in the track list.
2. Run the script.
3. A new track appears below the selection, colored randomly.

Or, go to Options -> Customize Menu / Toolbars, and add this action to the Track Control Panel context.
---
### BJ_CreateNewTrackWithColorAsFirstTrack

Inserts a new track at the **top of the project** and gives it a **random color**.

**Use case:**  
Useful when building projects that follow a layered or grouped track organization and want to clearly mark the first/top track (e.g., mix buses, master markers, etc.).

**Behavior:**
- Always inserts the new track as the first/top track (index 0).
- Randomizes the track’s color.
- No selection required before running.

**How to use:**
Just run the script. A new colored track appears at the top of the project.
Or, go to Options -> Customize Menu / Toolbars, and add this action to the Track Control Panel context.
---
### BJ_CreateNewTrackWithColorAsLastTrack

Inserts a new track at the **bottom of the project** and gives it a **random color**.

**Use case:**  
Useful when working on large sessions and you want new tracks to appear at the end for routing, scratchpads, or overflow — and easily visible due to randomized color.

**Behavior:**
- Inserts one new track at the very end of the current project.
- Assigns a random color to the new track.
- No selection needed before running.

**How to use:**
Run the script. A new colored track appears as the last track in the project.
Or, go to Options -> Customize Menu / Toolbars, and add this action to the Track Control Panel context.

## Track Heights
I map these to key strokes for quick resizing of tracks that are optimized for my screen. 

### BJ_Set Selected Tracks to Custom Height

This is a **template script** for setting selected track(s) to a specific height of your choice.

**Use case:**  
Ideal for users who want to create multiple custom track height scripts for different workflows (e.g., one for voiceover editing, another for mixing, etc.).

**How to use:**
1. Open the script in REAPER's built-in script editor.
2. Change the value of `preferred_height = 500` at the top to your desired height in pixels.
3. Save the script under a new name (e.g., `BJ_Set Track Height to 420.lua`).
4. Run the action to set selected tracks to that custom height.

**Pro tip:**  
This script is the foundation for the other `Tiny`, `Small`, `Medium`, `Large`, and `XL` height scripts in this folder.

---
### BJ_Set Selected Track Height to XL

Expands selected tracks to a height of **500 pixels**, maximizing visibility for detailed editing or focused track work.

**Use case:**  
Great for voice editing, comping, or any situation where you want one or more tracks to dominate the vertical view.

**Behavior:**
- Sets all selected tracks to 500px in height.
- Automatically adjusts the arrange window layout.

**How to use:**
1. Select one or more tracks.
2. Run the script.
3. The selected tracks will become extra tall.

---
### BJ_Set Selected Track Height to Large

Sets all selected tracks to a height of **300 pixels**, which is useful for tasks like editing with free item positioning or focusing on a specific track.


**Use case:**  
Ideal when you want to temporarily expand a track for detailed work without manually dragging its edge.

**Behavior:**
- Affects all currently selected tracks.
- Sets height override to 300 pixels.
- Automatically updates the track view.

**How to use:**
You can edit the script with your designed height for your screen size. 
1. Select one or more tracks.
2. Run the script.
3. Tracks will resize vertically.
---
### BJ_Set Selected Track Height to Medium

Sets all selected tracks to a height of **200 pixels**, ideal for working with a moderate amount of screen space.

**Use case:**  
Useful when you want a balance between visibility and conserving screen real estate, especially in multitrack sessions.

**Behavior:**
- Changes height override to 200 pixels.
- Affects all currently selected tracks.
- Refreshes the track list window layout.

**How to use:**
You can edit the script with your designed height for your screen size. 
1. Select one or more tracks.
2. Run the script.
3. Track heights will be set to medium size.
---
### BJ_Set Selected Track Height to Small

Sets all selected tracks to a height of **100 pixels**, useful for conserving screen space or when working with many tracks simultaneously.

**Use case:**  
Ideal for mixing or session management views where track detail isn’t needed but compact visibility is.

**Behavior:**
- Affects all selected tracks.
- Sets the height override to 100 pixels.
- Automatically updates the arrange view.

**How to use:**
You can edit the script with your designed height for your screen size. 
1. Select one or more tracks.
2. Run the script.
3. Tracks shrink to small height.
---
### BJ_Set Selected Track Height to Tiny

Shrinks all selected tracks to a height of **30 pixels**, ideal for keeping your arrange view compact and navigable in large sessions.

**Use case:**  
Perfect for voice actors or editors working with many tracks where visual clarity matters more than detail at a given moment.

**Behavior:**
- Affects all selected tracks.
- Sets the height override to 30 pixels.
- Instantly updates the UI layout.

**How to use:**
You can edit the script with your designed height for your screen size. 
1. Select any number of tracks.
2. Run the script.
3. Tracks will resize to a minimal height.
---
### BJ_Set Selected Track Height to Default

Resets all selected tracks to REAPER’s **default height behavior** by clearing any explicit height overrides.

**Use case:**  
After using custom height presets (Tiny, Medium, XL, etc.), this script returns tracks to their auto-managed height for cleaner layout control.

**Behavior:**
- Affects all selected tracks.
- Sets the height override to `0`, allowing REAPER to determine height.
- Automatically refreshes the track view.

**How to use:**
1. Select the tracks you want to reset.
2. Run the script.
3. Heights will return to REAPER’s default.

---
### BJ_Set All Tracks to Defined Height

Sets the height of **every track in the project** to a custom-defined pixel value.

**Use case:**  
Ideal for standardizing the layout of a large session with many tracks. This helps enforce visual consistency or prep for specific editing/mixing views.

**Configuration:**
- Open the script.
- Edit the line: `local defaultHeight = 200`
- Save the script under a name that reflects the height (e.g., "Set All Tracks to 150")

**Behavior:**
- Loops through all tracks and sets the height override to the configured value.
- Automatically updates the arrange view.
- Wraps the change in an undo block for safety.

**How to use:**
1. Edit the `defaultHeight` value at the top of the script if needed.
2. Save and run the script.
3. All tracks will be resized accordingly.
---
### BJ_Set Selected Tracks to Random Colors

Applies a **unique random color** to each selected track. Great for quickly identifying and organizing sections of your project.

**Use case:**  
Perfect for large sessions with many similar tracks, such as dialogue-heavy projects, multi-voice podcasts, or scratch takes.

**Behavior:**
- Iterates through selected tracks
- Assigns each a unique color using Reaper's native track color system

**How to use:**
1. Select one or more tracks.
2. Run the script.
3. Watch your session become more readable.

**Tip:**  
Use alongside track naming or grouping tools for even clearer project structure.
---
### BJ_Set Selected Tracks to Default Color

Reverts any custom-colored tracks back to Reaper's **default track color**.

**Use case:**  
You've colored tracks for clarity or testing but want to restore them to a clean, uniform look.

**Behavior:**
- Iterates through selected tracks
- Resets the custom color to default (no color override)

**How to use:**
1. Select one or more tracks.
2. Run the script.
3. All selected tracks will reset to Reaper’s default coloring.

**Pro Tip:**  
Use this after running `BJ_Set Selected Tracks to Random Colors` to quickly undo all color changes.

~Q~
