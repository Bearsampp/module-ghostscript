# Gradle Tasks Reference

Complete reference for all available Gradle tasks in the Bearsampp Module Ghostscript project.

> **⚠️ Important**: All commands use **system-installed Gradle** (e.g., `gradle <task>`). Neither Apache Ant nor Gradle Wrapper (gradlew/gradlew.bat) are used in this project.

---

## Table of Contents

- [Build Tasks](#build-tasks)
- [Verification Tasks](#verification-tasks)
- [Information Tasks](#information-tasks)
- [Task Dependencies](#task-dependencies)
- [Task Examples](#task-examples)

---

## Build Tasks

### `release`

**Group:** build  
**Description:** Build release package. Interactive by default; non-interactive when `-PbundleVersion` is provided.

**Usage:**
```bash
# Interactive mode (default — prompts for version)
gradle release

# Non-interactive (build specific version)
gradle release -PbundleVersion=10.05.1
```

**Parameters:**

| Parameter         | Type     | Required | Description                    | Example      |
|-------------------|----------|----------|--------------------------------|--------------|
| `bundleVersion`   | String   | No       | Ghostscript version to build   | `10.05.1`    |

**Process:**
1. Validates environment and version
2. Checks for local bundle in `bin/` or `bin/archived/`
3. If not found locally, downloads from modules-untouched or releases.properties
4. Creates preparation directory
5. Copies Ghostscript files (excluding docs and examples)
6. Creates `gs.exe` from `gswin64c.exe` or `gswin32c.exe`
7. Copies configuration files (bearsampp.conf, update_cidfmap.bat)
8. Outputs prepared bundle to `bearsampp-build/tmp/bundles_prep/tools/ghostscript/`
9. Packages into archive in `bearsampp-build/tools/ghostscript/{bundle.release}/`

**Output Locations:**
- Prepared folder: `bearsampp-build/tmp/bundles_prep/tools/ghostscript/ghostscript{version}/`
- Build folder: `bearsampp-build/tmp/bundles_build/tools/ghostscript/ghostscript{version}/`
- Final archive: `bearsampp-build/tools/ghostscript/{bundle.release}/bearsampp-ghostscript-{version}-{bundle.release}.{7z|zip}`

---

### `releaseAll`

**Group:** build  
**Description:** Build release packages for all available versions in bin/ and bin/archived/ directories

**Usage:**
```bash
gradle releaseAll
```

**Process:**
- Discovers all versions in `bin/` and `bin/archived/`
- Builds each version sequentially
- Provides summary of successful and failed builds

**Output:**
```
Building releases for 9 ghostscript versions
=======================================================================
[1/9] Building ghostscript 9.22...
[SUCCESS] ghostscript 9.22 completed
...
=======================================================================
Build Summary
=======================================================================
Total versions: 9
Successful:     9
Failed:         0
=======================================================================
[SUCCESS] All versions built successfully!
```

---

### `clean`

**Group:** build  
**Description:** Clean build artifacts and temporary files

**Usage:**
```bash
gradle clean
```

**Cleans:**
- `build/` directory
- All temporary build files

**Output:**
```
[SUCCESS] Build artifacts cleaned
```

---

## Verification Tasks

### `verify`

**Group:** verification  
**Description:** Verify build environment and dependencies

**Usage:**
```bash
gradle verify
```

**Checks:**

| Check                  | Description                              | Required |
|------------------------|------------------------------------------|----------|
| Java 8+                | Java version 8 or higher                 | Yes      |
| build.properties       | Build configuration file exists          | Yes      |
| releases.properties    | Release definitions file exists          | Yes      |
| dev directory          | Dev project directory exists             | Yes      |
| bin directory          | Ghostscript versions directory exists    | Yes      |
| bin/archived directory | Archived versions directory exists       | Yes      |
| 7-Zip                  | 7-Zip executable available (if format=7z)| Conditional |

**Output:**
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

You can now run:
  gradle release -PbundleVersion=10.05.1   - Build release for version
  gradle listVersions                      - List available versions
```

---

### `validateProperties`

**Group:** verification  
**Description:** Validate build.properties configuration

**Usage:**
```bash
gradle validateProperties
```

**Validates:**

| Property          | Required | Description                    |
|-------------------|----------|--------------------------------|
| `bundle.name`     | Yes      | Name of the bundle             |
| `bundle.release`  | Yes      | Release version                |
| `bundle.type`     | Yes      | Type of bundle                 |
| `bundle.format`   | Yes      | Archive format                 |

**Output:**
```
[SUCCESS] All required properties are present:
    bundle.name = ghostscript
    bundle.release = 2025.7.31
    bundle.type = tools
    bundle.format = 7z
```

---

### `checkModulesUntouched`

**Group:** verification  
**Description:** Check modules-untouched repository integration and available versions

**Usage:**
```bash
gradle checkModulesUntouched
```

**Output:**
```
=======================================================================
Modules-Untouched Integration Check
=======================================================================

Repository URL:
  https://raw.githubusercontent.com/Bearsampp/modules-untouched/main/modules/ghostscript.properties

Fetching ghostscript.properties from modules-untouched...

=======================================================================
Available Versions in modules-untouched
=======================================================================
  9.22
  9.56.1
  10.0
  10.02.0
  10.03.0
  10.03.1
  10.04.0
  10.05.0
  10.05.1
=======================================================================
Total versions: 9

=======================================================================
[SUCCESS] modules-untouched integration is working
=======================================================================

Version Resolution Strategy:
  1. Check modules-untouched ghostscript.properties (remote)
  2. Check local releases.properties (fallback)
  3. Construct standard URL format (fallback)
```

---

## Information Tasks

### `info`

**Group:** help  
**Description:** Display build configuration information

**Usage:**
```bash
gradle info
```

**Displays:**
- Project information (name, version, description)
- Bundle properties (name, release, type, format)
- Paths (project dir, root dir, dev path, build paths)
- Java information (version, home)
- Gradle information (version, home)
- Available task groups
- Quick start commands

**Output:**
```
================================================================
          Bearsampp Module Ghostscript - Build Info
================================================================

Project:        module-ghostscript
Version:        2025.7.31
Description:    Bearsampp Module - ghostscript

Bundle Properties:
  Name:         ghostscript
  Release:      2025.7.31
  Type:         tools
  Format:       7z

Paths:
  Project Dir:  E:/Bearsampp-development/module-ghostscript
  Root Dir:     E:/Bearsampp-development
  Dev Path:     E:/Bearsampp-development/dev
  Build Base:   E:/Bearsampp-development/bearsampp-build
  ...

Quick Start:
  gradle tasks                              - List all available tasks
  gradle info                               - Show this information
  gradle release -PbundleVersion=10.05.1    - Build specific version
  gradle releaseAll                         - Build all versions
  gradle clean                              - Clean build artifacts
  gradle verify                             - Verify build environment
```

---

### `listVersions`

**Group:** help  
**Description:** List all available bundle versions in bin/ and bin/archived/ directories

**Usage:**
```bash
gradle listVersions
```

**Output:**
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

To build a specific version:
  gradle release -PbundleVersion=10.05.1
```

---

### `listReleases`

**Group:** help  
**Description:** List all available releases from modules-untouched or releases.properties

**Usage:**
```bash
gradle listReleases
```

**Output:**
```
Available Ghostscript Releases (modules-untouched):
--------------------------------------------------------------------------------
  9.22       -> https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs922/gs922w64.exe
  9.56.1     -> https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs9561/gs9561w64.exe
  10.0       -> https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs1000/gs1000w64.exe
  ...
--------------------------------------------------------------------------------
Total releases: 9
```

---

## Task Dependencies

### Task Execution Order

```
release
  ├── (validates environment)
  ├── (checks local bin/ or bin/archived/)
  ├── (downloads if needed from modules-untouched or releases.properties)
  ├── (creates directories)
  ├── (copies Ghostscript files)
  ├── (creates gs.exe)
  ├── (copies configuration files)
  └── (packages into archive)

releaseAll
  └── (calls release for each version)
```

### Task Groups

| Group            | Tasks                                                                      |
|------------------|----------------------------------------------------------------------------|
| **build**        | `release`, `releaseAll`, `clean`                                           |
| **verification** | `verify`, `validateProperties`, `checkModulesUntouched`                    |
| **help**         | `info`, `listVersions`, `listReleases`                                     |

---

## Task Examples

### Example 1: Complete Build Workflow

```bash
# 1. Verify environment
gradle verify

# 2. List available versions
gradle listVersions

# 3. Check modules-untouched integration
gradle checkModulesUntouched

# 4. Build a specific release
gradle release -PbundleVersion=10.05.1

# 5. Clean up
gradle clean
```

---

### Example 2: Build All Versions

```bash
# Verify environment first
gradle verify

# Build all versions
gradle releaseAll
```

---

### Example 3: Interactive Build

```bash
# Run release without parameters for interactive mode
gradle release

# Select version from menu:
# Available versions:
#   1. 9.22            [bin/archived]
#   2. 9.56.1          [bin/archived]
#   3. 10.0            [bin/archived]
#   ...
#   9. 10.05.1         [bin]
#
# Enter version to build (index or exact version):
# 9
```

---

### Example 4: Debugging a Build

```bash
# Run with info logging
gradle release -PbundleVersion=10.05.1 --info

# Run with debug logging
gradle release -PbundleVersion=10.05.1 --debug

# Run with stack trace on error
gradle release -PbundleVersion=10.05.1 --stacktrace
```

---

### Example 5: Validation Workflow

```bash
# Validate build properties
gradle validateProperties

# Verify environment
gradle verify

# Check modules-untouched integration
gradle checkModulesUntouched
```

---

### Example 6: Information Gathering

```bash
# Get build info
gradle info

# List all available versions
gradle listVersions

# List all releases from modules-untouched
gradle listReleases
```

---

## Task Options

### Common Gradle Options

| Option              | Description                              | Example                                  |
|---------------------|------------------------------------------|------------------------------------------|
| `--info`            | Set log level to INFO                    | `gradle release --info`                  |
| `--debug`           | Set log level to DEBUG                   | `gradle release --debug`                 |
| `--stacktrace`      | Print stack trace on error               | `gradle release --stacktrace`            |
| `--scan`            | Create build scan                        | `gradle release --scan`                  |
| `--dry-run`         | Show what would be executed              | `gradle release --dry-run`               |
| `--parallel`        | Execute tasks in parallel                | `gradle releaseAll --parallel`           |
| `--offline`         | Execute build without network access     | `gradle release --offline`               |

---

## Task Properties

### Project Properties

Set via `-P` flag:

| Property          | Type     | Description                    | Example                                  |
|-------------------|----------|--------------------------------|------------------------------------------|
| `bundleVersion`   | String   | Ghostscript version to build   | `-PbundleVersion=10.05.1`                |

### System Properties

Set via `-D` flag:

| Property          | Type     | Description                    | Example                                  |
|-------------------|----------|--------------------------------|------------------------------------------|
| `org.gradle.daemon` | Boolean | Enable Gradle daemon         | `-Dorg.gradle.daemon=true`               |
| `org.gradle.parallel` | Boolean | Enable parallel execution  | `-Dorg.gradle.parallel=true`             |

---

## Download Behavior

### Source Priority

When building a version, the system follows this priority:

1. **Local bin/ directory**: Check `bin/ghostscript{version}/`
2. **Local bin/archived/ directory**: Check `bin/archived/ghostscript{version}/`
3. **modules-untouched repository**: Download from remote properties file
4. **releases.properties**: Download from local configuration

### Caching

Downloaded files are cached in:
- `bearsampp-build/tmp/downloads/ghostscript/` - Downloaded archives
- `bearsampp-build/tmp/extract/ghostscript/` - Extracted files

Subsequent builds will use cached files if available.

---

**Last Updated**: 2025-01-31  
**Version**: 2025.7.31
