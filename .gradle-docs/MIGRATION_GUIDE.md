# Migration Guide: Ant to Gradle

This guide helps you migrate from the Ant build system to the new Gradle build system for the Bearsampp Ghostscript module.

## Overview

The Gradle build is a complete, drop-in replacement for the Ant build. It provides:
- All Ant functionality
- Additional features (interactive mode, automatic downloads, etc.)
- Better error messages
- Faster builds with caching
- No external dependencies (build-commons.xml, build-bundle.xml)

## Quick Migration Steps

### 1. Verify Prerequisites

Ensure you have:
- Java 8 or higher
- 7-Zip installed (for .7z archives)
- The `dev` project in the parent directory

Check with:
```bash
gradle verify
```

### 2. Test the Gradle Build

Run the test script to verify everything works:
```bash
test-gradle-build.bat
```

Or test manually:
```bash
gradle info
gradle listVersions
gradle verify
```

### 3. Build a Test Release

Build a single version to verify output:
```bash
gradle release -PbundleVersion=10.05.1
```

Compare the output with an Ant build to ensure they're identical.

### 4. Update Your Workflow

Replace Ant commands with Gradle equivalents:

| Old (Ant) | New (Gradle) |
|-----------|--------------|
| `ant release.build -Dbundle.path=bin/ghostscript10.05.1` | `gradle release -PbundleVersion=10.05.1` |
| N/A | `gradle releaseAll` |
| `ant clean` | `gradle clean` |

### 5. Update CI/CD Pipelines

If you have automated builds, update your CI/CD configuration:

**Before (Ant):**
```yaml
- name: Build Release
  run: ant release.build -Dbundle.path=bin/ghostscript10.05.1
```

**After (Gradle):**
```yaml
- name: Build Release
  run: gradle release -PbundleVersion=10.05.1
```

### 6. Optional: Remove Ant Files

Once you've verified the Gradle build works correctly, you can optionally remove:
- `build.xml` (keep as backup initially)

**Do NOT remove:**
- `build.properties` (still used by Gradle)
- `releases.properties` (still used by Gradle)

## Detailed Comparison

### Command Mapping

#### Build a Specific Version

**Ant:**
```bash
ant release.build -Dbundle.path=bin/ghostscript10.05.1
```

**Gradle:**
```bash
gradle release -PbundleVersion=10.05.1
```

**Gradle (Interactive):**
```bash
gradle release
# Then select version from menu
```

#### Build All Versions

**Ant:**
```bash
# Not available - must build each version separately
for /d %i in (bin\ghostscript*) do ant release.build -Dbundle.path=%i
```

**Gradle:**
```bash
gradle releaseAll
```

#### Clean Build Artifacts

**Ant:**
```bash
ant clean
```

**Gradle:**
```bash
gradle clean
```

### Configuration Files

Both Ant and Gradle use the same configuration files:

#### build.properties
```properties
bundle.name = ghostscript
bundle.release = 2025.7.31
bundle.type = tools
bundle.format = 7z
#build.path = C:/Bearsampp-build
```

No changes needed - Gradle reads this file directly.

#### releases.properties
```properties
10.05.1 = https://github.com/Bearsampp/module-ghostscript/releases/download/2025.7.31/bearsampp-ghostscript-10.05.1-2025.7.31.7z
```

No changes needed - Gradle reads this file directly.

### Output Structure

Both Ant and Gradle produce the same output structure:

```
bearsampp-build/
└── tools/
    └── ghostscript/
        └── 2025.7.31/
            ├── bearsampp-ghostscript-10.05.1-2025.7.31.7z
            ├── bearsampp-ghostscript-10.05.1-2025.7.31.7z.md5
            ├── bearsampp-ghostscript-10.05.1-2025.7.31.7z.sha1
            ├── bearsampp-ghostscript-10.05.1-2025.7.31.7z.sha256
            └── bearsampp-ghostscript-10.05.1-2025.7.31.7z.sha512
```

## New Features in Gradle

### 1. Interactive Mode

Select version from a menu instead of typing it:

```bash
gradle release
```

Output:
```
======================================================================
Interactive Release Mode
======================================================================

Available versions:
   1. 9.22            [bin/archived]
   2. 9.56.1          [bin/archived]
   3. 10.0            [bin/archived]
   4. 10.02.0         [bin/archived]
   5. 10.03.0         [bin/archived]
   6. 10.03.1         [bin/archived]
   7. 10.04.0         [bin/archived]
   8. 10.05.0         [bin/archived]
   9. 10.05.1         [bin]

Enter version number to build:
```

### 2. Archived Folder Support

Gradle automatically detects versions in both `bin/` and `bin/archived/`:

```bash
gradle listVersions
```

Output:
```
Available ghostscript versions:
------------------------------------------------------------
  9.22            [bin/archived]
  9.56.1          [bin/archived]
  10.0            [bin/archived]
  10.02.0         [bin/archived]
  10.03.0         [bin/archived]
  10.03.1         [bin/archived]
  10.04.0         [bin/archived]
  10.05.0         [bin/archived]
  10.05.1         [bin]
------------------------------------------------------------
Total versions: 9
```

### 3. Automatic Downloads

If binaries are missing, Gradle automatically downloads them:

```bash
gradle release -PbundleVersion=10.05.1
```

If `bin/ghostscript10.05.1/bin/gswin64c.exe` doesn't exist, Gradle will:
1. Check `releases.properties` for the download URL
2. Download the archive to `bearsampp-build/tmp/downloads/`
3. Extract to `bearsampp-build/tmp/extract/`
4. Use the extracted binaries for the build

### 4. Build All Versions

Build all versions in one command:

```bash
gradle releaseAll
```

Output:
```
======================================================================
Building releases for 9 ghostscript versions
======================================================================

======================================================================
[1/9] Building ghostscript 9.22...
======================================================================
...
[SUCCESS] ghostscript 9.22 completed

======================================================================
[2/9] Building ghostscript 9.56.1...
======================================================================
...
```

### 5. Environment Verification

Check if your environment is ready:

```bash
gradle verify
```

Output:
```
Environment Check Results:
------------------------------------------------------------
  [PASS]     Java 8+
  [PASS]     build.properties
  [PASS]     releases.properties
  [PASS]     dev directory
  [PASS]     bin directory
  [PASS]     bin/archived directory
  [PASS]     7-Zip
------------------------------------------------------------

[SUCCESS] All checks passed! Build environment is ready.
```

### 6. Better Error Messages

Gradle provides clear, actionable error messages:

**Example 1: Version not found**
```
Invalid version: 10.99.9

Please choose from available versions:
  - 9.22
  - 9.56.1
  - 10.0
  - 10.02.0
  - 10.03.0
  - 10.03.1
  - 10.04.0
  - 10.05.0
  - 10.05.1
```

**Example 2: Missing binaries**
```
Failed to download Ghostscript binaries: Version 10.99.9 not found in releases.properties

You can manually download and extract Ghostscript binaries to:
  E:/Bearsampp-development/module-ghostscript/bin/ghostscript10.99.9/

Or check that version 10.99.9 exists in releases.properties
```

## Troubleshooting

### Issue: "Dev path not found"

**Error:**
```
Dev path not found: E:/Bearsampp-development/dev
```

**Solution:**
Ensure the `dev` project exists in the parent directory:
```
Bearsampp-development/
├── dev/
└── module-ghostscript/
```

### Issue: "7-Zip not found"

**Error:**
```
7-Zip not found. Please install 7-Zip or set 7Z_HOME environment variable.
```

**Solution:**
1. Install 7-Zip from https://www.7-zip.org/
2. Set `7Z_HOME` environment variable:
   ```bash
   set 7Z_HOME=C:\Program Files\7-Zip
   ```
3. Or ensure `7z.exe` is in your PATH

### Issue: "Java not found"

**Error:**
```
ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.
```

**Solution:**
1. Install Java 8 or higher
2. Set `JAVA_HOME` environment variable:
   ```bash
   set JAVA_HOME=C:\Program Files\Java\jdk-11
   ```

### Issue: Build output differs from Ant

**Solution:**
1. Ensure you're using the same version of 7-Zip
2. Check that `build.properties` is identical
3. Verify the source files are the same
4. Compare the temporary prep directories

## Rollback Plan

If you need to rollback to Ant:

1. The `build.xml` file is still present
2. Run Ant commands as before:
   ```bash
   ant release.build -Dbundle.path=bin/ghostscript10.05.1
   ```

The Gradle build doesn't modify any Ant files, so rollback is safe.

## Best Practices

### 1. Use Gradle Wrapper

Use the Gradle wrapper for consistent builds:

```bash
# Windows
gradlew.bat release -PbundleVersion=10.05.1

# Linux/Mac
./gradlew release -PbundleVersion=10.05.1
```

### 2. Set Build Path

Configure a consistent build path in `build.properties`:

```properties
build.path = C:/Bearsampp-build
```

Or set an environment variable:
```bash
set BEARSAMPP_BUILD_PATH=C:/Bearsampp-build
```

### 3. Use Interactive Mode for Manual Builds

For manual builds, use interactive mode:
```bash
gradle release
```

### 4. Use Non-Interactive Mode for CI/CD

For automated builds, always specify the version:
```bash
gradle release -PbundleVersion=10.05.1
```

### 5. Verify Before Deploying

Always run verification before deploying:
```bash
gradle verify
gradle release -PbundleVersion=10.05.1
```

## Support

If you encounter issues:

1. Run `gradle verify` to check your environment
2. Check the error message for suggestions
3. Review this migration guide
4. Check `GRADLE_BUILD.md` for detailed documentation
5. Review `ANT_TO_GRADLE_MAPPING.md` for task mappings

## Conclusion

The Gradle build is a complete replacement for Ant with:
- ✅ All Ant functionality preserved
- ✅ Same output structure
- ✅ Additional features
- ✅ Better error messages
- ✅ Faster builds
- ✅ No external dependencies

You can safely migrate to Gradle and optionally keep `build.xml` as a backup.
