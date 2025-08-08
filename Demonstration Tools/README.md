### BJ_Create 100 Random Length Adjacent MIDI Items

Generates 100 adjacent MIDI items with random durations (5–30s) starting at the edit cursor.

**Use case:**  
This script is useful for testing, demonstrating, or developing other scripts that need a timeline populated with many items (e.g., scripts that analyze item spacing, region generation, coloring, etc.).

**How to use:**
1. Select a track.
2. Move the edit cursor to the starting position.
3. Run the script.
4. The timeline will be populated with 100 MIDI items.

> If no track is selected, the script will auto-select the first track (if one exists).

---

### BJ_Create 500 Items

Simulates a long-form narration or e-learning project by creating 500 evenly spaced MIDI items on a selected track.

**Use case:**  
Useful for testing scripts that operate on many items (e.g. region generators, colorizers, batch editors).

**Behavior:**
- Creates 500 empty MIDI items.
- Each item is 5 seconds long.
- Items are spaced with 3 seconds of silence between them.
- Items are placed starting from the edit cursor.

**How to use:**
1. Select a track.
2. Place the edit cursor at the starting location.
3. Run the script.
---
### BJ_Item Creator

A flexible script that generates multiple items (MIDI or empty) with user-defined spacing, lengths, names, and optional region markers.

**Use case:**  
Ideal for quickly populating a project timeline for testing, demonstrations, or preparing region-based exports.

**Features:**
- Choose item type: MIDI or empty
- Set number of items, length, and spacing
- Define custom naming pattern with padded counters (e.g., `Line %03d`)
- Optionally creates regions around each item

**How to use:**
1. Select a track.
2. Run the script.
3. Fill out the prompt with desired values (e.g., 100 items, 5s each, 3s spacing).
4. Items are created sequentially at the edit cursor.
---
### BJ_Create Regions Based on Subdivision with GUI

Creates evenly spaced regions within a selected time range based on a musical subdivision (e.g., quarter notes, eighths, etc.).

**Use case:**  
Ideal for quickly breaking up time selections into rhythmic units, such as for voiceover pacing, music editing, ADR cueing, or granular spot work.

**Features:**
- GUI dropdown to choose subdivision (whole to 1/64th note).
- Supports REAPER’s current tempo.
- Real-time region creation with immediate visual feedback.

**How to use:**
1. Make a time selection in the ruler.
2. Run the script.
3. Choose a subdivision in the popup window.
4. Click **"Create Regions"**.
