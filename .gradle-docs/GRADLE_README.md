# Gradle Build System - Quick Reference

## 🚀 Quick Start

### Build a Specific Version
```bash
gradle release -PbundleVersion=10.05.1
```

### Interactive Build (Select from Menu)
```bash
gradle release
```

### Build All Versions
```bash
gradle releaseAll
```

### List Available Versions
```bash
gradle listVersions
```

### Verify Environment
```bash
gradle verify
```

### Display Build Info
```bash
gradle info
```

### List All Tasks
```bash
gradle tasks
```

## 📚 Documentation

- **[GRADLE_BUILD.md](GRADLE_BUILD.md)** - Complete build documentation
- **[MIGRATION_GUIDE.md](MIGRATION_GUIDE.md)** - Ant to Gradle migration guide
- **[ANT_TO_GRADLE_MAPPING.md](ANT_TO_GRADLE_MAPPING.md)** - Task mapping reference
- **[GRADLE_CONVERSION_SUMMARY.md](GRADLE_CONVERSION_SUMMARY.md)** - Conversion summary

## ✨ Key Features

### From Ant Build
- ✅ All Ant functionality preserved
- ✅ Same output structure
- ✅ Compatible with existing workflows
- ✅ Uses same configuration files

### New in Gradle
- ✅ Interactive mode for version selection
- ✅ Automatic binary downloads
- ✅ Support for bin/archived folder
- ✅ Build all versions in one command
- ✅ Hash file generation (MD5, SHA1, SHA256, SHA512)
- ✅ Environment verification
- ✅ Better error messages
- ✅ Build cache for faster builds

## 🔄 Command Comparison

| Ant | Gradle |
|-----|--------|
| `ant release.build -Dbundle.path=bin/ghostscript10.05.1` | `gradle release -PbundleVersion=10.05.1` |
| N/A | `gradle release` (interactive) |
| N/A | `gradle releaseAll` |
| `ant clean` | `gradle clean` |

## 📁 Project Structure

```
module-ghostscript/
├── bin/                    # Bundle versions
│   ├── ghostscript10.05.1/ # Current version
│   └── archived/           # Archived versions
├── build.gradle            # Main build script
├── settings.gradle         # Gradle settings
├── build.properties       # Configuration
└── releases.properties    # Download URLs
```

## 🔧 Configuration

### build.properties
```properties
bundle.name = ghostscript
bundle.release = 2025.7.31
bundle.type = tools
bundle.format = 7z
#build.path = C:/Bearsampp-build
```

### Build Path Priority
1. `build.path` in build.properties
2. `BEARSAMPP_BUILD_PATH` environment variable
3. Default: `../bearsampp-build`

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

## ⚙️ Prerequisites

- Java 8 or higher
- Gradle 8.5 or higher
- 7-Zip (for .7z archives)
- Dev project in parent directory

Check with:
```bash
gradle verify
```

## 🐛 Troubleshooting

### Gradle Not Found
Install Gradle from https://gradle.org/install/

Check installation:
```bash
gradle --version
```

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

### Java Not Found
Install Java 8+ and set `JAVA_HOME`:
```bash
set JAVA_HOME=C:\Program Files\Java\jdk-11
```

## 📖 Examples

### Example 1: Build Latest Version
```bash
gradle release -PbundleVersion=10.05.1
```

### Example 2: Interactive Build
```bash
gradle release
# Select version from menu
```

### Example 3: Build All Versions
```bash
gradle releaseAll
```

### Example 4: List Versions
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

## 🎯 Common Tasks

### Daily Development
```bash
# Verify environment
gradle verify

# List available versions
gradle listVersions

# Build a version
gradle release -PbundleVersion=10.05.1
```

### Release Process
```bash
# Verify everything is ready
gradle verify

# Build all versions
gradle releaseAll

# Or build specific versions
gradle release -PbundleVersion=10.05.1
gradle release -PbundleVersion=10.05.0
```

### CI/CD Pipeline
```bash
# Non-interactive build
gradle release -PbundleVersion=10.05.1

# Verify before build
gradle verify && gradle release -PbundleVersion=10.05.1
```

## 🔗 Related Files

- `build.gradle` - Main build script
- `settings.gradle` - Gradle settings
- `build.properties` - Bundle configuration
- `releases.properties` - Download URLs
- `build.xml` - Original Ant build (preserved)

## 📝 Notes

- The Gradle build is a complete replacement for Ant
- All Ant functionality is preserved
- Additional features have been added
- The original `build.xml` is preserved for reference
- Output is identical to Ant builds
- Requires Gradle 8.5+ to be installed on your system

## 🆘 Support

For help:
1. Run `gradle tasks` to see all available tasks
2. Run `gradle info` to see build configuration
3. Check the documentation files listed above
4. Run `gradle verify` to check your environment

## ✅ Status

**Status:** ✅ Production Ready

The Gradle build has been fully tested and is ready for production use. All Ant functionality has been preserved and enhanced with additional features.

---

**Happy Building!** 🎉
