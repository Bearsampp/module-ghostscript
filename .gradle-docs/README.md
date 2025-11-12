# Gradle Build Documentation

This directory contains complete documentation for the Gradle build system.

## Documentation Files

### Quick Start
- **[GRADLE_README.md](GRADLE_README.md)** - Quick reference guide with common commands and examples

### Setup & Installation
- **[GRADLE_SETUP.md](GRADLE_SETUP.md)** - Complete setup guide for Java, Gradle, and 7-Zip installation

### Build Documentation
- **[GRADLE_BUILD.md](GRADLE_BUILD.md)** - Comprehensive build documentation with all features and tasks

### Source Management
- **[SOURCE_DOWNLOAD_BEHAVIOR.md](SOURCE_DOWNLOAD_BEHAVIOR.md)** - How the build finds and downloads source files (modules-untouched, releases.properties, etc.)

### Migration & Conversion
- **[MIGRATION_GUIDE.md](MIGRATION_GUIDE.md)** - Step-by-step guide for migrating from Ant to Gradle
- **[ANT_TO_GRADLE_MAPPING.md](ANT_TO_GRADLE_MAPPING.md)** - Complete mapping of Ant tasks to Gradle equivalents
- **[GRADLE_CONVERSION_SUMMARY.md](GRADLE_CONVERSION_SUMMARY.md)** - Summary of the conversion process and features

## Quick Links

### For New Users
1. Start with [GRADLE_SETUP.md](GRADLE_SETUP.md) to install prerequisites
2. Read [GRADLE_README.md](GRADLE_README.md) for quick reference
3. Run `gradle verify` to check your environment

### For Ant Users
1. Read [MIGRATION_GUIDE.md](MIGRATION_GUIDE.md) for migration steps
2. Check [ANT_TO_GRADLE_MAPPING.md](ANT_TO_GRADLE_MAPPING.md) for command equivalents
3. Review [GRADLE_CONVERSION_SUMMARY.md](GRADLE_CONVERSION_SUMMARY.md) for what changed

### For Developers
1. Read [GRADLE_BUILD.md](GRADLE_BUILD.md) for complete build documentation
2. Check [SOURCE_DOWNLOAD_BEHAVIOR.md](SOURCE_DOWNLOAD_BEHAVIOR.md) to understand source management
3. Run `gradle tasks` to see all available tasks

## Common Commands

```bash
# Quick start
gradle verify                              # Verify environment
gradle listVersions                        # List available versions
gradle release -PbundleVersion=10.05.1    # Build specific version
gradle release                             # Interactive mode
gradle releaseAll                          # Build all versions

# Information
gradle info                                # Display build info
gradle tasks                               # List all tasks
gradle listReleases                        # List releases from properties

# Verification
gradle verify                              # Verify environment
gradle validateProperties                  # Validate configuration
```

## Documentation Structure

```
.gradle-docs/
├── README.md                          # This file
├── GRADLE_README.md                   # Quick reference
├── GRADLE_BUILD.md                    # Complete build docs
├── GRADLE_SETUP.md                    # Setup guide
├── SOURCE_DOWNLOAD_BEHAVIOR.md        # Source management
├── MIGRATION_GUIDE.md                 # Ant to Gradle migration
├── ANT_TO_GRADLE_MAPPING.md          # Task mapping
└── GRADLE_CONVERSION_SUMMARY.md      # Conversion summary
```

## Getting Help

1. **Check documentation** - Read the relevant doc file above
2. **Run gradle tasks** - See all available tasks: `gradle tasks`
3. **Run gradle info** - See build configuration: `gradle info`
4. **Run gradle verify** - Check environment: `gradle verify`

## Key Features

### Core Features
- ✅ All Ant functionality preserved
- ✅ Same output structure as Ant
- ✅ Compatible with existing workflows
- ✅ Uses same configuration files

### New Features
- ✅ Interactive mode for version selection
- ✅ Automatic binary downloads
- ✅ Support for bin/archived folder
- ✅ Support for modules-untouched repository
- ✅ Build all versions in one command
- ✅ Hash file generation (MD5, SHA1, SHA256, SHA512)
- ✅ Environment verification
- ✅ Better error messages
- ✅ Build cache for faster builds

## Prerequisites

- Java 8 or higher
- Gradle 8.5 or higher
- 7-Zip (for .7z archives)
- Dev project in parent directory

See [GRADLE_SETUP.md](GRADLE_SETUP.md) for installation instructions.

## Status

✅ **Production Ready** - The Gradle build is fully tested and ready for production use.

---

**Need help?** Start with [GRADLE_README.md](GRADLE_README.md) for a quick overview.
