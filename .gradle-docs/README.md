# Bearsampp Module Ghostscript - Gradle Build Documentation

## Table of Contents

- [Overview](#overview)
- [Quick Start](#quick-start)
- [Installation](#installation)
- [Build Tasks](#build-tasks)
- [Configuration](#configuration)
- [Architecture](#architecture)
- [Troubleshooting](#troubleshooting)
- [Migration Guide](#migration-guide)

---

## Overview

The Bearsampp Module Ghostscript project has been converted to a **pure Gradle build system**, replacing the legacy Ant build configuration. This provides:

- **Modern Build System**     - Native Gradle tasks and conventions
- **Better Performance**       - Incremental builds and caching
- **Simplified Maintenance**   - Pure Groovy/Gradle DSL
- **Enhanced Tooling**         - IDE integration and dependency management
- **Cross-Platform Support**   - Works on Windows, Linux, and macOS

> **⚠️ Important Note**: This project uses **system-installed Gradle only**. Neither Apache Ant nor Gradle Wrapper (gradlew/gradlew.bat) are used or supported. You must install Gradle 8.0+ on your system before building.

### Project Information

| Property          | Value                                    |
|-------------------|------------------------------------------|
| **Project Name**  | module-ghostscript                       |
| **Group**         | com.bearsampp.modules                    |
| **Type**          | Ghostscript Module Builder               |
| **Build Tool**    | Gradle 8.x+                              |
| **Language**      | Groovy (Gradle DSL)                      |

---

## Quick Start

### Prerequisites

| Requirement       | Version       | Purpose                                  |
|-------------------|---------------|------------------------------------------|
| **Java**          | 8+            | Required for Gradle execution            |
| **Gradle**        | 8.0+          | Build automation tool                    |
| **7-Zip**         | Latest        | Archive extraction and creation          |

### Basic Commands

```bash
# Display build information
gradle info

# List all available tasks
gradle tasks

# Verify build environment
gradle verify

# Build a release (interactive)
gradle release

# Build a specific version (non-interactive)
gradle release -PbundleVersion=10.05.1

# Build all versions
gradle releaseAll

# Clean build artifacts
gradle clean
```

---

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/bearsampp/module-ghostscript.git
cd module-ghostscript
```

### 2. Verify Environment

```bash
gradle verify
```

This will check:
- Java version (8+)
- Required files (build.properties, releases.properties)
- Directory structure (bin/, bin/archived/)
- Build dependencies
- 7-Zip availability (if format=7z)

### 3. List Available Versions

```bash
gradle listVersions
```

### 4. Build Your First Release

```bash
# Interactive mode (prompts for version)
gradle release

# Or specify version directly
gradle release -PbundleVersion=10.05.1
```

---

## Build Tasks

### Core Build Tasks

| Task                  | Description                                      | Example                                  |
|-----------------------|--------------------------------------------------|------------------------------------------|
| `release`             | Build and package release (interactive/non-interactive) | `gradle release -PbundleVersion=10.05.1` |
| `releaseAll`          | Build all available versions                     | `gradle releaseAll`                      |
| `clean`               | Clean build artifacts and temporary files        | `gradle clean`                           |

### Verification Tasks

| Task                      | Description                                  | Example                                      |
|---------------------------|----------------------------------------------|----------------------------------------------|
| `verify`                  | Verify build environment and dependencies    | `gradle verify`                              |
| `validateProperties`      | Validate build.properties configuration      | `gradle validateProperties`                  |
| `checkModulesUntouched`   | Check modules-untouched integration          | `gradle checkModulesUntouched`               |

### Information Tasks

| Task                | Description                                      | Example                    |
|---------------------|--------------------------------------------------|----------------------------|
| `info`              | Display build configuration information          | `gradle info`              |
| `listVersions`      | List available bundle versions in bin/           | `gradle listVersions`      |
| `listReleases`      | List all available releases from properties      | `gradle listReleases`      |

### Task Groups

| Group            | Purpose                                          |
|------------------|--------------------------------------------------|
| **build**        | Build and package tasks                          |
| **verification** | Verification and validation tasks                |
| **help**         | Help and information tasks                       |

---

## Configuration

### build.properties

The main configuration file for the build:

```properties
bundle.name    = ghostscript
bundle.release = 2025.7.31
bundle.type    = tools
bundle.format  = 7z
#build.path    = C:/Bearsampp-build
```

| Property          | Description                          | Example Value  |
|-------------------|--------------------------------------|----------------|
| `bundle.name`     | Name of the bundle                   | `ghostscript`  |
| `bundle.release`  | Release version                      | `2025.7.31`    |
| `bundle.type`     | Type of bundle                       | `tools`        |
| `bundle.format`   | Archive format                       | `7z`           |
| `build.path`      | Custom build output path (optional)  | `C:/Bearsampp-build` |

### gradle.properties

Gradle-specific configuration:

```properties
# Gradle daemon configuration
org.gradle.daemon=true
org.gradle.parallel=true
org.gradle.caching=true

# JVM settings
org.gradle.jvmargs=-Xmx2g -XX:MaxMetaspaceSize=512m
```

### Directory Structure

```
module-ghostscript/
├── .gradle-docs/          # Gradle documentation
│   ├── README.md          # Main documentation (this file)
│   ├── TASKS.md           # Task reference
│   ├── CONFIGURATION.md   # Configuration guide
│   ├── API.md             # API reference
│   ├── MIGRATION.md       # Migration guide
│   └── INDEX.md           # Documentation index
├── bin/                   # Ghostscript version bundles
│   ├── ghostscript10.05.1/
│   └── archived/
│       ├── ghostscript9.22/
│       ├── ghostscript9.56.1/
│       └── ...
├── bearsampp-build/       # External build directory (outside repo)
│   ├── tmp/               # Temporary build files
│   │   ├── bundles_prep/tools/ghostscript/
│   │   ├── bundles_build/tools/ghostscript/
│   │   ├── downloads/ghostscript/
│   │   └── extract/ghostscript/
│   └── tools/ghostscript/ # Final packaged archives
│       └── 2025.7.31/
│           ├── bearsampp-ghostscript-10.05.1-2025.7.31.7z
│           ├── bearsampp-ghostscript-10.05.1-2025.7.31.7z.md5
│           └── ...
├── build.gradle           # Main Gradle build script
├── settings.gradle        # Gradle settings
├── build.properties       # Build configuration
└── releases.properties    # Available Ghostscript releases
```

---

## Architecture

### Build Process Flow

```
1. User runs: gradle release -PbundleVersion=10.05.1
                    ↓
2. Validate environment and version
                    ↓
3. Check for local bundle in bin/ or bin/archived/
                    ↓
4. If not found, download from:
   - modules-untouched repository (remote)
   - releases.properties (fallback)
                    ↓
5. Create preparation directory (tmp/prep/)
                    ↓
6. Copy Ghostscript files (excluding docs/examples)
                    ↓
7. Create gs.exe from gswin64c.exe or gswin32c.exe
                    ↓
8. Copy configuration files (bearsampp.conf, update_cidfmap.bat)
                    ↓
9. Output prepared bundle to tmp/prep/
                    ↓
10. Package prepared folder into archive in bearsampp-build/tools/ghostscript/{bundle.release}/
    - The archive includes the top-level folder: ghostscript{version}/
```

### Packaging Details

- **Archive name format**: `bearsampp-ghostscript-{version}-{bundle.release}.{7z|zip}`
- **Location**: `bearsampp-build/tools/ghostscript/{bundle.release}/`
  - Example: `bearsampp-build/tools/ghostscript/2025.7.31/bearsampp-ghostscript-10.05.1-2025.7.31.7z`
- **Content root**: The top-level folder inside the archive is `ghostscript{version}/` (e.g., `ghostscript10.05.1/`)
- **Structure**: The archive contains the Ghostscript version folder at the root with all files inside

**Archive Structure Example**:
```
bearsampp-ghostscript-10.05.1-2025.7.31.7z
└── ghostscript10.05.1/    ← Version folder at root
    ├── bin/
    │   ├── gswin64c.exe
    │   ├── gs.exe
    │   └── ...
    ├── bearsampp.conf
    ├── update_cidfmap.bat
    └── ...
```

**Hash Files**: Each archive is accompanied by hash sidecar files:
- `.md5` - MD5 checksum
- `.sha1` - SHA-1 checksum
- `.sha256` - SHA-256 checksum
- `.sha512` - SHA-512 checksum

### Download Priority

When building a version, the system follows this priority:

1. **Local bin/ directory**: Check `bin/ghostscript{version}/`
2. **Local bin/archived/ directory**: Check `bin/archived/ghostscript{version}/`
3. **modules-untouched repository**: Download from remote properties file
4. **releases.properties**: Download from local configuration

Downloaded files are cached in `bearsampp-build/tmp/downloads/` and `bearsampp-build/tmp/extract/`.

---

## Troubleshooting

### Common Issues

#### Issue: "Dev path not found"

**Symptom:**
```
Dev path not found: E:/Bearsampp-development/dev
```

**Solution:**
This is a warning only. The dev path is optional for most tasks. If you need it, ensure the `dev` project exists in the parent directory.

---

#### Issue: "Bundle version not found"

**Symptom:**
```
Bundle version not found: E:/Bearsampp-development/module-ghostscript/bin/ghostscript10.05.99
```

**Solution:**
1. List available versions: `gradle listVersions`
2. Use an existing version: `gradle release -PbundleVersion=10.05.1`
3. Or add the version to releases.properties for download

---

#### Issue: "7-Zip not found"

**Symptom:**
```
7-Zip not found. Please install 7-Zip or set 7Z_HOME environment variable.
```

**Solution:**
1. Install 7-Zip from https://www.7-zip.org/
2. Set 7Z_HOME environment variable: `set 7Z_HOME=C:\Program Files\7-Zip`

---

#### Issue: "Java version too old"

**Symptom:**
```
Java 8+ required
```

**Solution:**
1. Check Java version: `java -version`
2. Install Java 8 or higher
3. Update JAVA_HOME environment variable

---

### Debug Mode

Run Gradle with debug output:

```bash
gradle release -PbundleVersion=10.05.1 --info
gradle release -PbundleVersion=10.05.1 --debug
```

### Clean Build

If you encounter issues, try a clean build:

```bash
gradle clean
gradle release -PbundleVersion=10.05.1
```

---

## Migration Guide

### From Ant to Gradle

The project has been fully migrated from Ant to Gradle. Here's what changed:

#### Removed Files

| File              | Status    | Replacement                |
|-------------------|-----------|----------------------------|
| `build.xml`       | ❌ Removed | `build.gradle`             |

#### Command Mapping

| Ant Command                                              | Gradle Command                              |
|----------------------------------------------------------|---------------------------------------------|
| `ant release.build -Dbundle.path=bin/ghostscript10.05.1` | `gradle release -PbundleVersion=10.05.1`    |
| N/A                                                      | `gradle release` (interactive)              |
| N/A                                                      | `gradle releaseAll`                         |
| `ant clean`                                              | `gradle clean`                              |

#### Key Differences

| Aspect              | Ant                          | Gradle                           |
|---------------------|------------------------------|----------------------------------|
| **Build File**      | XML (build.xml)              | Groovy DSL (build.gradle)        |
| **Task Definition** | `<target name="...">`        | `tasks.register('...')`          |
| **Properties**      | `<property name="..." />`    | `ext { ... }`                    |
| **Caching**         | None                         | Built-in incremental builds      |
| **IDE Support**     | Limited                      | Excellent (IntelliJ, Eclipse)    |

For complete migration guide, see [MIGRATION.md](MIGRATION.md)

---

## Additional Resources

- **Complete Documentation**: [INDEX.md](INDEX.md) - Documentation index
- **Task Reference**: [TASKS.md](TASKS.md) - All available tasks
- **Configuration Guide**: [CONFIGURATION.md](CONFIGURATION.md) - Configuration details
- **API Reference**: [API.md](API.md) - Build script API
- **Migration Guide**: [MIGRATION.md](MIGRATION.md) - Ant to Gradle migration
- **Gradle Documentation**: https://docs.gradle.org/
- **Bearsampp Project**: https://github.com/bearsampp/bearsampp
- **Ghostscript Downloads**: https://www.ghostscript.com/releases/

---

## Support

For issues and questions:

- **GitHub Issues**: https://github.com/bearsampp/module-ghostscript/issues
- **Bearsampp Issues**: https://github.com/bearsampp/bearsampp/issues
- **Documentation**: https://bearsampp.com/module/ghostscript

---

**Last Updated**: 2025-01-31  
**Version**: 2025.7.31  
**Build System**: Pure Gradle (no wrapper, no Ant)

Notes:
- This project deliberately does not ship the Gradle Wrapper. Install Gradle 8+ locally and run with `gradle ...`.
- Legacy Ant files have been removed and replaced with pure Gradle implementation.

## 🚀 Quick Start

### Prerequisites

| Requirement          | Version      | Description                              |
|----------------------|--------------|------------------------------------------|
| Java                 | 8 or higher  | Required for Gradle execution            |
| Gradle               | 8.5+         | Must be installed on your system         |
| 7-Zip                | Latest       | Required for .7z archive creation        |

### Basic Commands

```bash
# Verify environment
gradle verify

# List available versions
gradle listVersions

# Build a specific version
gradle release -PbundleVersion=10.05.1

# Build interactively (select from menu)
gradle release

# Build all versions
gradle releaseAll

# Display build info
gradle info

# List all tasks
gradle tasks
```

## 📖 Getting Started

1. **First Time Setup**: Read [GRADLE_SETUP.md](GRADLE_SETUP.md)
2. **Quick Reference**: See [GRADLE_README.md](GRADLE_README.md)
3. **Complete Guide**: Read [GRADLE_BUILD.md](GRADLE_BUILD.md)
4. **Migration from Ant**: See [MIGRATION_GUIDE.md](MIGRATION_GUIDE.md)

## 🔄 Build System

This project uses a **pure Gradle build system**. The Ant build has been removed.

### Key Features

| Feature                    | Description                                                      |
|----------------------------|------------------------------------------------------------------|
| Interactive Mode           | Run `gradle release` to select version from menu                 |
| Archived Folder Support    | Detects versions in both `bin/` and `bin/archived/`             |
| Download Support           | Automatically downloads missing binaries                         |
| Hash Generation            | Generates MD5, SHA1, SHA256, SHA512 hash files                   |
| Build Cache                | Faster incremental builds with Gradle's build cache              |
| Better Error Messages      | Clear error messages with actionable suggestions                 |

### Command Comparison

| Ant Command (Removed)                                    | Gradle Command                              | Description                    |
|----------------------------------------------------------|---------------------------------------------|--------------------------------|
| `ant release.build -Dbundle.path=bin/ghostscript10.05.1` | `gradle release -PbundleVersion=10.05.1`    | Build specific version         |
| N/A                                                      | `gradle release`                            | Interactive mode               |
| N/A                                                      | `gradle releaseAll`                         | Build all versions             |
| `ant clean`                                              | `gradle clean`                              | Clean build artifacts          |

## 📁 Project Structure

```
module-ghostscript/
├── .gradle-docs/              # Documentation (you are here)
│   ├── README.md              # This file
│   ├── GRADLE_README.md       # Quick reference
│   ├── GRADLE_BUILD.md        # Complete build guide
│   ├── GRADLE_SETUP.md        # Setup instructions
│   └── ...                    # Additional documentation
├── bin/                       # Bundle versions
│   ├── ghostscript10.05.1/    # Current version
│   └── archived/              # Archived versions
├── build.gradle               # Main Gradle build script
├── settings.gradle            # Gradle project settings
├── build.properties           # Bundle configuration
└── releases.properties        # Download URLs for versions
```

## 🔧 Configuration

### build.properties

```properties
bundle.name    = ghostscript
bundle.release = 2025.7.31
bundle.type    = tools
bundle.format  = 7z
#build.path    = C:/Bearsampp-build
```

### Build Path Priority

| Priority | Source                                  | Description                          |
|----------|-----------------------------------------|--------------------------------------|
| 1        | `build.path` in build.properties        | Explicit path in config file         |
| 2        | `BEARSAMPP_BUILD_PATH` env variable     | Environment variable override        |
| 3        | `../bearsampp-build`                    | Default relative path                |

## 📦 Output Structure

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

## 🧪 Testing

Run the automated test script:
```bash
test-gradle-build.bat
```

Or test manually:
```bash
gradle verify
gradle listVersions
gradle release -PbundleVersion=10.05.1
```

## 🐛 Troubleshooting

### Common Issues

| Issue                    | Solution                                                      |
|--------------------------|---------------------------------------------------------------|
| Gradle Not Found         | Install Gradle from https://gradle.org/install/               |
| 7-Zip Not Found          | Install 7-Zip and set `7Z_HOME` environment variable          |
| Dev Directory Not Found  | Ensure `dev` project exists in parent directory               |
| Java Not Found           | Install Java 8+ and set `JAVA_HOME` environment variable      |

### Verification

```bash
# Check environment
gradle verify

# Check Gradle version
gradle --version

# Check Java version
java -version
```

## 📝 Notes

- **Pure Gradle Build**: Ant build system has been removed
- **No Wrapper**: Uses system-installed Gradle (no wrapper)
- **Backward Compatible**: Output identical to previous Ant builds
- **Enhanced Features**: Additional functionality beyond Ant
- **Production Ready**: Fully tested and ready for use

## 🆘 Support

For help:

1. Run `gradle tasks` to see all available tasks
2. Run `gradle info` to see build configuration
3. Check the documentation files listed above
4. Run `gradle verify` to check your environment

## ✅ Status

**Status:** ✅ Production Ready

The Gradle build is fully tested and ready for production use. All Ant functionality has been preserved and enhanced with additional features.

---

**Documentation Version:** 2025.7.31  
**Last Updated:** 2025  
**Build System:** Pure Gradle (Ant removed)
