from pathlib import Path
from bs4 import BeautifulSoup

# 1. Define your target directory (use "." for the current folder)
target_dir = Path("./nccc170.uark.edu")

print(f"Starting HTML cleanup in: {target_dir.resolve()}")

# 2. Recursively find all files ending in .html or .htm
# rglob stands for "recursive glob"
for file_path in target_dir.rglob("*.html"):
    print(f"Processing: {file_path.relative_to(target_dir)}")
    
    try:
        # Read the raw messy HTML file securely with UTF-8 encoding
        raw_html = file_path.read_text(encoding="utf-8")
        
        # Parse it (this automatically fixes broken tag structures)
        # Using the standard 'html.parser' built into Python
        soup = BeautifulSoup(raw_html, "html.parser")
        
        # Format the code with clean line indentation rules
        clean_html = soup.prettify()
        
        # Optional: Safely create a backup (.html.bak) before overwriting
        backup_path = file_path.with_suffix(file_path.suffix + ".bak")
        file_path.rename(backup_path)
        
        # Overwrite the original file path with the beautiful HTML
        # (Using original path name since rename shifted the old file away)
        file_path.write_text(clean_html, encoding="utf-8")
        
    except Exception as e:
        print(f"Error processing {file_path.name}: {e}")

print("Done! All files cleaned.")
