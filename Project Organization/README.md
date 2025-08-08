# BoothJunkie PROJECT ORGANIZATION ReaScripts

A collection of ReaScripts by Mike DelGaudio (@BoothJunkie) for improving workflow, organization, and efficiency in Reaper.

---

## 📁 Project Organization

### `BJ_ColorItemsBasedonTrackColor.lua`

**Description:**  
Colors all media items on selected tracks to match the track’s color.  
This is useful for identifying items that may have been moved inadvertently between tracks.  
Unlike Reaper’s default behavior (where items change color when moved to a new track), this script *locks* the color to the *original* track color of the track where the item was located when you ran the script. (Reaper, by default changes the color of the item to whatever the current track color is)

**How to use:**
1. Select one or more tracks with media items.
2. Run the script.
3. All items on the selected tracks will be colored to match the track color.

**Why use this?**  
Great for post-production or VO workflows where track color is used to signify meaning (e.g., character, chapter, revision status), and you want that meaning to persist even if the item is accidentally moved.

---

## 💡 Installation

If you’re using ReaPack:

1. Add this repository as a ReaPack source.
2. Synchronize packages.
3. Look for `BJ_ColorItemsBasedonTrackColor.lua` under “Project Organization.”

---
### BJ_ColorRegionsBasedOnRRMSelection.lua

Colors regions based on the color of the track(s) they are assigned to in the Region Render Matrix.

**Use case:**  
When rendering complex projects with many regions assigned to different tracks via the RRM, this script helps you visually identify which regions belong to which tracks by inheriting track colors.

**Behavior:**
- Loops through all regions.
- If a region is assigned to one or more tracks in the Region Render Matrix, it inherits the **topmost track's** color.
- Only regions (not markers) are affected.

**How to use:**
1. Assign your regions to tracks via the Region Render Matrix.
2. Run the script.
3. Regions will take on the color of their assigned tracks.
---

## 📜 License

MIT License – you are free to use, modify, and distribute these scripts.

---

## ☕ Support

If you find this script useful, you can [buy me a coffee](https://www.buymeacoffee.com/boothjunkie).
