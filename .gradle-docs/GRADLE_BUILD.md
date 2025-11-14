# Bearsampp Module Ghostscript - Gradle Build

This project has been converted from Ant to Gradle build system. The Gradle build provides all the functionality of the original Ant build with additional features and improvements.

## Prerequisites

- Java 8 or higher
- Gradle 8.5 or higher (must be installed on your system)
- 7-Zip (for creating .7z archives)

## Quick Start

```bash
gradle tasks
```

## Available Tasks

### Build Tasks

- **`gradle release -PbundleVersion=X.X.X`** - Build a specific version
  - Example: `gradle release -PbundleVersion=10.05.1`
  - Interactive mode: Run `gradle release` without parameters to select from available versions

- **`gradle releaseAll`** - Build all available versions in bin/ and bin/archived/ directories

- **`gradle clean`** - Clean build artifacts

### Information Tasks

- **`gradle info`** - Display build configuration and paths
- **`gradle listVersions`** - List all available versions in bin/ and bin/archived/
- **`gradle listReleases`** - List all releases from releases.properties

### Verification Tasks

- **`gradle verify`** - Verify build environment and dependencies
- **`gradle validateProperties`** - Validate build.properties configuration

## Project Structure

```
module-ghostscript/
├── bin/                          # Bundle versions
│   ├── ghostscript10.05.1/      # Current version
│   └── archived/                 # Archived versions
│       ├── ghostscript9.22/
│       ├── ghostscript9.56.1/
│       └── ...
├── build.gradle                  # Main Gradle build script
├── settings.gradle               # Gradle settings
├── build.properties              # Bundle configuration
└── releases.properties           # Download URLs for versions
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

### Build Path Priority

The build output path is determined in this order:
1. `build.path` property in build.properties
2. `BEARSAMPP_BUILD_PATH` environment variable
3. Default: `../bearsampp-build`

## Features

### Ant Build Compatibility

All Ant build tasks have been converted to Gradle:

| Ant Task | Gradle Equivalent | Description |
|----------|-------------------|-------------|
| `ant release.build` | `gradle release -PbundleVersion=X.X.X` | Build specific version |
| N/A | `gradle releaseAll` | Build all versions |
| N/A | `gradle clean` | Clean artifacts |

### Additional Features

1. **Interactive Mode**: Run `gradle release` without parameters to interactively select a version
2. **Archived Folder Support**: Automatically detects versions in both `bin/` and `bin/archived/`
3. **Download Support**: Automatically downloads missing binaries from releases.properties
4. **Hash Generation**: Generates MD5, SHA1, SHA256, and SHA512 hash files
5. **Build Cache**: Faster incremental builds with Gradle's build cache
6. **Better Error Messages**: Clear error messages with suggestions

### Build Process

The Gradle build follows the same process as the Ant build:

1. **Locate Bundle**: Find version in `bin/` or `bin/archived/`
2. **Download if Needed**: Download binaries from releases.properties if not present
3. **Prepare Files**: Copy Ghostscript files (excluding docs and examples)
4. **Create gs.exe**: Copy gswin64c.exe to gs.exe
5. **Add Configuration**: Copy bearsampp.conf and update_cidfmap.bat
6. **Create Archive**: Compress to .7z or .zip format
7. **Generate Hashes**: Create MD5, SHA1, SHA256, SHA512 hash files

### Output Structure

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

## Examples

### Build a Specific Version

```bash
gradle release -PbundleVersion=10.05.1
```

### Build All Versions

```bash
gradle releaseAll
```

### Interactive Build

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

### List Available Versions

```bash
gradle listVersions
```

### Verify Build Environment

```bash
gradle verify
```

## Troubleshooting

### 7-Zip Not Found

If you get an error about 7-Zip not being found:

1. Install 7-Zip from https://www.7-zip.org/
2. Set the `7Z_HOME` environment variable to your 7-Zip installation directory
3. Or ensure 7z.exe is in your PATH

### Dev Directory Not Found

Ensure the `dev` project exists in the parent directory:
```
Bearsampp-development/
├── dev/
└── module-ghostscript/
```

### Java Not Found

Ensure Java 8 or higher is installed and JAVA_HOME is set:
```bash
java -version
echo %JAVA_HOME%  # Windows
echo $JAVA_HOME   # Linux/Mac
```

### Gradle Not Found

Ensure Gradle 8.5+ is installed:
```bash
gradle --version
```

Install Gradle from https://gradle.org/install/

## Migration from Ant

The Gradle build is a complete replacement for the Ant build. Key differences:

1. **No External Dependencies**: Gradle build is self-contained
2. **Better Performance**: Gradle's incremental builds are faster
3. **More Features**: Interactive mode, automatic downloads, better error messages
4. **Same Output**: Produces identical archives as Ant build

You can safely remove `build.xml` after verifying the Gradle build works correctly.

## Contributing

When adding new versions:

1. Add the version directory to `bin/` or `bin/archived/`
2. Add the download URL to `releases.properties`
3. Run `gradle release -PbundleVersion=X.X.X` to build

## License

Same license as the main Bearsampp project.
