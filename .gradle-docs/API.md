# API Reference

Complete API reference for the Bearsampp Module Ghostscript Gradle build system.

---

## Table of Contents

- [Build Script API](#build-script-api)
- [Helper Functions](#helper-functions)
- [Extension Points](#extension-points)
- [Properties API](#properties-api)
- [Task API](#task-api)

---

## Build Script API

### Project Configuration

#### `group`

**Type:** `String`  
**Default:** `com.bearsampp.modules`  
**Description:** Maven group ID for the project

```groovy
group = 'com.bearsampp.modules'
```

---

#### `version`

**Type:** `String`  
**Default:** Value from `build.properties`  
**Description:** Project version

```groovy
version = buildProps.getProperty('bundle.release', '1.0.0')
```

---

#### `description`

**Type:** `String`  
**Default:** Generated from bundle name  
**Description:** Project description

```groovy
description = "Bearsampp Module - ${buildProps.getProperty('bundle.name', 'ghostscript')}"
```

---

### Extension Properties

#### `ext.projectBasedir`

**Type:** `String`  
**Description:** Absolute path to project directory

```groovy
ext.projectBasedir = projectDir.absolutePath
```

---

#### `ext.rootDir`

**Type:** `String`  
**Description:** Absolute path to parent directory

```groovy
ext.rootDir = projectDir.parent
```

---

#### `ext.devPath`

**Type:** `String`  
**Description:** Absolute path to dev directory

```groovy
ext.devPath = file("${rootDir}/dev").absolutePath
```

---

#### `ext.bundleName`

**Type:** `String`  
**Default:** `ghostscript`  
**Description:** Name of the bundle from build.properties

```groovy
ext.bundleName = buildProps.getProperty('bundle.name', 'ghostscript')
```

---

#### `ext.bundleRelease`

**Type:** `String`  
**Default:** `1.0.0`  
**Description:** Release version from build.properties

```groovy
ext.bundleRelease = buildProps.getProperty('bundle.release', '1.0.0')
```

---

#### `ext.bundleType`

**Type:** `String`  
**Default:** `tools`  
**Description:** Bundle type from build.properties

```groovy
ext.bundleType = buildProps.getProperty('bundle.type', 'tools')
```

---

#### `ext.bundleFormat`

**Type:** `String`  
**Default:** `7z`  
**Description:** Archive format from build.properties

```groovy
ext.bundleFormat = buildProps.getProperty('bundle.format', '7z')
```

---

#### `ext.buildBasePath`

**Type:** `String`  
**Description:** Base path for build output (configurable via build.properties, environment variable, or default)

```groovy
def buildPathFromProps = buildProps.getProperty('build.path', '').trim()
def buildPathFromEnv = System.getenv('BEARSAMPP_BUILD_PATH') ?: ''
def defaultBuildPath = "${rootDir}/bearsampp-build"

ext.buildBasePath = buildPathFromProps ?: (buildPathFromEnv ?: defaultBuildPath)
```

---

#### `ext.buildTmpPath`

**Type:** `String`  
**Description:** Absolute path to temporary build directory

```groovy
ext.buildTmpPath = file("${buildBasePath}/tmp").absolutePath
```

---

#### `ext.bundleTmpBuildPath`

**Type:** `String`  
**Description:** Absolute path to bundle build directory

```groovy
ext.bundleTmpBuildPath = file("${buildTmpPath}/bundles_build/${bundleType}/${bundleName}").absolutePath
```

---

#### `ext.bundleTmpPrepPath`

**Type:** `String`  
**Description:** Absolute path to bundle preparation directory

```groovy
ext.bundleTmpPrepPath = file("${buildTmpPath}/bundles_prep/${bundleType}/${bundleName}").absolutePath
```

---

#### `ext.bundleTmpDownloadPath`

**Type:** `String`  
**Description:** Absolute path to download cache directory

```groovy
ext.bundleTmpDownloadPath = file("${buildTmpPath}/downloads/${bundleName}").absolutePath
```

---

#### `ext.bundleTmpExtractPath`

**Type:** `String`  
**Description:** Absolute path to extraction directory

```groovy
ext.bundleTmpExtractPath = file("${buildTmpPath}/extract/${bundleName}").absolutePath
```

---

## Helper Functions

### `fetchModulesUntouchedProperties()`

**Description:** Fetch ghostscript.properties from modules-untouched repository

**Parameters:** None

**Returns:** `Properties` - Properties object or null if fetch fails

**Example:**

```groovy
def props = fetchModulesUntouchedProperties()
if (props) {
    def url = props.getProperty('10.05.1')
}
```

**Process:**
1. Construct URL to modules-untouched properties file
2. Download properties file
3. Parse and return Properties object
4. Return null on failure

---

### `getModuleUntouched(String name, String version)`

**Description:** Get Ghostscript module from modules-untouched repository (local or remote)

**Parameters:**

| Parameter    | Type     | Description                          |
|--------------|----------|--------------------------------------|
| `name`       | String   | Module name (ghostscript)            |
| `version`    | String   | Version to retrieve                  |

**Returns:** `File` - Directory containing Ghostscript files or null

**Example:**

```groovy
def ghostscriptDir = getModuleUntouched('ghostscript', '10.05.1')
if (ghostscriptDir) {
    println "Found at: ${ghostscriptDir}"
}
```

**Process:**
1. Check local modules-untouched repository
2. If not found, check remote properties file
3. Download and extract if found remotely
4. Return directory or null

---

### `getModuleUntouchedRemoteUrl(String name, String version)`

**Description:** Get download URL from modules-untouched remote properties file

**Parameters:**

| Parameter    | Type     | Description                          |
|--------------|----------|--------------------------------------|
| `name`       | String   | Module name (ghostscript)            |
| `version`    | String   | Version to retrieve                  |

**Returns:** `String` - Download URL or null

**Example:**

```groovy
def url = getModuleUntouchedRemoteUrl('ghostscript', '10.05.1')
if (url) {
    println "Download URL: ${url}"
}
```

---

### `downloadAndExtractFromUrl(String downloadUrl, String version, String name)`

**Description:** Download and extract Ghostscript from URL

**Parameters:**

| Parameter      | Type     | Description                          |
|----------------|----------|--------------------------------------|
| `downloadUrl`  | String   | URL to download from                 |
| `version`      | String   | Version being downloaded             |
| `name`         | String   | Module name                          |

**Returns:** `File` - Directory containing extracted files

**Example:**

```groovy
def ghostscriptDir = downloadAndExtractFromUrl(
    'https://example.com/gs10.05.1.7z',
    '10.05.1',
    'ghostscript'
)
```

**Process:**
1. Download archive from URL
2. Extract to temporary directory
3. Find Ghostscript directory in extracted files
4. Return directory

---

### `downloadAndExtractGhostscript(String version, File destDir)`

**Description:** Download and extract Ghostscript binaries (with fallback logic)

**Parameters:**

| Parameter    | Type     | Description                          |
|--------------|----------|--------------------------------------|
| `version`    | String   | Ghostscript version                  |
| `destDir`    | File     | Destination directory                |

**Returns:** `File` - Directory containing Ghostscript files

**Example:**

```groovy
def ghostscriptDir = downloadAndExtractGhostscript('10.05.1', file(bundleTmpExtractPath))
```

**Process:**
1. Try modules-untouched repository (local)
2. Try modules-untouched repository (remote)
3. Try releases.properties
4. Download and extract
5. Return directory

---

### `findGhostscriptDirectory(File extractPath)`

**Description:** Find Ghostscript directory in extracted files

**Parameters:**

| Parameter      | Type     | Description                          |
|----------------|----------|--------------------------------------|
| `extractPath`  | File     | Directory to search                  |

**Returns:** `File` - Ghostscript directory or null

**Example:**

```groovy
def ghostscriptDir = findGhostscriptDirectory(file("${bundleTmpExtractPath}/10.05.1"))
```

**Process:**
1. Check if extractPath itself contains gswin64c.exe or gswin32c.exe
2. Search top-level directories
3. Search one level deep
4. Return directory or null

---

### `find7ZipExecutable()`

**Description:** Find 7-Zip executable on system

**Parameters:** None

**Returns:** `String` - Path to 7z.exe or null

**Example:**

```groovy
def sevenZipPath = find7ZipExecutable()
if (sevenZipPath) {
    println "7-Zip found at: ${sevenZipPath}"
}
```

**Process:**
1. Check 7Z_HOME environment variable
2. Check common installation paths
3. Check PATH environment variable
4. Return path or null

---

### `generateHashFiles(File file)`

**Description:** Generate hash files (MD5, SHA1, SHA256, SHA512) for archive

**Parameters:**

| Parameter    | Type     | Description                          |
|--------------|----------|--------------------------------------|
| `file`       | File     | File to generate hashes for          |

**Returns:** `void`

**Example:**

```groovy
generateHashFiles(file('bearsampp-ghostscript-10.05.1-2025.7.31.7z'))
```

**Process:**
1. Calculate MD5 hash
2. Calculate SHA1 hash
3. Calculate SHA256 hash
4. Calculate SHA512 hash
5. Write each hash to separate file

---

### `calculateHash(File file, String algorithm)`

**Description:** Calculate hash for file using specified algorithm

**Parameters:**

| Parameter    | Type     | Description                          |
|--------------|----------|--------------------------------------|
| `file`       | File     | File to hash                         |
| `algorithm`  | String   | Hash algorithm (MD5, SHA-1, SHA-256, SHA-512) |

**Returns:** `String` - Hex-encoded hash

**Example:**

```groovy
def md5 = calculateHash(file('archive.7z'), 'MD5')
def sha256 = calculateHash(file('archive.7z'), 'SHA-256')
```

---

### `getAvailableVersions()`

**Description:** Get list of available Ghostscript versions from bin/ and bin/archived/

**Parameters:** None

**Returns:** `List<String>` - List of version strings

**Example:**

```groovy
def versions = getAvailableVersions()
versions.each { version ->
    println "Version: ${version}"
}
```

**Process:**
1. Scan bin/ directory
2. Scan bin/archived/ directory
3. Remove duplicates
4. Sort versions
5. Return list

---

## Extension Points

### Custom Task Registration

Register custom tasks using Gradle's task API:

```groovy
tasks.register('customTask') {
    group = 'custom'
    description = 'Custom task description'
    
    doLast {
        // Task implementation
    }
}
```

---

### Custom Validation

Add custom validation tasks:

```groovy
tasks.register('customValidation') {
    group = 'verification'
    description = 'Custom validation'
    
    doLast {
        // Validation logic
    }
}
```

---

### Custom Download Sources

Override download behavior by modifying releases.properties or implementing custom download logic:

```groovy
def customDownloadGhostscript(String version) {
    // Custom download implementation
}
```

---

## Properties API

### Project Properties

Access via `project.findProperty()`:

```groovy
def bundleVersion = project.findProperty('bundleVersion')
```

---

### Build Properties

Access via loaded Properties object:

```groovy
def buildProps = new Properties()
file('build.properties').withInputStream { buildProps.load(it) }

def bundleName = buildProps.getProperty('bundle.name')
def bundleRelease = buildProps.getProperty('bundle.release')
```

---

### System Properties

Access via `System.getProperty()`:

```groovy
def javaHome = System.getProperty('java.home')
def javaVersion = System.getProperty('java.version')
```

---

### Environment Variables

Access via `System.getenv()`:

```groovy
def buildPath = System.getenv('BEARSAMPP_BUILD_PATH')
def sevenZipHome = System.getenv('7Z_HOME')
```

---

## Task API

### Task Registration

```groovy
tasks.register('taskName') {
    group = 'groupName'
    description = 'Task description'
    
    doFirst {
        // Executed first
    }
    
    doLast {
        // Executed last
    }
}
```

---

### Task Dependencies

```groovy
tasks.register('taskB') {
    dependsOn 'taskA'
    
    doLast {
        // Executed after taskA
    }
}
```

---

### Task Configuration

```groovy
tasks.named('existingTask') {
    // Configure existing task
    doLast {
        // Add additional action
    }
}
```

---

## File API

### File Operations

```groovy
// Create file object
def file = file('path/to/file')

// Check existence
if (file.exists()) { }

// Create directory
file.mkdirs()

// Delete file/directory
delete file

// Copy files
copy {
    from 'source'
    into 'destination'
    include '*.exe'
    exclude 'doc/**'
}
```

---

### Archive Operations

```groovy
// Extract ZIP
copy {
    from zipTree('archive.zip')
    into 'destination'
}

// Create 7z archive
def command = [
    sevenZipExe,
    'a',
    '-t7z',
    archiveFile.absolutePath,
    '.'
]
def process = new ProcessBuilder(command)
    .directory(sourceDir)
    .redirectErrorStream(true)
    .start()
```

---

## Exec API

### Execute Command

```groovy
def process = new ProcessBuilder(['command', 'arg1', 'arg2'])
    .directory(workingDir)
    .redirectErrorStream(true)
    .start()

process.inputStream.eachLine { line ->
    println line
}

def exitCode = process.waitFor()
```

---

### PowerShell Execution

```groovy
def command = ['powershell', '-Command', 'Get-Date']
def process = new ProcessBuilder(command)
    .redirectErrorStream(true)
    .start()

def output = process.inputStream.text
```

---

## Logger API

### Logging Levels

```groovy
logger.error('Error message')
logger.warn('Warning message')
logger.lifecycle('Lifecycle message')
logger.quiet('Quiet message')
logger.info('Info message')
logger.debug('Debug message')
```

---

## Exception API

### Throw Exception

```groovy
throw new GradleException('Error message')
```

---

## Examples

### Example 1: Custom Download Task

```groovy
tasks.register('downloadGhostscript') {
    group = 'download'
    description = 'Download Ghostscript version'
    
    doLast {
        def version = project.findProperty('gsVersion')
        if (!version) {
            throw new GradleException('gsVersion property required')
        }
        
        def ghostscriptDir = downloadAndExtractGhostscript(
            version,
            file(bundleTmpExtractPath)
        )
        println "Downloaded to: ${ghostscriptDir}"
    }
}
```

---

### Example 2: Custom Validation Task

```groovy
tasks.register('validateGhostscript') {
    group = 'verification'
    description = 'Validate Ghostscript installation'
    
    doLast {
        def versions = getAvailableVersions()
        
        versions.each { version ->
            def binDir = file("bin/ghostscript${version}")
            if (!binDir.exists()) {
                binDir = file("bin/archived/ghostscript${version}")
            }
            
            def gsExe64 = file("${binDir}/bin/gswin64c.exe")
            def gsExe32 = file("${binDir}/bin/gswin32c.exe")
            
            if (!gsExe64.exists() && !gsExe32.exists()) {
                throw new GradleException("No Ghostscript executable found for version ${version}")
            }
            
            println "[PASS] ${version}"
        }
        
        println '[SUCCESS] All versions validated'
    }
}
```

---

### Example 3: Custom Info Task

```groovy
tasks.register('ghostscriptInfo') {
    group = 'help'
    description = 'Display Ghostscript version information'
    
    doLast {
        def versions = getAvailableVersions()
        
        println 'Ghostscript Versions:'
        println '-'.multiply(60)
        
        versions.each { version ->
            def binDir = file("bin/ghostscript${version}")
            def location = 'bin'
            
            if (!binDir.exists()) {
                binDir = file("bin/archived/ghostscript${version}")
                location = 'bin/archived'
            }
            
            def gsExe64 = file("${binDir}/bin/gswin64c.exe")
            def gsExe32 = file("${binDir}/bin/gswin32c.exe")
            
            def arch = gsExe64.exists() ? '64-bit' : '32-bit'
            def size = (gsExe64.exists() ? gsExe64.length() : gsExe32.length()) / 1024 / 1024
            
            println "  ${version.padRight(15)} [${location}] ${arch} ${String.format('%.2f', size)} MB"
        }
        
        println '-'.multiply(60)
        println "Total versions: ${versions.size()}"
    }
}
```

---

**Last Updated**: 2025-01-31  
**Version**: 2025.7.31
