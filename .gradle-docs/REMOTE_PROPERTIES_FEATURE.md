# Remote Properties Feature - Enhancement

## Overview
Enhanced the Gradle build to support downloading module versions from the remote `modules-untouched` repository's properties files, similar to how the consolez module works.

## What Was Added

### New Functionality
The build system now checks for module versions in **4 locations** (in priority order):

1. **Local bin/ directory** - `bin/ghostscript{version}/`
2. **Local bin/archived/ directory** - `bin/archived/ghostscript{version}/`
3. **modules-untouched repository** (enhanced with 2 sub-checks):
   - a. **Local clone** - `../modules-untouched/ghostscript/ghostscript{version}/`
   - b. **Remote properties file** - `https://raw.githubusercontent.com/Bearsampp/modules-untouched/main/modules/ghostscript.properties`
4. **Local releases.properties** - Downloads from GitHub releases

## New Functions Added

### 1. `getModuleUntouchedRemoteUrl(String name, String version)`
**Purpose:** Fetches download URLs from the remote modules-untouched properties file

**How it works:**
```groovy
def getModuleUntouchedRemoteUrl(String name, String version) {
    def propertiesUrl = "https://raw.githubusercontent.com/Bearsampp/modules-untouched/main/modules/${name}.properties"
    
    // Downloads the properties file temporarily
    // Parses it to find the version
    // Returns the download URL if found
    // Returns null if not found
}
```

**Example:**
- Checks: `https://raw.githubusercontent.com/Bearsampp/modules-untouched/main/modules/ghostscript.properties`
- Looks for: `10.05.1 = https://example.com/ghostscript-10.05.1.7z`
- Returns: The URL if found, null otherwise

### 2. `downloadAndExtractFromUrl(String downloadUrl, String version, String name)`
**Purpose:** Downloads and extracts a module from a given URL

**How it works:**
```groovy
def downloadAndExtractFromUrl(String downloadUrl, String version, String name) {
    // Downloads the archive from the URL
    // Extracts it to bearsampp-build/tmp/extract/
    // Finds the module directory
    // Returns the path to the extracted module
}
```

**Features:**
- Supports both .7z and .zip formats
- Caches downloads to avoid re-downloading
- Uses 7-Zip for .7z files
- Built-in extraction for .zip files

### 3. Enhanced `getModuleUntouched(String name, String version)`
**Purpose:** Now checks both local and remote sources

**Updated flow:**
```
1. Check local modules-untouched clone
   ├─ If found → Return path
   └─ If not found → Continue
   
2. Check remote properties file
   ├─ Download ghostscript.properties from GitHub
   ├─ Parse for version
   ├─ If found → Download and extract → Return path
   └─ If not found → Return null
```

## Usage Examples

### Example 1: Version in Remote Properties Only

**Scenario:** Version 99.99.99 exists in remote `ghostscript.properties` but not locally

**Command:**
```bash
gradle release -PbundleVersion=99.99.99
```

**Expected Output:**
```
Ghostscript binaries not found
Downloading Ghostscript 99.99.99...

Module not found in local modules-untouched, checking remote properties...
  Checking: https://raw.githubusercontent.com/Bearsampp/modules-untouched/main/modules/ghostscript.properties
  Found version 99.99.99 in remote properties
Found module in remote modules-untouched properties
  Downloading from: https://example.com/ghostscript-99.99.99.7z
  Downloading to: E:/Bearsampp-development/bearsampp-build/tmp/downloads/ghostscript/ghostscript-99.99.99.7z
  Download complete
  Extracting archive...
  Extraction complete
  Found ghostscript directory: ghostscript99.99.99
Using untouched module from modules-untouched repository
Source folder: E:/Bearsampp-development/bearsampp-build/tmp/extract/ghostscript/99.99.99/ghostscript99.99.99
```

### Example 2: Fallback Chain

**Full fallback chain for version 10.05.1:**

1. ❌ Check `bin/ghostscript10.05.1/` - Not found
2. ❌ Check `bin/archived/ghostscript10.05.1/` - Not found
3. ❌ Check `../modules-untouched/ghostscript/ghostscript10.05.1/` - Not found
4. ❌ Check remote `ghostscript.properties` - Not found
5. ✅ Check local `releases.properties` - **Found!** → Download from GitHub releases

### Example 3: Remote Properties File Format

**File:** `https://raw.githubusercontent.com/Bearsampp/modules-untouched/main/modules/ghostscript.properties`

**Format:**
```properties
# Ghostscript module versions
9.22 = https://example.com/ghostscript-9.22.7z
9.56.1 = https://example.com/ghostscript-9.56.1.7z
10.0 = https://example.com/ghostscript-10.0.7z
10.05.1 = https://example.com/ghostscript-10.05.1.7z
```

## Benefits

### 1. No Local Clone Required
- ✅ Works without cloning the entire `modules-untouched` repository
- ✅ Only downloads what's needed
- ✅ Saves disk space

### 2. Centralized Version Management
- ✅ Versions can be managed in the remote `ghostscript.properties` file
- ✅ All developers get the same versions
- ✅ Easy to add new versions without updating each module

### 3. Flexible Fallback Chain
- ✅ Local sources take priority (faster)
- ✅ Remote sources as fallback (convenient)
- ✅ Multiple fallback options ensure builds succeed

### 4. Consistent with Other Modules
- ✅ Matches the pattern used by consolez and other modules
- ✅ Standardized approach across all Bearsampp modules

## Configuration

### No Configuration Needed!
The feature works out of the box. The build automatically:
- Checks for the remote properties file
- Downloads it temporarily
- Parses it for the requested version
- Downloads and extracts if found

### Optional: Create ghostscript.properties
To use this feature, create a file in the modules-untouched repository:

**Location:** `modules-untouched/modules/ghostscript.properties`

**Content:**
```properties
# Add versions with their download URLs
10.05.1 = https://example.com/ghostscript-10.05.1.7z
10.06.0 = https://example.com/ghostscript-10.06.0.7z
```

## Error Handling

### Graceful Degradation
If the remote properties file:
- Doesn't exist → Continues to next fallback
- Is empty → Continues to next fallback
- Has network errors → Continues to next fallback
- Doesn't contain the version → Continues to next fallback

### Clear Error Messages
```
Version 99.99.99 not found in releases.properties or modules-untouched repository
```

This indicates the version was checked in:
- Local bin/
- Local bin/archived/
- Local modules-untouched clone
- Remote modules-untouched properties
- Local releases.properties

## Technical Details

### Caching
- Downloaded properties files are temporary (deleted after use)
- Downloaded archives are cached in `bearsampp-build/tmp/downloads/`
- Extracted files are cached in `bearsampp-build/tmp/extract/`

### Network Requests
- Uses Ant's `get` task for downloads
- Supports HTTP/HTTPS
- Handles network errors gracefully
- No authentication required (public GitHub URLs)

### File Formats Supported
- ✅ .7z (requires 7-Zip installed)
- ✅ .zip (built-in support)

## Comparison: Before vs After

### Before
**Source Priority:**
1. Local bin/
2. Local bin/archived/
3. Local modules-untouched clone only
4. Local releases.properties

**Limitation:** Required cloning the entire modules-untouched repository

### After
**Source Priority:**
1. Local bin/
2. Local bin/archived/
3. Local modules-untouched clone
4. **Remote modules-untouched properties** ← NEW!
5. Local releases.properties

**Advantage:** Works without cloning, downloads only what's needed

## Testing

### Test Case 1: Remote Properties Exists
```bash
# Ensure ghostscript.properties exists remotely with version 10.05.1
gradle release -PbundleVersion=10.05.1
```

**Expected:** Downloads from remote properties if not found locally

### Test Case 2: Remote Properties Doesn't Exist
```bash
# If ghostscript.properties doesn't exist remotely
gradle release -PbundleVersion=10.05.1
```

**Expected:** Falls back to releases.properties without error

### Test Case 3: Version Not in Remote Properties
```bash
# Version exists in releases.properties but not in remote properties
gradle release -PbundleVersion=10.05.1
```

**Expected:** Falls back to releases.properties

## Related Files
- `build.gradle` - Main build file (modified)
- `BUGFIX_SUMMARY.md` - Previous bug fix documentation
- `REMOTE_PROPERTIES_FEATURE.md` - This file

## Status
✅ **IMPLEMENTED** - The Gradle build now supports downloading from remote modules-untouched properties files, providing a flexible and convenient fallback mechanism similar to other Bearsampp modules.
