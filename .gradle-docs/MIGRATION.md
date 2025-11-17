# Migration Guide: Ant to Gradle

Complete guide for migrating from the legacy Ant build system to the new pure Gradle build.

---

## Table of Contents

- [Overview](#overview)
- [What Changed](#what-changed)
- [Command Mapping](#command-mapping)
- [File Changes](#file-changes)
- [Configuration Changes](#configuration-changes)
- [Task Equivalents](#task-equivalents)
- [Troubleshooting](#troubleshooting)
- [Benefits](#benefits)
- [Next Steps](#next-steps)

---

## Overview

The Bearsampp Module Ghostscript project has been fully migrated from Apache Ant to Gradle. This migration provides:

- **Modern Build System**     - Native Gradle tasks and conventions
- **Better Performance**       - Incremental builds and caching
- **Simplified Maintenance**   - Pure Groovy/Gradle DSL
- **Enhanced Tooling**         - IDE integration and dependency management
- **Cross-Platform Support**   - Works on Windows, Linux, and macOS

> **⚠️ Critical**: This project uses **system-installed Gradle only**. Apache Ant has been completely removed and Gradle Wrapper (gradlew/gradlew.bat) is not used. You must install Gradle 8.0+ on your system.

### Migration Status

| Component             | Status        | Notes                                    |
|-----------------------|---------------|------------------------------------------|
| **Build Files**       | ✅ Complete   | Converted to build.gradle                |
| **Release Process**   | ✅ Complete   | Native Gradle implementation             |
| **Download Support**  | ✅ Complete   | modules-untouched integration            |
| **Hash Generation**   | ✅ Complete   | MD5, SHA1, SHA256, SHA512                |
| **Interactive Mode**  | ✅ Complete   | Version selection menu                   |
| **Batch Build**       | ✅ Complete   | releaseAll task                          |
| **Documentation**     | ✅ Complete   | Comprehensive Gradle docs                |

---

## What Changed

### Removed Files

| File              | Status        | Replacement                              |
|-------------------|---------------|------------------------------------------|
| `build.xml`       | ❌ Removed    | `build.gradle`                           |

### New Files

| File                          | Purpose                                  |
|-------------------------------|------------------------------------------|
| `build.gradle`                | Main Gradle build script (pure Gradle)   |
| `settings.gradle`             | Gradle project settings                  |
| `.gradle-docs/README.md`      | Main documentation                       |
| `.gradle-docs/TASKS.md`       | Task reference                           |
| `.gradle-docs/CONFIGURATION.md` | Configuration guide                    |
| `.gradle-docs/API.md`         | API reference                            |
| `.gradle-docs/MIGRATION.md`   | This migration guide                     |
| `.gradle-docs/INDEX.md`       | Documentation index                      |

### Modified Files

| File              | Changes                                  |
|-------------------|------------------------------------------|
| `README.md`       | Updated with Gradle build information    |
| `gradle.properties` | Enhanced with performance settings     |

---

## Command Mapping

### Basic Commands

| Ant Command                                              | Gradle Command                              | Notes                    |
|----------------------------------------------------------|---------------------------------------------|--------------------------|
| `ant`                                                    | `gradle info`                               | Default task changed     |
| `ant -projecthelp`                                       | `gradle tasks`                              | List all tasks           |
| `ant release.build -Dbundle.path=bin/ghostscript10.05.1` | `gradle release -PbundleVersion=10.05.1`    | Build specific version   |
| N/A                                                      | `gradle release`                            | Interactive mode (new)   |
| N/A                                                      | `gradle releaseAll`                         | Build all versions (new) |
| `ant clean`                                              | `gradle clean`                              | Clean artifacts          |

### Advanced Commands

| Ant Command                          | Gradle Command                              | Notes                    |
|--------------------------------------|---------------------------------------------|--------------------------|
| `ant -v release.build`               | `gradle release --info`                     | Verbose output           |
| `ant -d release.build`               | `gradle release --debug`                    | Debug output             |
| `ant -k release.build`               | `gradle release --continue`                 | Continue on failure      |

### New Commands (Gradle Only)

| Command                              | Description                                  |
|--------------------------------------|----------------------------------------------|
| `gradle verify`                      | Verify build environment                     |
| `gradle listVersions`                | List available versions                      |
| `gradle listReleases`                | List releases from properties                |
| `gradle validateProperties`          | Validate build.properties                    |
| `gradle checkModulesUntouched`       | Check modules-untouched integration          |
| `gradle info`                        | Display build information                    |

---

## File Changes

### build.xml → build.gradle

#### Ant (build.xml)

```xml
<project name="module-ghostscript" default="release.build">
    <property file="build.properties"/>
    
    <target name="release.build">
        <copy todir="${bundle.tmp.prep}">
            <fileset dir="${bundle.path}"/>
        </copy>
        <!-- More XML configuration -->
    </target>
</project>
```

#### Gradle (build.gradle)

```groovy
plugins {
    id 'base'
}

// Load build properties
def buildProps = new Properties()
file('build.properties').withInputStream { buildProps.load(it) }

// Project configuration
group = 'com.bearsampp.modules'
version = buildProps.getProperty('bundle.release', '1.0.0')

// Tasks
tasks.register('release') {
    group = 'build'
    description = 'Build release package'
    
    doLast {
        // Pure Groovy implementation
    }
}
```

### Key Differences

| Aspect              | Ant                          | Gradle                           |
|---------------------|------------------------------|----------------------------------|
| **Build File**      | XML (build.xml)              | Groovy DSL (build.gradle)        |
| **Task Definition** | `<target name="...">`        | `tasks.register('...')`          |
| **Properties**      | `<property name="..." />`    | `ext { ... }`                    |
| **Dependencies**    | Manual downloads             | Automatic with repositories      |
| **Caching**         | None                         | Built-in incremental builds      |
| **IDE Support**     | Limited                      | Excellent (IntelliJ, Eclipse)    |

---

## Configuration Changes

### build.properties

**No changes required** - The same build.properties file works with both Ant and Gradle.

```properties
bundle.name    = ghostscript
bundle.release = 2025.7.31
bundle.type    = tools
bundle.format  = 7z
```

### gradle.properties

**Enhanced** with performance settings:

```properties
# Gradle daemon configuration
org.gradle.daemon=true
org.gradle.parallel=true
org.gradle.caching=true

# JVM settings
org.gradle.jvmargs=-Xmx2g -XX:MaxMetaspaceSize=512m
```

### releases.properties

**No changes required** - The same releases.properties file works with both Ant and Gradle.

---

## Task Equivalents

### Build Tasks

| Ant Target            | Gradle Task           | Description                      |
|-----------------------|-----------------------|----------------------------------|
| `release.build`       | `release`             | Build release package            |
| N/A                   | `releaseAll`          | Build all versions (new)         |
| `clean`               | `clean`               | Clean build artifacts            |

### Verification Tasks

| Ant Target            | Gradle Task           | Description                      |
|-----------------------|-----------------------|----------------------------------|
| N/A                   | `verify`              | Verify build environment (new)   |
| N/A                   | `validateProperties`  | Validate build.properties (new)  |
| N/A                   | `checkModulesUntouched` | Check modules-untouched (new) |

### Information Tasks

| Ant Target            | Gradle Task           | Description                      |
|-----------------------|-----------------------|----------------------------------|
| N/A                   | `info`                | Display build information (new)  |
| N/A                   | `listVersions`        | List available versions (new)    |
| N/A                   | `listReleases`        | List releases (new)              |

---

## Troubleshooting

### Common Migration Issues

#### Issue 1: Ant Commands Not Working

**Problem:**
```bash
ant release.build
# Command not found or deprecated
```

**Solution:**
```bash
# Use Gradle instead
gradle release -PbundleVersion=10.05.1
```

---

#### Issue 2: Build Path Changed

**Problem:**
```
Output directory structure is different
```

**Solution:**
Gradle uses the same output structure as Ant:
- `bearsampp-build/tmp/` - Temporary files
- `bearsampp-build/tools/ghostscript/{bundle.release}/` - Final archives

---

#### Issue 3: Missing Gradle

**Problem:**
```bash
gradle: command not found
```

**Solution:**
```bash
# Install Gradle 8.0+
# Windows (Chocolatey):
choco install gradle

# Or download from: https://gradle.org/install/
```

---

#### Issue 4: Java Version Too Old

**Problem:**
```
Java 8+ required
```

**Solution:**
```bash
# Check Java version
java -version

# Install Java 8 or higher
# Update JAVA_HOME environment variable
```

---

#### Issue 5: 7-Zip Not Found

**Problem:**
```
7-Zip not found
```

**Solution:**
```bash
# Install 7-Zip
# Set 7Z_HOME environment variable
set 7Z_HOME=C:\Program Files\7-Zip
```

---

### Migration Checklist

- [ ] Install Gradle 8.0+
- [ ] Install Java 8+
- [ ] Install 7-Zip (if using 7z format)
- [ ] Run `gradle verify` to check environment
- [ ] Test build with `gradle release -PbundleVersion=10.05.1`
- [ ] Update CI/CD scripts to use Gradle commands
- [ ] Update documentation references
- [ ] Remove old Ant build files (optional)

---

## Benefits

### Performance Improvements

| Feature               | Ant           | Gradle        | Improvement  |
|-----------------------|---------------|---------------|--------------|
| **Build Cache**       | ❌ No         | ✅ Yes        | Faster rebuilds |
| **Incremental Builds**| ❌ No         | ✅ Yes        | Only rebuild changed files |
| **Parallel Execution**| ❌ No         | ✅ Yes        | Faster multi-version builds |
| **Daemon**            | ❌ No         | ✅ Yes        | Faster startup |

### Feature Enhancements

| Feature               | Ant           | Gradle        | Notes        |
|-----------------------|---------------|---------------|--------------|
| **Interactive Mode**  | ❌ No         | ✅ Yes        | Version selection menu |
| **Batch Build**       | ❌ No         | ✅ Yes        | Build all versions |
| **Download Support**  | ❌ Limited    | ✅ Full       | modules-untouched integration |
| **Hash Generation**   | ❌ No         | ✅ Yes        | MD5, SHA1, SHA256, SHA512 |
| **Verification**      | �� No         | ✅ Yes        | Environment checks |
| **IDE Integration**   | ❌ Limited    | ✅ Excellent  | IntelliJ, Eclipse, VS Code |

### Maintenance Benefits

| Aspect                | Ant           | Gradle        | Notes        |
|-----------------------|---------------|---------------|--------------|
| **Code Clarity**      | XML           | Groovy DSL    | More readable |
| **Modularity**        | Limited       | Excellent     | Reusable functions |
| **Testing**           | Manual        | Built-in      | Task testing |
| **Documentation**     | Limited       | Comprehensive | Full docs |
| **Community**         | Declining     | Active        | Better support |

---

## Next Steps

### For Developers

1. **Learn Gradle Basics**
   - Read [README.md](.gradle-docs/README.md)
   - Review [TASKS.md](.gradle-docs/TASKS.md)
   - Explore [CONFIGURATION.md](.gradle-docs/CONFIGURATION.md)

2. **Update Workflows**
   - Replace Ant commands with Gradle equivalents
   - Update build scripts
   - Test new build process

3. **Explore New Features**
   - Try interactive mode: `gradle release`
   - Use batch build: `gradle releaseAll`
   - Check environment: `gradle verify`

### For CI/CD

1. **Update Build Scripts**
   ```bash
   # Old (Ant)
   ant release.build -Dbundle.path=bin/ghostscript10.05.1
   
   # New (Gradle)
   gradle release -PbundleVersion=10.05.1
   ```

2. **Add Verification Step**
   ```bash
   gradle verify
   ```

3. **Enable Caching**
   ```bash
   # In CI/CD configuration
   gradle release -PbundleVersion=10.05.1 --build-cache
   ```

### For Contributors

1. **Read Documentation**
   - [API.md](.gradle-docs/API.md) - Build script API
   - [CONFIGURATION.md](.gradle-docs/CONFIGURATION.md) - Configuration guide

2. **Understand Build Process**
   - Review build.gradle
   - Study helper functions
   - Test custom tasks

3. **Contribute Improvements**
   - Add new tasks
   - Improve documentation
   - Report issues

---

## Additional Resources

- [Gradle Documentation](https://docs.gradle.org/)
- [Bearsampp Project](https://github.com/bearsampp/bearsampp)
- [Ghostscript Downloads](https://www.ghostscript.com/releases/)
- [modules-untouched Repository](https://github.com/Bearsampp/modules-untouched)

---

## Support

For migration help:

- **GitHub Issues**: https://github.com/bearsampp/module-ghostscript/issues
- **Bearsampp Issues**: https://github.com/bearsampp/bearsampp/issues
- **Documentation**: [.gradle-docs/](.gradle-docs/)

---

**Last Updated**: 2025-01-31  
**Version**: 2025.7.31  
**Migration Status**: ✅ Complete
