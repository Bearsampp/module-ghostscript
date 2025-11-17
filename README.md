<p align="center"><a href="https://bearsampp.com/contribute" target="_blank"><img width="250" src="img/Bearsampp-logo.svg"></a></p>

[![GitHub release](https://img.shields.io/github/release/bearsampp/module-ghostscript.svg?style=flat-square)](https://github.com/bearsampp/module-ghostscript/releases/latest)
![Total downloads](https://img.shields.io/github/downloads/bearsampp/module-ghostscript/total.svg?style=flat-square)

This is a module of [Bearsampp project](https://github.com/bearsampp/bearsampp) involving Ghostscript.

## Build System

This project uses **Gradle** as its build system. The legacy Ant build has been fully replaced with a modern, pure Gradle implementation.

> **Important**: This project uses **system-installed Gradle** only. Neither Ant nor Gradle Wrapper (gradlew) are used. You must have Gradle 8.0+ installed on your system.

### Quick Start

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

# Clean build artifacts
gradle clean
```

### Prerequisites

| Requirement       | Version       | Purpose                                  |
|-------------------|---------------|------------------------------------------|
| **Java**          | 8+            | Required for Gradle execution            |
| **Gradle**        | 8.0+          | Build automation tool                    |
| **7-Zip**         | Latest        | Archive extraction and creation          |

### Available Tasks

| Task                  | Description                                      |
|-----------------------|--------------------------------------------------|
| `release`             | Build release package (interactive/non-interactive) |
| `releaseAll`          | Build all available versions                     |
| `clean`               | Clean build artifacts and temporary files        |
| `verify`              | Verify build environment and dependencies        |
| `info`                | Display build configuration information          |
| `listVersions`        | List available bundle versions in bin/           |
| `listReleases`        | List available releases from properties          |
| `validateProperties`  | Validate build.properties configuration          |

For complete documentation, see [.gradle-docs/README.md](.gradle-docs/README.md)

## Documentation

- **Build Documentation**: [.gradle-docs/README.md](.gradle-docs/README.md)
- **Task Reference**: [.gradle-docs/TASKS.md](.gradle-docs/TASKS.md)
- **Configuration Guide**: [.gradle-docs/CONFIGURATION.md](.gradle-docs/CONFIGURATION.md)
- **API Reference**: [.gradle-docs/API.md](.gradle-docs/API.md)
- **Module Downloads**: https://bearsampp.com/module/ghostscript

## Issues

Issues must be reported on [Bearsampp repository](https://github.com/bearsampp/bearsampp/issues).
