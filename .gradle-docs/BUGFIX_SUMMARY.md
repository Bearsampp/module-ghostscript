# Bug Fix Summary: modules-untouched Fallback

## Issue
The build system was not checking the `modules-untouched` repository when a version didn't exist in `releases.properties`, contrary to the documented behavior.

## Root Cause
The `downloadAndExtractGhostscript` function was checking `releases.properties` first and throwing an exception immediately if the version wasn't found, without ever calling the `getModuleUntouched` function.

## Fix Applied
Modified the `downloadAndExtractGhostscript` function in `build.gradle` to:

1. **First** check the `modules-untouched` repository using `getModuleUntouched()`
2. **Then** check `releases.properties` if not found in modules-untouched
3. Only throw an exception if the version is not found in either location

## Code Changes

### File: `build.gradle`
**Function:** `downloadAndExtractGhostscript` (lines ~114-140)

**Before:**
```groovy
def downloadAndExtractGhostscript(String version, File destDir) {
    // First, try to download from releases.properties (preferred source)
    // Load releases.properties to get download URL
    def releasesFile = file('releases.properties')
    if (!releasesFile.exists()) {
        throw new GradleException("releases.properties not found")
    }

    def releases = new Properties()
    releasesFile.withInputStream { releases.load(it) }

    def downloadUrl = releases.getProperty(version)
    if (!downloadUrl) {
        throw new GradleException("Version ${version} not found in releases.properties")
    }
    // ... continues with download
}
```

**After:**
```groovy
def downloadAndExtractGhostscript(String version, File destDir) {
    // First, try to get from modules-untouched repository (like Ant build)
    def untouchedModule = getModuleUntouched(bundleName, version)
    if (untouchedModule) {
        println "Found untouched module in: ${untouchedModule}"
        println "Using untouched module from modules-untouched repository"
        return untouchedModule
    }
    
    // Second, try to download from releases.properties
    println "Module not found in modules-untouched, downloading from releases.properties..."
    println ""
    
    def releasesFile = file('releases.properties')
    if (!releasesFile.exists()) {
        throw new GradleException("releases.properties not found")
    }

    def releases = new Properties()
    releasesFile.withInputStream { releases.load(it) }

    def downloadUrl = releases.getProperty(version)
    if (!downloadUrl) {
        throw new GradleException("Version ${version} not found in releases.properties or modules-untouched repository")
    }
    // ... continues with download
}
```

## Behavior Changes

### Before Fix
**Priority Order:**
1. ✅ Local bin/ directory
2. ✅ Local bin/archived/ directory
3. ❌ **SKIPPED** - modules-untouched repository
4. ✅ Download from releases.properties (fails if not found)

**Result:** Build fails if version not in releases.properties, even if it exists in modules-untouched

### After Fix
**Priority Order:**
1. ✅ Local bin/ directory
2. ✅ Local bin/archived/ directory
3. ✅ **modules-untouched repository** (now properly checked)
4. ✅ Download from releases.properties

**Result:** Build succeeds if version exists in modules-untouched, even if not in releases.properties

## Benefits

1. **Matches Documentation**: Now implements the documented fallback behavior
2. **Development Workflow**: Developers can use modules-untouched for testing new versions
3. **Ant Compatibility**: Matches the Ant build's `<getmoduleuntouched>` behavior
4. **Better Error Messages**: Error now indicates both sources were checked
5. **Flexibility**: Supports multiple source options without requiring releases.properties updates

## Testing

### Test Case 1: Version in modules-untouched but not in releases.properties

**Setup:**
```bash
# Create a test version in modules-untouched
mkdir -p E:/Bearsampp-development/modules-untouched/ghostscript/ghostscript99.99.99/bin
# Copy or create gswin64c.exe in that directory
```

**Command:**
```bash
gradle release -PbundleVersion=99.99.99
```

**Expected Output:**
```
Ghostscript binaries not found
Downloading Ghostscript 99.99.99...

Found untouched module in: E:/Bearsampp-development/modules-untouched/ghostscript/ghostscript99.99.99
Using untouched module from modules-untouched repository
Source folder: E:/Bearsampp-development/modules-untouched/ghostscript/ghostscript99.99.99
```

### Test Case 2: Version not in modules-untouched, falls back to releases.properties

**Command:**
```bash
gradle release -PbundleVersion=10.05.1
```

**Expected Output:**
```
Ghostscript binaries not found
Downloading Ghostscript 10.05.1...

Module not found in modules-untouched, downloading from releases.properties...

Downloading Ghostscript 10.05.1 from:
  https://github.com/Bearsampp/module-ghostscript/releases/download/2025.7.31/...
```

### Test Case 3: Version not in either location

**Command:**
```bash
gradle release -PbundleVersion=99.99.99
# (without modules-untouched setup)
```

**Expected Output:**
```
FAILURE: Build failed with an exception.

* What went wrong:
Execution failed for task ':release'.
> Version 99.99.99 not found in releases.properties or modules-untouched repository
```

## Documentation Alignment

This fix ensures the implementation matches the documented behavior in:
- `GRADLE.md` - Source Download Priority section
- `.gradle-docs/SOURCE_DOWNLOAD_BEHAVIOR.md` - Complete documentation
- `.gradle-docs/GRADLE_README.md` - Quick reference

## Related Files
- `build.gradle` - Main build file (modified)
- `TEST_MISSING_VERSION.md` - Detailed test documentation
- `BUGFIX_SUMMARY.md` - This file

## Verification
✅ Bug identified and documented
✅ Fix implemented in build.gradle
✅ Error messages updated
✅ Console output improved
✅ Documentation updated
✅ Test cases documented

## Status
**FIXED** - The build system now properly checks modules-untouched repository before falling back to releases.properties, matching the documented behavior and Ant build compatibility.
