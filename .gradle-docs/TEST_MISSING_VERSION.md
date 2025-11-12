# Test: Version Not in releases.properties

## Current Behavior Analysis

### Issue Found
When a version doesn't exist in `releases.properties`, the build system **does NOT** fall back to the `modules-untouched` repository as documented.

### Code Analysis

#### Function: `getModuleUntouched` (lines 95-111)
```groovy
def getModuleUntouched(String name, String version) {
    def modulesUntouchedPath = file("${rootDir}/modules-untouched")
    
    if (modulesUntouchedPath.exists()) {
        def untouchedModulePath = file("${modulesUntouchedPath}/${name}/${name}${version}")
        
        if (untouchedModulePath.exists()) {
            def ghostscriptExe = file("${untouchedModulePath}/bin/gswin64c.exe")
            if (ghostscriptExe.exists()) {
                println "Found untouched module in: ${untouchedModulePath}"
                return untouchedModulePath
            }
        }
    }
    
    return null
}
```

**Status:** ✅ Function exists but is **NEVER CALLED**

#### Function: `downloadAndExtractGhostscript` (lines 114-230)
```groovy
def downloadAndExtractGhostscript(String version, File destDir) {
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

**Status:** ❌ **PROBLEM** - Throws exception immediately if version not in releases.properties
**Missing:** Should check `modules-untouched` BEFORE throwing exception

### Expected Behavior (from documentation)

According to `.gradle-docs/SOURCE_DOWNLOAD_BEHAVIOR.md`:

> ### 3. Download from releases.properties (Preferred Remote Source)
> If the module is not found in any of the above locations, the build downloads it from the URL specified in `releases.properties`.

And from `GRADLE.md`:

> ## Source Download Priority
> 
> When building a module, Gradle checks for source files in this order:
> 
> 1. **Local bin/ directory** - `bin/ghostscript{version}/`
> 2. **Local bin/archived/ directory** - `bin/archived/ghostscript{version}/`
> 3. **modules-untouched repository** - `../modules-untouched/ghostscript/ghostscript{version}/` (like Ant)
> 4. **Download from releases.properties** - Downloads from GitHub releases

### Actual Behavior

Current priority order:
1. ✅ Local bin/ directory
2. ✅ Local bin/archived/ directory
3. ❌ **SKIPPED** - modules-untouched repository
4. ✅ Download from releases.properties (but fails if version not found)

### Test Case

**Scenario:** Build a version that exists in `modules-untouched` but NOT in `releases.properties`

**Setup:**
```
E:/Bearsampp-development/
├── module-ghostscript/
│   └── releases.properties (does NOT contain version 99.99.99)
└── modules-untouched/
    └── ghostscript/
        └── ghostscript99.99.99/
            └── bin/
                └── gswin64c.exe
```

**Command:**
```bash
gradle release -PbundleVersion=99.99.99
```

**Expected Result:**
```
Ghostscript binaries not found
Downloading Ghostscript 99.99.99...

Found untouched module in: E:/Bearsampp-development/modules-untouched/ghostscript/ghostscript99.99.99
Using untouched module from modules-untouched repository
Source folder: E:/Bearsampp-development/modules-untouched/ghostscript/ghostscript99.99.99
```

**Actual Result:**
```
FAILURE: Build failed with an exception.

* What went wrong:
Execution failed for task ':release'.
> Version 99.99.99 not found in releases.properties
```

## Fix Required

The `downloadAndExtractGhostscript` function should be modified to:

1. Check `modules-untouched` repository FIRST
2. Only if not found there, check `releases.properties`
3. Only throw exception if neither source has the version

### Proposed Fix Location

File: `build.gradle`
Function: `downloadAndExtractGhostscript` (around line 114)

**Change:**
```groovy
def downloadAndExtractGhostscript(String version, File destDir) {
    // FIRST: Try modules-untouched repository
    def untouchedModule = getModuleUntouched(bundleName, version)
    if (untouchedModule) {
        println "Found untouched module in: ${untouchedModule}"
        println "Using untouched module from modules-untouched repository"
        return untouchedModule
    }
    
    // SECOND: Try downloading from releases.properties
    println "Module not found in modules-untouched, downloading from releases.properties..."
    
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
    
    // ... continue with download
}
```

## Comparison with consolez.properties Example

Looking at the example from `https://github.com/Bearsampp/modules-untouched/blob/main/modules/consolez.properties`:

The `modules-untouched` repository serves as a fallback source for module binaries when they are not available locally or in releases.properties. This is the expected behavior that should be implemented.

## Conclusion

**Status:** ✅ **BUG FIXED**

The implementation has been updated to properly check `modules-untouched` repository BEFORE checking `releases.properties`, matching the documented behavior.

**Changes Made:**
- Modified `downloadAndExtractGhostscript` function to call `getModuleUntouched` first
- Added proper fallback chain: modules-untouched → releases.properties
- Updated error message to indicate both sources were checked
- Added informative console output when using modules-untouched

**Impact:** 
- ✅ Developers can now use versions from `modules-untouched` even if not in `releases.properties`
- ✅ The documented fallback mechanism now works correctly
- ✅ The `getModuleUntouched` function is now properly utilized
- ✅ Build behavior matches the documentation

**Testing:**
To test the fix, create a version in `modules-untouched` that doesn't exist in `releases.properties`:
```bash
# Create test structure
mkdir -p E:/Bearsampp-development/modules-untouched/ghostscript/ghostscript99.99.99/bin

# Add a dummy executable (or copy from existing version)
# Then run:
gradle release -PbundleVersion=99.99.99
```

Expected output:
```
Ghostscript binaries not found
Downloading Ghostscript 99.99.99...

Found untouched module in: E:/Bearsampp-development/modules-untouched/ghostscript/ghostscript99.99.99
Using untouched module from modules-untouched repository
Source folder: E:/Bearsampp-development/modules-untouched/ghostscript/ghostscript99.99.99
```
