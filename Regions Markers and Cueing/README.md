

###BJ_YouTube Chapter Maker

Automatically generates YouTube chapter timestamps from your REAPER project markers. Creates properly formatted text files that can be copied directly into YouTube video descriptions. Supports both region-based workflows (for batch processing multiple videos) and timeline-based workflows (for single videos). Ensures YouTube compliance by automatically adding required 0:00 chapters and maintaining ascending timestamp order.

**How to use:**
* Place markers on your timeline starting with "CHAP=" followed by the chapter title (e.g., "CHAP=Introduction", "CHAP=Main Topic").
* **With Regions:** Create named regions to define video boundaries. Each region becomes a separate YouTube chapter file with timestamps relative to the region start.
* **Without Regions:** The script processes the entire timeline, using absolute timestamps from project start.
* Run the script.

The script creates:
* YOUTUBE-[RegionName].txt files (or YOUTUBE-[ProjectName].txt if no regions)
* Properly formatted timestamps (M:SS format) with chapter titles
* Automatic 0:00 chapter insertion using region/project name if no marker exists at start
* Opens your project folder automatically for easy file access

**Perfect for:** Content creators who need to quickly generate YouTube chapter timestamps from their video editing workflow in REAPER.

---
### BJ_Add MIDI Beep to selected Tracks at Edit Cursor

Adds a short MIDI note (C5) at the edit cursor using ReaSynth on selected tracks.  
Useful for creating audible cues or separators during playback or editing. This is especially useful for sending a rendered wav to an editor, and you want them to see in the waveform where breaks, or other dialogue for example should be inserted. 
Similar in concept to a snap or dog-clicker marker, but for a remote editor.

**How to use:**
- Move the edit cursor to where you want the beep.
- Select one or more tracks (or leave none selected — the script will auto-select the only track if only one exists).
- Run the script.

The script inserts:
- A 1/32-note MIDI item at the cursor
- A single C5 note (velocity 127)
- A ReaSynth instance for audible playback
  
---
### BJ_Quick Markers

A dockable graphical interface for adding markers with predefined labels and colors. Built for accessibility and speed, this script supports both one-click and prompt-based marker creation.

**Use case:**  
Designed for voice editors, audio producers, and directors to rapidly annotate timeline issues (breaths, noise, retakes, etc.) during playback or review.

**Features:**
- Colorblind-friendly, high-contrast marker buttons
- SHIFT+click any marker to add additional text ("RETAKE - happy")
- Help button provides quick onboarding
- Dockable and resizable GUI

**How to use:**
1. Run the script to open the GUI.
2. Click any button to drop a marker at the play/edit cursor.
3. SHIFT+Click to add custom text to the marker label.

---
### BJ_Clear RRM - All Tracks

Clears all render selections in the Region Render Matrix (RRM) for every region and every track in the project, including the master.

**Use case:**  
When preparing a new export pass or auditing your render matrix, this script resets everything to a clean slate, avoiding accidental renders or leftovers from prior sessions.
Particularly helpful if you're working on pickups and need to clear out old render selections from the last delivery. 

**Behavior:**
- Iterates through all regions in the project.
- Unassigns each region from every track and the master.
- Does not affect markers, items, or media content — just matrix state.

**How to use:**
1. Run the script.
2. All RRM checkboxes will be cleared.
3. Start fresh with new region-track render assignments.

---
### BJ_Add Last Region to RRM (Master)

Adds the **most recently created region** to the Region Render Matrix for the **Master track**.

**Use case:**  
When handling audiobook pickups, ADR, or iterative punch-ins, this script allows you to select each newly created region for export — one click per pickup.

**Behavior:**
- Scans the project for the most recently numbered region.
- Assigns that region to the master track in the render matrix.
- Leaves other region/track pairs untouched.

**How to use:**
1. Run `BJ_Clear RRM - All Tracks` to start clean.
2. As you record or define new regions, run this script once per region.
3. When you're done, render via Region Matrix – only the selected regions will be rendered.

**Pro Tip:**  
Can be used as a toolbar button to “Add Pickup to Export Queue.”

---
### BJ_Create Regions for Selected Items

Creates a **region for each selected media item** in the project.

**Use case:**  
Ideal when working with externally delivered audio (e.g., VO pickups, ADR chunks, podcast segments) where you need to quickly prepare content for review or rendering.

**Behavior:**
- Each selected media item becomes its own region
- Regions match the item's start and end times
- No names are applied — just blank regions

**How to use:**
1. Select any number of items across any tracks.
2. Run the script.
3. A region will appear over each one, ready for batch editing, markers, or RRM use.

**Tip:**  
For more advanced use (naming, color-coding), combine with your other region-related tools like `BJ_ColorRegionsBasedonRRMSelection`.

---
### BJ_Create Regions for Selected Items (Named by Filename)

Creates a **region for each selected item**, automatically naming the region after the media file.

**Use case:**  
Essential when working with batches of externally named media, like voiceover pickups, localization assets, or dialogue chunks, where filenames carry contextual meaning.

**Behavior:**
- Each selected item becomes a region
- Region names are taken from the item's source filename
- Regions span the exact duration of the items

**How to use:**
1. Select one or more items (non-MIDI).
2. Run the script.
3. Regions will appear named using the original file names.

**Tip:**  
Pair this with `BJ_Clear RRM - All Tracks` and `BJ_Add Last Region to RRM` for fast audiobook pickups or retake workflows.

---
### BJ_Delete Regions Within Time Selection

Deletes all regions that **fall within or touch** the current time selection.

**Use case:**  
Ideal when you’re re-doing a section of a project (e.g., audiobook pickups, music editing, VO retakes) and want to remove outdated or erroneous region definitions.

**Behavior:**
- Finds all regions fully or partially overlapping the current time selection
- Deletes them safely using indexed iteration
- Refreshes the Arrange view for immediate visual feedback

**How to use:**
1. Create a time selection over the area to clear.
2. Run the script.
3. All overlapping regions are removed — markers are untouched.

**Debugging Note:**  
This version includes optional print statements for troubleshooting. You can uncomment them in the script if needed.

---
### BJ_Insert 30 Seconds of Space Between Selected Items

Inserts **30 seconds of silence between each selected item** by shifting their positions in time.

**Use case:**  
Ideal after importing external VO/ADR chunks, where you want visual clarity between takes before creating regions or cueing markers.

**Behavior:**
- Works on any number of selected items
- Sorts by timeline order
- Leaves the first item in place and offsets all others by 30 seconds + previous item duration

**How to use:**
1. Select multiple items.
2. Run the script.
3. Items will be spaced 30 seconds apart on the timeline.

**Tip:**  
Combine with `BJ_Create Regions for Selected Items` or `BJ_Create Named Regions for Selected Items` for bulk organizing voiceover or ADR assets.

---
### BJ_Move Playhead to Start of Next Region and Start Playback

Moves the play cursor to the **start of the next region** in the timeline and begins playback automatically.

**Use case:**  
Ideal for rapidly checking chapter transitions, region-defined sections, or musical cues without manually navigating.

**Behavior:**
- Finds the next region in time order
- Jumps to its start position
- Starts playback
- Shows a message if no further region exists

**How to use:**
1. Place playhead anywhere.
2. Run the script.
3. Reaper will jump to the next region and start playback.

---

### BJ_Move Playhead to Start of Previous or Current Region and Start Playback

Moves the play cursor to the **start of the previous or current region** and starts playback.

**Use case:**  
Perfect for rehearsing or reviewing takes in a region-organized session, particularly if you need to work backwards through content.

**Behavior:**
- Finds the closest region whose start is at or before the current play position
- Jumps to its start
- Starts playback
- Shows a message if no earlier region is found

**How to use:**
1. Place playhead anywhere.
2. Run the script.
3. Reaper will jump to the previous or current region and begin playback.

---
### BJ_Move Edit Cursor to Timestamp Relative to Current Region (with Marker Prompt)

Prompts for a **relative timestamp** within the current region, moves the edit cursor to that offset, and optionally calls REAPER’s marker dialog so you can drop a note.

**Use case:**  
Perfect for audiobook producers who get correction notes like “Chapter 5 at 3:25,” allowing you to jump precisely inside a region-based chapter and flag it instantly.

**Behavior:**
- Prompts for timecode in mm:ss format
- Checks which region the edit cursor is currently inside
- Moves the edit cursor to the relative timestamp within that region
- Calls REAPER’s marker insert dialog for easy annotation
- Shows an error if no region is found under the cursor

**How to use:**
1. Place the edit cursor roughly inside a region (chapter, section, etc).
2. Run the script.
3. Enter the offset time (e.g., `2:15`).
4. The cursor will jump, and the marker dialog will pop up automatically.
