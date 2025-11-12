# Source Download Behavior

## Overview

The Gradle build now supports the same source download behavior as the Ant build, including support for the `modules-untouched` repository.

## Download Priority

When building a module version, the Gradle build follows this priority order to find source files:

### 1. Local bin/ Directory (Highest Priority)
```
module-ghostscript/bin/ghostscript10.05.1/
```
If the version exists in the local `bin/` directory with all required files (e.g., `bin/gswin64c.exe`), it will be used directly.

### 2. Local bin/archived/ Directory
```
module-ghostscript/bin/archived/ghostscript10.05.1/
```
If not found in `bin/`, the build checks the `bin/archived/` subdirectory.

### 3. Download from releases.properties (Preferred Remote Source)
```properties
10.05.1 = https://github.com/Bearsampp/module-ghostscript/releases/download/2025.7.31/bearsampp-ghostscript-10.05.1-2025.7.31.7z
```
If the module is not found in any of the above locations, the build downloads it from the URL specified in `releases.properties`.

Downloaded files are cached in:
```
bearsampp-build/tmp/downloads/ghostscript/
bearsampp-build/tmp/extract/ghostscript/
```

## Comparison with Ant Build

### Ant Build (build.xml)
```xml
<getmoduleuntouched name="${bundle.name}" version="${bundle.version}" 
                    propSrcDest="bundle.srcdest" 
                    propSrcFilename="bundle.srcfilename"/>
```

The Ant `<getmoduleuntouched>` task:
1. Checks `modules-untouched` repository
2. Falls back to downloading if not found

### Gradle Build (build.gradle)
```groovy
def getModuleUntouched(String name, String version) {
    def modulesUntouchedPath = file("${rootDir}/modules-untouched")
    if (modulesUntouchedPath.exists()) {
        def untouchedModulePath = file("${modulesUntouchedPath}/${name}/${name}${version}")
        if (untouchedModulePath.exists()) {
            def ghostscriptExe = file("${untouchedModulePath}/bin/gswin64c.exe")
            if (ghostscriptExe.exists()) {
                return untouchedModulePath
            }
        }
    }
    return null
}
```

The Gradle implementation:
1. Checks local `bin/` directory first
2. Checks local `bin/archived/` directory
3. Downloads from `releases.properties` (preferred remote source)

## Usage Examples

### Example 1: Building with Local Files

If you have the files locally:
```
module-ghostscript/bin/ghostscript10.05.1/
├── bin/
│   └── gswin64c.exe
├── bearsampp.conf
└── update_cidfmap.bat
```

Run:
```bash
gradle release -PbundleVersion=10.05.1
```

Output:
```
Bundle path: E:/Bearsampp-development/module-ghostscript/bin/ghostscript10.05.1
Source folder: E:/Bearsampp-development/module-ghostscript/bin/ghostscript10.05.1
```

### Example 2: Building with modules-untouched

If you have the `modules-untouched` repository:
```
Bearsampp-development/
└── modules-untouched/
    └── ghostscript/
        └── ghostscript10.05.1/
            └── bin/
                └── gswin64c.exe
```

Run:
```bash
gradle release -PbundleVersion=10.05.1
```

Output:
```
Ghostscript binaries not found
Downloading Ghostscript 10.05.1...

Found untouched module in: E:/Bearsampp-development/modules-untouched/ghostscript/ghostscript10.05.1
Using untouched module from modules-untouched repository
Source folder: E:/Bearsampp-development/modules-untouched/ghostscript/ghostscript10.05.1
```

### Example 3: Building with Download

If the module is not found locally or in `modules-untouched`:

Run:
```bash
gradle release -PbundleVersion=10.05.1
```

Output:
```
Ghostscript binaries not found
Downloading Ghostscript 10.05.1...

Module not found in modules-untouched, downloading from releases.properties...
Downloading Ghostscript 10.05.1 from:
  https://github.com/Bearsampp/module-ghostscript/releases/download/2025.7.31/bearsampp-ghostscript-10.05.1-2025.7.31.7z
  Downloading to: E:/Bearsampp-development/bearsampp-build/tmp/downloads/ghostscript/bearsampp-ghostscript-10.05.1-2025.7.31.7z
  Download complete
  Extracting archive...
  Extraction complete
  Found Ghostscript directory: ghostscript10.05.1
Source folder: E:/Bearsampp-development/bearsampp-build/tmp/extract/ghostscript/10.05.1/ghostscript10.05.1
```

## New Module Workflow

When creating a new module or adding a new version:

### Option 1: Use modules-untouched (Recommended for Development)

1. Clone or update the `modules-untouched` repository:
   ```bash
   cd E:/Bearsampp-development
   git clone https://github.com/Bearsampp/modules-untouched.git
   ```

2. Ensure the module version exists:
   ```
   modules-untouched/ghostscript/ghostscript10.06.0/
   ```

3. Build:
   ```bash
   cd module-ghostscript
   gradle release -PbundleVersion=10.06.0
   ```

The build will automatically find and use the untouched module.

### Option 2: Add to releases.properties (For Production)

1. Add the download URL to `releases.properties`:
   ```properties
   10.06.0 = https://github.com/Bearsampp/module-ghostscript/releases/download/2025.8.1/bearsampp-ghostscript-10.06.0-2025.8.1.7z
   ```

2. Build:
   ```bash
   gradle release -PbundleVersion=10.06.0
   ```

The build will download and cache the module automatically.

### Option 3: Manual Extraction (For Testing)

1. Manually extract binaries to:
   ```
   module-ghostscript/bin/ghostscript10.06.0/
   ```

2. Build:
   ```bash
   gradle release -PbundleVersion=10.06.0
   ```

## Benefits

### 1. Ant Compatibility
✅ Matches Ant's `<getmoduleuntouched>` behavior
✅ Uses the same `modules-untouched` repository structure
✅ Same fallback mechanism

### 2. Flexibility
✅ Multiple source options (local, untouched, download)
✅ Automatic fallback chain
✅ Caching for downloaded files

### 3. Development Workflow
✅ Use `modules-untouched` for development
✅ Use `releases.properties` for CI/CD
✅ Use local `bin/` for testing

### 4. No Manual Downloads
✅ Automatic download if not found
✅ Cached downloads for reuse
✅ Clear error messages if source not available

## Troubleshooting

### Module Not Found in modules-untouched

**Error:**
```
Module not found in modules-untouched, downloading from releases.properties...
```

**Solution:**
This is normal behavior. The build will automatically download from `releases.properties`. If you want to use `modules-untouched`:

1. Clone the repository:
   ```bash
   cd E:/Bearsampp-development
   git clone https://github.com/Bearsampp/modules-untouched.git
   ```

2. Ensure the version exists in the correct path:
   ```
   modules-untouched/ghostscript/ghostscript10.05.1/bin/gswin64c.exe
   ```

### Version Not in releases.properties

**Error:**
```
Version 10.99.9 not found in releases.properties
```

**Solution:**
Either:
1. Add the version to `releases.properties`
2. Add the version to `modules-untouched` repository
3. Manually extract to `bin/ghostscript10.99.9/`

### modules-untouched Repository Structure

The `modules-untouched` repository should follow this structure:
```
modules-untouched/
└── ghostscript/
    ├── ghostscript9.22/
    │   └── bin/
    │       └── gswin64c.exe
    ├── ghostscript9.56.1/
    │   └── bin/
    │       └── gswin64c.exe
    └── ghostscript10.05.1/
        └── bin/
            └── gswin64c.exe
```

## Summary

The Gradle build now fully supports the Ant build's source download behavior:

1. ✅ Checks local `bin/` directory
2. ✅ Checks local `bin/archived/` directory
3. ✅ Checks `modules-untouched` repository (like Ant's `<getmoduleuntouched>`)
4. ✅ Downloads from `releases.properties` as fallback
5. ✅ Caches downloads for reuse

This ensures compatibility with existing Ant workflows while providing additional flexibility and automation.
