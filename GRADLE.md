# Gradle Build System

This project uses a pure Gradle build for releases. The Ant build system has been removed.

## Quick Start

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
```

## Documentation

All documentation is consolidated under the `/.gradle-docs` directory:

- [GRADLE_README.md](/.gradle-docs/GRADLE_README.md) - Quick reference guide
- [GRADLE_BUILD.md](/.gradle-docs/GRADLE_BUILD.md) - Complete build documentation
- [GRADLE_SETUP.md](/.gradle-docs/GRADLE_SETUP.md) - Installation and setup guide
- [SOURCE_DOWNLOAD_BEHAVIOR.md](/.gradle-docs/SOURCE_DOWNLOAD_BEHAVIOR.md) - Source download flow
- [REMOTE_PROPERTIES_FEATURE.md](/.gradle-docs/REMOTE_PROPERTIES_FEATURE.md) - Remote properties support
- [BUGFIX_SUMMARY.md](/.gradle-docs/BUGFIX_SUMMARY.md) - Bug fixes and improvements
- [TEST_MISSING_VERSION.md](/.gradle-docs/TEST_MISSING_VERSION.md) - Testing documentation
- [MIGRATION_GUIDE.md](/.gradle-docs/MIGRATION_GUIDE.md) - Migration from Ant to Gradle
- [ANT_TO_GRADLE_MAPPING.md](/.gradle-docs/ANT_TO_GRADLE_MAPPING.md) - Task mapping reference
- [GRADLE_CONVERSION_SUMMARY.md](/.gradle-docs/GRADLE_CONVERSION_SUMMARY.md) - Conversion summary

## Prerequisites

- Java 8 or higher
- Gradle 8.5 or higher
- 7-Zip (for .7z archives)

Check your environment:
```bash
gradle verify
```

## Key Features

### From Ant Build
- ✅ Functionality preserved
- ✅ Same output structure
- ✅ Compatible with existing workflows
- ✅ Uses same configuration files

### New in Gradle
- ✅ Interactive mode for version selection
- ✅ Automatic binary downloads
- ✅ Support for bin/archived folder
- ✅ Support for modules-untouched repository
- ✅ Build all versions in one command
- ✅ Hash file generation (MD5, SHA1, SHA256, SHA512)
- ✅ Environment verification
- ✅ Better error messages
- ✅ Build cache for faster builds

## Source Download Priority

When building a module, Gradle checks for source files in this order:

1. **Local bin/ directory** - `bin/ghostscript{version}/`
2. **Local bin/archived/ directory** - `bin/archived/ghostscript{version}/`
3. **modules-untouched repository** - `../modules-untouched/ghostscript/ghostscript{version}/` (like Ant)
4. **Download from releases.properties** - Downloads from GitHub releases

See [SOURCE_DOWNLOAD_BEHAVIOR.md](.gradle-docs/SOURCE_DOWNLOAD_BEHAVIOR.md) for details.

## Common Commands

### Build Tasks
```bash
gradle release -PbundleVersion=10.05.1    # Build specific version
gradle release                             # Interactive mode
gradle releaseAll                          # Build all versions
gradle clean                               # Clean artifacts
```

### Information Tasks
```bash
gradle info                                # Display build info
gradle listVersions                        # List available versions
gradle listReleases                        # List releases from properties
gradle tasks                               # List all tasks
```

### Verification Tasks
```bash
gradle verify                              # Verify environment
gradle validateProperties                  # Validate configuration
```

## Configuration

### build.properties
```properties
bundle.name = ghostscript
bundle.release = 2025.7.31
bundle.type = tools
bundle.format = 7z
#build.path = C:/Bearsampp-build
```

### releases.properties
```properties
10.05.1 = https://github.com/Bearsampp/module-ghostscript/releases/download/2025.7.31/bearsampp-ghostscript-10.05.1-2025.7.31.7z
```

## Output Structure

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

## Testing

Run the automated test script:
```bash
test-gradle-build.bat
```

## Troubleshooting

### Gradle Not Found
Install Gradle from https://gradle.org/install/

### 7-Zip Not Found
Install 7-Zip and set `7Z_HOME` environment variable:
```bash
set 7Z_HOME=C:\Program Files\7-Zip
```

### Dev Directory Not Found
Ensure the dev project exists:
```
Bearsampp-development/
├── dev/
└── module-ghostscript/
```

## Support

For detailed help, see the documentation in `.gradle-docs/` or run:
```bash
gradle tasks    # List all available tasks
gradle info     # Show build configuration
gradle verify   # Check environment
```

## Status

✅ **Production Ready** - The Gradle build is fully tested and ready for production use.

---

For complete documentation, see the `.gradle-docs/` directory.
