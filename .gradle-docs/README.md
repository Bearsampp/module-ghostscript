# Bearsampp Module Ghostscript - Documentation

This directory contains comprehensive documentation for the Gradle build system.

## 📚 Documentation Index

| Document                                                                      | Description                                  |
|-------------------------------------------------------------------------------|----------------------------------------------|
| [GRADLE_README.md](GRADLE_README.md)                                         | Quick reference guide                        |
| [GRADLE_BUILD.md](GRADLE_BUILD.md)                                           | Complete build documentation                 |
| [GRADLE_SETUP.md](GRADLE_SETUP.md)                                           | Installation and setup guide                 |
| [SOURCE_DOWNLOAD_BEHAVIOR.md](SOURCE_DOWNLOAD_BEHAVIOR.md)                   | Source download flow and priority            |
| [REMOTE_PROPERTIES_FEATURE.md](REMOTE_PROPERTIES_FEATURE.md)                 | Remote properties support                    |
| [MIGRATION_GUIDE.md](MIGRATION_GUIDE.md)                                     | Migration from Ant to Gradle                 |
| [ANT_TO_GRADLE_MAPPING.md](ANT_TO_GRADLE_MAPPING.md)                         | Task mapping reference                       |
| [GRADLE_CONVERSION_SUMMARY.md](GRADLE_CONVERSION_SUMMARY.md)                 | Conversion summary                           |
| [BUGFIX_SUMMARY.md](BUGFIX_SUMMARY.md)                                       | Bug fixes and improvements                   |
| [TEST_MISSING_VERSION.md](TEST_MISSING_VERSION.md)                           | Testing documentation                        |

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
