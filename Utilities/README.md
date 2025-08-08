### BJ_Censor Beep of Time Selection Length

Inserts a ReaSynth-generated beep tone (C6) that matches the current time selection — perfect for censoring inappropriate content or redacting sensitive info.

**Use case:**  
Podcast editors or content creators can quickly drop in a classic bleep tone over swear words or private names without rendering or destructive edits.

**Behavior:**
- Adds a MIDI item to the selected track at the time selection.
- Inserts a C6 note at 100 velocity.
- Automatically adds ReaSynth to the item’s take.

**How to use:**
1. Make a time selection over the phrase to bleep.
2. Select the track to place the bleep on.
3. Run the script. Done!

**Tip:**  
Use with a dedicated “Censor” track in your project template for even faster workflow.
---
### BJ_Toggle Master Playrate 1.0–1.8 (Preserve Pitch)

Toggles Reaper's master playrate between **1.0x and 1.8x** while ensuring pitch is preserved.

**Use case:**  
Ideal for listening back to long-form recordings like audiobooks or corporate narration, helping you verify pronunciation, word accuracy, or pacing — faster.

**Behavior:**
- If pitch preservation is disabled, it enables it automatically.
- If playrate is currently near 1.0, it jumps to 1.8.
- If playrate is already 1.8 (or anything else), it resets to 1.0.

**How to use:**
- Map it to a keyboard shortcut or toolbar button.
- Run it during playback or idle state.
- Toggle back and forth as needed.

**Pro Tip:**  
Pair with scripts that loop over regions or play from markers for even faster QA workflows.
---
### BJ_Open Project Path in Finder or Explorer

Opens the **system file manager** at the location of the currently open Reaper project.

**Use case:**  
Quick access to the project folder, e.g., to open renders, logs, notes, or session media.

**Behavior:**
- If you're on **macOS**, opens **Finder**
- If you're on **Windows**, opens **Explorer**
- Gracefully handles unsaved projects (shows error message)

**How to use:**
1. Make sure the current project is saved.
2. Run the script.
3. Your file manager opens at the project’s location.

**Tip:**  
Bind to a custom menu or shortcut to mimic the "Show in Finder/Explorer" behavior found in most modern software.
