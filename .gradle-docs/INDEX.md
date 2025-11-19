# Documentation Index

Complete index of all Gradle build documentation for Bearsampp Module Ghostscript.

---

## Quick Links

| Document              | Description                                      | Link                          |
|-----------------------|--------------------------------------------------|-------------------------------|
| **Main Documentation**| Complete build system guide                      | [README.md](README.md)        |
| **Task Reference**    | All available Gradle tasks                       | [TASKS.md](TASKS.md)          |
| **Configuration**     | Configuration files and properties               | [CONFIGURATION.md](CONFIGURATION.md) |
| **API Reference**     | Build script API and helper functions            | [API.md](API.md)              |
| **Migration Guide**   | Ant to Gradle migration guide                    | [MIGRATION.md](MIGRATION.md)  |

---

## Documentation Structure

```
.gradle-docs/
├── INDEX.md              # This file - Documentation index
├── README.md             # Main documentation and quick start
├── TASKS.md              # Complete task reference
├── CONFIGURATION.md      # Configuration guide
├── API.md                # API reference for build scripts
└── MIGRATION.md          # Ant to Gradle migration guide
```

---

## Getting Started

### New Users

1. **Start Here**: [README.md](README.md) - Overview and quick start
2. **Verify Setup**: Run `gradle verify` to check environment
3. **List Tasks**: Run `gradle tasks` to see available tasks
4. **Build Release**: Run `gradle release -PbundleVersion=10.05.1`

### Migrating from Ant

1. **Migration Guide**: [MIGRATION.md](MIGRATION.md) - Complete migration guide
2. **Command Mapping**: See command equivalents in migration guide
3. **File Changes**: Understand what changed from Ant to Gradle
4. **Troubleshooting**: Common migration issues and solutions

### Advanced Users

1. **Task Reference**: [TASKS.md](TASKS.md) - All tasks with examples
2. **Configuration**: [CONFIGURATION.md](CONFIGURATION.md) - Advanced configuration
3. **API Reference**: [API.md](API.md) - Build script API and extensions
4. **Custom Tasks**: Create custom tasks using API reference

---

## Documentation by Topic

### Build System

| Topic                 | Document              | Section                          |
|-----------------------|-----------------------|----------------------------------|
| Overview              | README.md             | Overview                         |
| Quick Start           | README.md             | Quick Start                      |
| Installation          | README.md             | Installation                     |
| Architecture          | README.md             | Architecture                     |

### Tasks

| Topic                 | Document              | Section                          |
|-----------------------|-----------------------|----------------------------------|
| Build Tasks           | TASKS.md              | Build Tasks                      |
| Verification Tasks    | TASKS.md              | Verification Tasks               |
| Information Tasks     | TASKS.md              | Information Tasks                |
| Task Examples         | TASKS.md              | Task Examples                    |

### Configuration

| Topic                 | Document              | Section                          |
|-----------------------|-----------------------|----------------------------------|
| Build Properties      | CONFIGURATION.md      | Build Properties                 |
| Gradle Properties     | CONFIGURATION.md      | Gradle Properties                |
| Ghostscript Versions  | CONFIGURATION.md      | Ghostscript Version Configuration|
| Build Path            | CONFIGURATION.md      | Build Path Configuration         |
| Releases              | CONFIGURATION.md      | Releases Configuration           |

### API

| Topic                 | Document              | Section                          |
|-----------------------|-----------------------|----------------------------------|
| Build Script API      | API.md                | Build Script API                 |
| Helper Functions      | API.md                | Helper Functions                 |
| Extension Points      | API.md                | Extension Points                 |
| Properties API        | API.md                | Properties API                   |
| Task API              | API.md                | Task API                         |

### Migration

| Topic                 | Document              | Section                          |
|-----------------------|-----------------------|----------------------------------|
| Overview              | MIGRATION.md          | Overview                         |
| What Changed          | MIGRATION.md          | What Changed                     |
| Command Mapping       | MIGRATION.md          | Command Mapping                  |
| File Changes          | MIGRATION.md          | File Changes                     |
| Troubleshooting       | MIGRATION.md          | Troubleshooting                  |

---

## Common Tasks

### Building

| Task                                      | Document      | Reference                        |
|-------------------------------------------|---------------|----------------------------------|
| Build a release                           | README.md     | Quick Start                      |
| Build specific version                    | TASKS.md      | release task                     |
| Build all versions                        | TASKS.md      | releaseAll task                  |
| Clean build artifacts                     | TASKS.md      | clean task                       |

### Configuration

| Task                                      | Document      | Reference                        |
|-------------------------------------------|---------------|----------------------------------|
| Configure build properties                | CONFIGURATION.md | Build Properties              |
| Configure build path                      | CONFIGURATION.md | Build Path Configuration      |
| Configure releases                        | CONFIGURATION.md | Releases Configuration        |

### Verification

| Task                                      | Document      | Reference                        |
|-------------------------------------------|---------------|----------------------------------|
| Verify build environment                  | TASKS.md      | verify task                      |
| Validate properties                       | TASKS.md      | validateProperties task          |
| Check modules-untouched                   | TASKS.md      | checkModulesUntouched task       |

### Information

| Task                                      | Document      | Reference                        |
|-------------------------------------------|---------------|----------------------------------|
| Display build info                        | TASKS.md      | info task                        |
| List available versions                   | TASKS.md      | listVersions task                |
| List available releases                   | TASKS.md      | listReleases task                |

---

## Quick Reference

### Essential Commands

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

### Essential Files

| File                  | Purpose                                  |
|-----------------------|------------------------------------------|
| `build.gradle`        | Main Gradle build script                 |
| `settings.gradle`     | Gradle project settings                  |
| `build.properties`    | Build configuration                      |
| `gradle.properties`   | Gradle-specific settings                 |
| `releases.properties` | Available Ghostscript releases           |

### Essential Directories

| Directory                  | Purpose                                  |
|----------------------------|------------------------------------------|
| `bin/`                     | Ghostscript version bundles              |
| `bin/archived/`            | Archived Ghostscript versions            |
| `bearsampp-build/tmp/`     | Temporary build files (external)         |
| `bearsampp-build/tools/`   | Final packaged archives (external)       |
| `.gradle-docs/`            | Gradle documentation                     |

---

## Search by Keyword

### A-C

| Keyword               | Document              | Section                          |
|-----------------------|-----------------------|----------------------------------|
| API                   | API.md                | All sections                     |
| Architecture          | README.md             | Architecture                     |
| Build                 | TASKS.md              | Build Tasks                      |
| Clean                 | TASKS.md              | clean task                       |
| Configuration         | CONFIGURATION.md      | All sections                     |

### D-G

| Keyword               | Document              | Section                          |
|-----------------------|-----------------------|----------------------------------|
| Download              | TASKS.md              | Download Behavior                |
| Files                 | CONFIGURATION.md      | Configuration Files              |
| Ghostscript           | README.md             | All sections                     |
| Gradle                | README.md             | All sections                     |

### H-M

| Keyword               | Document              | Section                          |
|-----------------------|-----------------------|----------------------------------|
| Helper Functions      | API.md                | Helper Functions                 |
| Info                  | TASKS.md              | info task                        |
| Installation          | README.md             | Installation                     |
| Migration             | MIGRATION.md          | All sections                     |
| modules-untouched     | TASKS.md              | checkModulesUntouched task       |

### P-R

| Keyword               | Document              | Section                          |
|-----------------------|-----------------------|----------------------------------|
| Properties            | CONFIGURATION.md      | Build Properties                 |
| Release               | TASKS.md              | release task                     |
| releaseAll            | TASKS.md              | releaseAll task                  |

### S-Z

| Keyword               | Document              | Section                          |
|-----------------------|-----------------------|----------------------------------|
| Tasks                 | TASKS.md              | All sections                     |
| Troubleshooting       | README.md, MIGRATION.md | Troubleshooting sections       |
| Validation            | TASKS.md              | Verification Tasks               |
| Verify                | TASKS.md              | verify task                      |
| Versions              | TASKS.md              | listVersions task                |

---

## Document Summaries

### README.md

**Purpose**: Main documentation and quick start guide

**Contents**:
- Overview of the Gradle build system
- Quick start guide with basic commands
- Installation instructions
- Complete task reference
- Configuration overview
- Architecture and build process flow
- Troubleshooting common issues
- Migration guide summary

**Target Audience**: All users, especially new users

---

### TASKS.md

**Purpose**: Complete reference for all Gradle tasks

**Contents**:
- Build tasks (release, releaseAll, clean)
- Verification tasks (verify, validateProperties, checkModulesUntouched)
- Information tasks (info, listVersions, listReleases)
- Task dependencies and execution order
- Task examples and usage patterns
- Task options and properties
- Download behavior and caching

**Target Audience**: Developers and build engineers

---

### CONFIGURATION.md

**Purpose**: Configuration guide for build system

**Contents**:
- Configuration files overview
- Build properties reference
- Gradle properties reference
- Ghostscript version configuration
- Build path configuration
- Releases configuration
- Environment variables
- Configuration examples
- Best practices
- Troubleshooting

**Target Audience**: Build engineers and advanced users

---

### API.md

**Purpose**: API reference for build scripts

**Contents**:
- Build script API
- Helper functions reference
- Extension points
- Properties API
- Task API
- File operations API
- Exec API
- Logger API
- Exception handling
- API examples

**Target Audience**: Advanced users and contributors

---

### MIGRATION.md

**Purpose**: Guide for migrating from Ant to Gradle

**Contents**:
- Migration overview
- What changed from Ant to Gradle
- Command mapping (Ant to Gradle)
- File changes
- Configuration changes
- Task equivalents
- Troubleshooting migration issues
- Benefits of migration
- Next steps for developers, CI/CD, and contributors

**Target Audience**: Users migrating from Ant build system

---

## Version History

| Version       | Date       | Changes                                  |
|---------------|------------|------------------------------------------|
| 2025.7.31     | 2025-01-31 | Initial Gradle documentation             |
|               |            | - Created README.md                      |
|               |            | - Created TASKS.md                       |
|               |            | - Created CONFIGURATION.md               |
|               |            | - Created API.md                         |
|               |            | - Created MIGRATION.md                   |
|               |            | - Created INDEX.md                       |

---

## Contributing

To contribute to the documentation:

1. **Fork Repository**: Fork the module-ghostscript repository
2. **Edit Documentation**: Make changes to documentation files
3. **Follow Style**: Maintain consistent formatting and style
4. **Test Examples**: Verify all code examples work
5. **Submit PR**: Create pull request with changes

### Documentation Style Guide

- Use Markdown formatting
- Include code examples
- Use tables for structured data
- Add links to related sections
- Keep language clear and concise
- Include practical examples

---

## Support

For documentation issues or questions:

- **GitHub Issues**: https://github.com/bearsampp/module-ghostscript/issues
- **Bearsampp Issues**: https://github.com/bearsampp/bearsampp/issues
- **Documentation**: This directory (.gradle-docs/)

---

**Last Updated**: 2025-01-31  
**Version**: 2025.7.31  
**Total Documents**: 6
