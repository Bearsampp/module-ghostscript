# Configuration Guide

Complete configuration guide for the Bearsampp Module Ghostscript Gradle build system.

---

## Table of Contents

- [Configuration Files](#configuration-files)
- [Build Properties](#build-properties)
- [Gradle Properties](#gradle-properties)
- [Ghostscript Version Configuration](#ghostscript-version-configuration)
- [Environment Variables](#environment-variables)
- [Build Path Configuration](#build-path-configuration)

---

## Configuration Files

### Overview

| File                  | Purpose                                  | Format     | Location      |
|-----------------------|------------------------------------------|------------|---------------|
| `build.properties`    | Main build configuration                 | Properties | Root          |
| `gradle.properties`   | Gradle-specific settings                 | Properties | Root          |
| `settings.gradle`     | Gradle project settings                  | Groovy     | Root          |
| `build.gradle`        | Main build script                        | Groovy     | Root          |
| `releases.properties` | Available Ghostscript releases           | Properties | Root          |

---

## Build Properties

### File: `build.properties`

**Location:** `E:/Bearsampp-development/module-ghostscript/build.properties`

**Purpose:** Main build configuration for the Ghostscript module

### Properties

| Property          | Type     | Required | Default         | Description                          |
|-------------------|----------|----------|-----------------|--------------------------------------|
| `bundle.name`     | String   | Yes      | `ghostscript`   | Name of the bundle                   |
| `bundle.release`  | String   | Yes      | -               | Release version (YYYY.MM.DD)         |
| `bundle.type`     | String   | Yes      | `tools`         | Type of bundle                       |
| `bundle.format`   | String   | Yes      | `7z`            | Archive format for output            |
| `build.path`      | String   | No       | -               | Custom build output path             |

### Example

```properties
bundle.name    = ghostscript
bundle.release = 2025.7.31
bundle.type    = tools
bundle.format  = 7z
#build.path    = C:/Bearsampp-build
```

### Usage in Build Script

```groovy
def buildProps = new Properties()
file('build.properties').withInputStream { buildProps.load(it) }

def bundleName = buildProps.getProperty('bundle.name', 'ghostscript')
def bundleRelease = buildProps.getProperty('bundle.release', '1.0.0')
```

---

## Gradle Properties

### File: `gradle.properties`

**Location:** `E:/Bearsampp-development/module-ghostscript/gradle.properties`

**Purpose:** Gradle-specific configuration and JVM settings

### Properties

| Property                      | Type     | Default      | Description                          |
|-------------------------------|----------|--------------|--------------------------------------|
| `org.gradle.daemon`           | Boolean  | `true`       | Enable Gradle daemon                 |
| `org.gradle.parallel`         | Boolean  | `true`       | Enable parallel task execution       |
| `org.gradle.caching`          | Boolean  | `true`       | Enable build caching                 |
| `org.gradle.jvmargs`          | String   | -            | JVM arguments for Gradle             |
| `org.gradle.configureondemand`| Boolean  | `false`      | Configure projects on demand         |

### Example

```properties
# Gradle daemon configuration
org.gradle.daemon=true
org.gradle.parallel=true
org.gradle.caching=true

# JVM settings
org.gradle.jvmargs=-Xmx2g -XX:MaxMetaspaceSize=512m -XX:+HeapDumpOnOutOfMemoryError

# Configure on demand
org.gradle.configureondemand=false
```

### Performance Tuning

| Setting                       | Recommended Value | Purpose                              |
|-------------------------------|-------------------|--------------------------------------|
| `org.gradle.daemon`           | `true`            | Faster builds with daemon            |
| `org.gradle.parallel`         | `true`            | Parallel task execution              |
| `org.gradle.caching`          | `true`            | Cache task outputs                   |
| `org.gradle.jvmargs`          | `-Xmx2g`          | Allocate 2GB heap for Gradle         |

---

## Ghostscript Version Configuration

### Directory Structure

Each Ghostscript version has its own directory in `bin/` or `bin/archived/`:

```
bin/
├── ghostscript10.05.1/
│   ├── bin/
│   │   ├── gswin64c.exe
│   │   └── ...
│   ├── bearsampp.conf
│   └── update_cidfmap.bat
└── archived/
    ├── ghostscript9.22/
    ├── ghostscript9.56.1/
    ├── ghostscript10.0/
    ├── ghostscript10.02.0/
    ├── ghostscript10.03.0/
    ├── ghostscript10.03.1/
    ├── ghostscript10.04.0/
    └── ghostscript10.05.0/
```

### Version Naming Convention

| Pattern                       | Example              | Description                          |
|-------------------------------|----------------------|--------------------------------------|
| `ghostscript{major}.{minor}.{patch}` | `ghostscript10.05.1` | Standard Ghostscript version format |
| `ghostscript{major}.{minor}`  | `ghostscript10.0`    | Version without patch number         |

### Required Files

Each version directory should contain:

| File/Directory        | Required | Description                          |
|-----------------------|----------|--------------------------------------|
| `bin/gswin64c.exe`    | Yes*     | 64-bit Ghostscript executable        |
| `bin/gswin32c.exe`    | Yes*     | 32-bit Ghostscript executable        |
| `bearsampp.conf`      | No       | Bearsampp configuration file         |
| `update_cidfmap.bat`  | No       | CID font map update script           |

*At least one of gswin64c.exe or gswin32c.exe must be present

---

## Build Path Configuration

### Build Path Priority

The build system determines the output path using the following priority:

| Priority | Source                                  | Description                          |
|----------|-----------------------------------------|--------------------------------------|
| 1        | `build.path` in build.properties        | Explicit path in config file         |
| 2        | `BEARSAMPP_BUILD_PATH` env variable     | Environment variable override        |
| 3        | `../bearsampp-build`                    | Default relative path                |

### Example Configurations

**Option 1: Use default path**
```properties
# build.properties
bundle.name    = ghostscript
bundle.release = 2025.7.31
bundle.type    = tools
bundle.format  = 7z
# No build.path specified - uses ../bearsampp-build
```

**Option 2: Specify custom path in build.properties**
```properties
# build.properties
bundle.name    = ghostscript
bundle.release = 2025.7.31
bundle.type    = tools
bundle.format  = 7z
build.path     = C:/Bearsampp-build
```

**Option 3: Use environment variable**
```bash
# Set environment variable
set BEARSAMPP_BUILD_PATH=D:/CustomBuildPath

# build.properties (no build.path specified)
bundle.name    = ghostscript
bundle.release = 2025.7.31
bundle.type    = tools
bundle.format  = 7z
```

### Output Directory Structure

```
bearsampp-build/
├── tmp/
│   ├── bundles_prep/
│   │   └── tools/
│   │       └── ghostscript/
│   │           └── ghostscript10.05.1/
│   ├── bundles_build/
│   │   └── tools/
│   │       └── ghostscript/
│   │           └── ghostscript10.05.1/
│   ├── downloads/
│   │   └── ghostscript/
│   └── extract/
│       └── ghostscript/
└── tools/
    └── ghostscript/
        └── 2025.7.31/
            ├── bearsampp-ghostscript-10.05.1-2025.7.31.7z
            ├── bearsampp-ghostscript-10.05.1-2025.7.31.7z.md5
            ├── bearsampp-ghostscript-10.05.1-2025.7.31.7z.sha1
            ├── bearsampp-ghostscript-10.05.1-2025.7.31.7z.sha256
            └── bearsampp-ghostscript-10.05.1-2025.7.31.7z.sha512
```

---

## Environment Variables

### Build Environment

| Variable          | Description                          | Example                              |
|-------------------|--------------------------------------|--------------------------------------|
| `JAVA_HOME`       | Java installation directory          | `C:\Program Files\Java\jdk-11`       |
| `GRADLE_HOME`     | Gradle installation directory        | `C:\Gradle\gradle-8.5`               |
| `PATH`            | System path (includes Java, Gradle)  | -                                    |
| `7Z_HOME`         | 7-Zip installation directory         | `C:\Program Files\7-Zip`             |

### Optional Variables

| Variable                  | Description                          | Default                              |
|---------------------------|--------------------------------------|--------------------------------------|
| `BEARSAMPP_BUILD_PATH`    | Custom build output path             | `../bearsampp-build`                 |
| `GRADLE_USER_HOME`        | Gradle user home directory           | `~/.gradle`                          |
| `GRADLE_OPTS`             | Additional Gradle JVM options        | -                                    |

---

## Releases Configuration

### File: `releases.properties`

**Location:** `E:/Bearsampp-development/module-ghostscript/releases.properties`

**Purpose:** Define download URLs for Ghostscript versions

### Format

```properties
{version}={download_url}
```

### Example

```properties
9.22=https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs922/gs922w64.exe
9.56.1=https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs9561/gs9561w64.exe
10.0=https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs1000/gs1000w64.exe
10.02.0=https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs1002/gs1002w64.exe
10.03.0=https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs1003/gs1003w64.exe
10.03.1=https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs10031/gs10031w64.exe
10.04.0=https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs1004/gs1004w64.exe
10.05.0=https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs1005/gs1005w64.exe
10.05.1=https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs10051/gs10051w64.exe
```

### Download Priority

When building a version, the system follows this priority:

1. **Local bin/ directory**: Check `bin/ghostscript{version}/`
2. **Local bin/archived/ directory**: Check `bin/archived/ghostscript{version}/`
3. **modules-untouched repository**: Download from remote properties file
4. **releases.properties**: Download from local configuration

---

## Configuration Examples

### Example 1: Basic Configuration

**build.properties:**
```properties
bundle.name    = ghostscript
bundle.release = 2025.7.31
bundle.type    = tools
bundle.format  = 7z
```

**Result:**
- Output path: `../bearsampp-build/tools/ghostscript/2025.7.31/`
- Archive format: 7z
- Uses default build path

---

### Example 2: Custom Build Path

**build.properties:**
```properties
bundle.name    = ghostscript
bundle.release = 2025.7.31
bundle.type    = tools
bundle.format  = 7z
build.path     = C:/Bearsampp-build
```

**Result:**
- Output path: `C:/Bearsampp-build/tools/ghostscript/2025.7.31/`
- Archive format: 7z
- Uses custom build path

---

### Example 3: ZIP Format

**build.properties:**
```properties
bundle.name    = ghostscript
bundle.release = 2025.7.31
bundle.type    = tools
bundle.format  = zip
```

**Result:**
- Output path: `../bearsampp-build/tools/ghostscript/2025.7.31/`
- Archive format: zip
- Uses default build path

---

## Configuration Validation

### Validate Configuration

```bash
# Validate build.properties
gradle validateProperties

# Verify entire environment
gradle verify

# List available versions
gradle listVersions

# List available releases
gradle listReleases

# Check modules-untouched integration
gradle checkModulesUntouched
```

### Validation Checklist

| Item                      | Command                          | Expected Result              |
|---------------------------|----------------------------------|------------------------------|
| Build properties          | `gradle validateProperties`      | All required properties set  |
| Environment               | `gradle verify`                  | All checks pass              |
| Versions                  | `gradle listVersions`            | Versions listed              |
| Releases                  | `gradle listReleases`            | Releases listed              |
| modules-untouched         | `gradle checkModulesUntouched`   | Integration working          |

---

## Best Practices

### Configuration Management

1. **Version Control:** Keep all `.properties` files in version control
2. **Documentation:** Document custom configurations
3. **Validation:** Always run `gradle verify` after configuration changes
4. **Testing:** Test builds with new configurations before committing
5. **Backup:** Keep backups of working configurations

### Version Management

1. **Naming:** Use consistent version naming (ghostscript{version})
2. **Organization:** Keep current versions in `bin/`, archived in `bin/archived/`
3. **Documentation:** Document version-specific configurations
4. **Testing:** Test each version after adding
5. **Cleanup:** Archive old versions regularly

### Performance Optimization

1. **Gradle Daemon:** Enable for faster builds
2. **Parallel Execution:** Enable for multi-core systems
3. **Build Cache:** Enable for incremental builds
4. **JVM Heap:** Allocate sufficient memory (2GB+)
5. **Network:** Use fast, reliable network for downloads
6. **Caching:** Downloaded files are cached in `bearsampp-build/tmp/`

---

## Troubleshooting

### Common Issues

**Issue: Build path not found**
```
Solution: Check build.path in build.properties or set BEARSAMPP_BUILD_PATH
```

**Issue: 7-Zip not found**
```
Solution: Install 7-Zip and set 7Z_HOME environment variable
```

**Issue: Version not found**
```
Solution: Check bin/ and bin/archived/ directories, or add to releases.properties
```

**Issue: Download failed**
```
Solution: Check network connection and URL in releases.properties
```

---

**Last Updated**: 2025-01-31  
**Version**: 2025.7.31
