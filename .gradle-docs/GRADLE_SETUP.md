# Gradle Build Setup

## Overview

The Bearsampp Module Ghostscript has been converted to use Gradle build system **without** a Gradle wrapper. This means you need to have Gradle installed on your system.

## Prerequisites

### Required Software

1. **Java Development Kit (JDK) 8 or higher**
   - Download from: https://adoptium.net/ or https://www.oracle.com/java/technologies/downloads/
   - Set `JAVA_HOME` environment variable
   - Verify: `java -version`

2. **Gradle 8.5 or higher**
   - Download from: https://gradle.org/install/
   - Add to PATH
   - Verify: `gradle --version`

3. **7-Zip** (for .7z archive creation)
   - Download from: https://www.7-zip.org/
   - Set `7Z_HOME` environment variable (optional)
   - Verify: `7z` command works

### Installation Steps

#### Windows

**Install Java:**
```powershell
# Download and install JDK from https://adoptium.net/
# Set JAVA_HOME
setx JAVA_HOME "C:\Program Files\Eclipse Adoptium\jdk-11.0.x"
setx PATH "%PATH%;%JAVA_HOME%\bin"
```

**Install Gradle:**
```powershell
# Option 1: Using Chocolatey
choco install gradle

# Option 2: Manual installation
# 1. Download from https://gradle.org/releases/
# 2. Extract to C:\Gradle
# 3. Add to PATH
setx PATH "%PATH%;C:\Gradle\gradle-8.5\bin"
```

**Install 7-Zip:**
```powershell
# Option 1: Using Chocolatey
choco install 7zip

# Option 2: Download from https://www.7-zip.org/
# Set 7Z_HOME (optional)
setx 7Z_HOME "C:\Program Files\7-Zip"
```

#### Linux

**Install Java:**
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install openjdk-11-jdk

# Fedora/RHEL
sudo dnf install java-11-openjdk-devel

# Set JAVA_HOME
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk
echo 'export JAVA_HOME=/usr/lib/jvm/java-11-openjdk' >> ~/.bashrc
```

**Install Gradle:**
```bash
# Using SDKMAN (recommended)
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install gradle 8.5

# Or download manually from https://gradle.org/releases/
```

**Install 7-Zip:**
```bash
# Ubuntu/Debian
sudo apt install p7zip-full

# Fedora/RHEL
sudo dnf install p7zip p7zip-plugins
```

#### macOS

**Install Java:**
```bash
# Using Homebrew
brew install openjdk@11

# Set JAVA_HOME
export JAVA_HOME=$(/usr/libexec/java_home -v 11)
echo 'export JAVA_HOME=$(/usr/libexec/java_home -v 11)' >> ~/.zshrc
```

**Install Gradle:**
```bash
# Using Homebrew
brew install gradle

# Or using SDKMAN
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install gradle 8.5
```

**Install 7-Zip:**
```bash
# Using Homebrew
brew install p7zip
```

## Verification

After installation, verify everything is set up correctly:

```bash
# Check Java
java -version
echo %JAVA_HOME%  # Windows
echo $JAVA_HOME   # Linux/Mac

# Check Gradle
gradle --version

# Check 7-Zip
7z  # Should show 7-Zip help

# Verify Gradle build
cd E:/Bearsampp-development/module-ghostscript
gradle verify
```

Expected output from `gradle verify`:
```
Environment Check Results:
------------------------------------------------------------
  [PASS]     Java 8+
  [PASS]     build.properties
  [PASS]     releases.properties
  [PASS]     dev directory
  [PASS]     bin directory
  [PASS]     bin/archived directory
  [PASS]     7-Zip
------------------------------------------------------------

[SUCCESS] All checks passed! Build environment is ready.
```

## Why No Gradle Wrapper?

This project does **not** use a Gradle wrapper for the following reasons:

1. **Consistency with other Bearsampp modules** - All modules use system Gradle
2. **Simpler project structure** - No wrapper files to maintain
3. **Explicit version control** - Gradle version is documented in prerequisites
4. **Easier updates** - Update Gradle system-wide, not per-project

## Quick Start

Once everything is installed:

```bash
# Navigate to project
cd E:/Bearsampp-development/module-ghostscript

# Verify environment
gradle verify

# List available versions
gradle listVersions

# Build a specific version
gradle release -PbundleVersion=10.05.1

# Or use interactive mode
gradle release
```

## Troubleshooting

### "gradle: command not found"

**Problem:** Gradle is not in your PATH

**Solution:**
```bash
# Windows
setx PATH "%PATH%;C:\Gradle\gradle-8.5\bin"

# Linux/Mac
export PATH=$PATH:/opt/gradle/gradle-8.5/bin
echo 'export PATH=$PATH:/opt/gradle/gradle-8.5/bin' >> ~/.bashrc
```

### "JAVA_HOME is not set"

**Problem:** Java environment variable not configured

**Solution:**
```bash
# Windows
setx JAVA_HOME "C:\Program Files\Eclipse Adoptium\jdk-11.0.x"

# Linux/Mac
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk
echo 'export JAVA_HOME=/usr/lib/jvm/java-11-openjdk' >> ~/.bashrc
```

### "7-Zip not found"

**Problem:** 7-Zip is not installed or not in PATH

**Solution:**
1. Install 7-Zip from https://www.7-zip.org/
2. Set `7Z_HOME` environment variable:
   ```bash
   # Windows
   setx 7Z_HOME "C:\Program Files\7-Zip"
   ```
3. Or add 7-Zip to PATH

### Gradle version too old

**Problem:** Gradle version is below 8.5

**Solution:**
```bash
# Check current version
gradle --version

# Update Gradle
# Windows (Chocolatey)
choco upgrade gradle

# Linux/Mac (SDKMAN)
sdk install gradle 8.5
sdk use gradle 8.5
```

## Environment Variables Summary

| Variable | Purpose | Example |
|----------|---------|---------|
| `JAVA_HOME` | Java installation path | `C:\Program Files\Eclipse Adoptium\jdk-11.0.x` |
| `7Z_HOME` | 7-Zip installation path (optional) | `C:\Program Files\7-Zip` |
| `BEARSAMPP_BUILD_PATH` | Custom build output path (optional) | `C:\Bearsampp-build` |
| `PATH` | Include Gradle and Java binaries | `%PATH%;C:\Gradle\gradle-8.5\bin` |

## Next Steps

After setup is complete:

1. Read [GRADLE_BUILD.md](GRADLE_BUILD.md) for detailed build documentation
2. Read [GRADLE_README.md](GRADLE_README.md) for quick reference
3. Run `gradle tasks` to see all available tasks
4. Run `gradle info` to see build configuration
5. Try building a version: `gradle release -PbundleVersion=10.05.1`

## Support

If you encounter issues:

1. Run `gradle verify` to check your environment
2. Check this setup guide for installation instructions
3. Verify all prerequisites are installed correctly
4. Check environment variables are set correctly

## Additional Resources

- **Gradle Installation Guide:** https://gradle.org/install/
- **Java Downloads:** https://adoptium.net/
- **7-Zip Downloads:** https://www.7-zip.org/
- **Gradle Documentation:** https://docs.gradle.org/

---

**Setup complete!** You're ready to build Bearsampp Module Ghostscript with Gradle. 🎉
