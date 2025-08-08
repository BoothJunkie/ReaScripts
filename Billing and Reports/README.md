### BJ_Final Runtime Calculator

Calculates the total run time of all media items on each track in the project and outputs a Markdown report file with a breakdown.

**Use case:**  
For billing voiceover or editing work that is charged by the final runtime of the exported audio, excluding silent gaps.
Creates a report that can be atteched to an invoice. 

**Behavior:**
- Scans all media items in the project (per track).
- Totals up item lengths (does not include empty time or gaps).
- Generates a Markdown report (`FRT-[project name].md`) in the project folder.
- Displays a summary message box with total runtime and file path to the report.

**How to use:**
1. Open your project.
    1.a The report will use track names in the output, so descriptive names in the track panel will make for a more readable report. 
2. Run the script.
3. View the Markdown report in your project directory.
---
### BJ_Calculate FRT of All Items on a Single Track

Calculates the final runtime (FRT) of each track in the project by totaling the lengths of all media items (excluding silence).

**Use case:**  
Useful for billing voiceover or post work that’s charged by the minute per track (e.g., characters, chapters, dialogue stems).

**Behavior:**
- Totals item lengths per track in minutes.
- Saves a plain-text `.txt` report to the same folder as the REAPER project.
- Also copies the report to your clipboard for easy pasting into invoices or emails.

**Output format:**
