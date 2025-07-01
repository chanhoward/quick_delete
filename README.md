-----

# High-Performance Bulk Delete

## Project Description

This is a high-performance batch file deletion tool designed for Windows systems. It employs multiple deletion strategies and memory optimization techniques to quickly process the deletion of large numbers of files and complex directory structures.

### Core Features

  - **Extreme Speed**: Utilizes multiple deletion algorithms to automatically select the optimal deletion strategy.
  - **Real-time Display**: Shows the names of files and directories being deleted in real-time.
  - **Memory Optimization**: Employs streaming processing techniques to prevent out-of-memory errors caused by large directory structures.
  - **Self-Protection**: Ensures the batch file itself is not accidentally deleted during execution.
  - **Fault Tolerance**: Features multi-level error handling to address file locking and permission issues.

-----

## System Requirements

  - Windows 7/8/10/11
  - Administrator privileges (recommended for handling system-protected files)
  - Sufficient system resources to handle large file operations

-----

## Installation and Usage

### Quick Start

1.  Place `quick_delete.bat` into the target folder you wish to clean.
2.  Right-click the file and select "Run as administrator."
3.  After confirming the deletion operation, the program will automatically begin cleaning.

### Usage Flow

```
1. Program Start → Display Target Path
2. Security Confirmation → Enter Y to Confirm Operation
3. File Deletion → Display Deletion Progress for Each File
4. Directory Cleanup → Remove Empty Directory Structures
5. Advanced Cleanup → Handle Stubborn Files
6. Completion Report → Display Execution Time and Results
```

-----

## Technical Architecture

### Multi-Stage Deletion Strategy

1.  **Standard Deletion**: Uses `DEL` and `RD` commands for regular file deletion.
2.  **Directory Cleanup**: Processes in reverse order, starting from the deepest directories.
3.  **Attribute Handling**: Removes file protection attributes and handles read-only files.
4.  **Forced Cleanup**: Advanced handling for system-locked files.

### Memory Optimization Techniques

  - **Streaming Processing**: Uses `FOR /R` to process files one by one, preventing memory accumulation.
  - **Variable Management**: Employs local variable scope to ensure timely memory release.
  - **Path Optimization**: Uses `PUSHD/POPD` to simplify path handling logic.

### Self-Protection Mechanism

  - **Filename Check**: Skips the batch file itself during the deletion process.
  - **Backup and Restore**: Creates temporary backups at critical stages to ensure execution integrity.
  - **Path Validation**: Prevents accidental deletion of critical system directories.

-----

## Safety Precautions

### Important Warnings

⚠️ **This tool permanently deletes files and cannot be undone.**
⚠️ **Please ensure you have backed up important data.**
⚠️ **It is recommended to validate in a test environment first.**

### Best Practices

  - Carefully confirm the target path before execution.
  - Close applications that might be locking files.
  - Regularly back up important data.
  - Test on non-system drives.

-----

## Performance Benchmarks

### Test Environment

  - Processor: Intel i7-10700K
  - Memory: 32GB DDR4
  - Storage: NVMe SSD

### Performance Metrics

  - **Small Files** (\<1KB, 10,000 files): Approximately 15 seconds
  - **Mixed Files** (1KB-10MB, 1,000 files): Approximately 8 seconds
  - **Large Files** (\>100MB, 100 files): Approximately 25 seconds
  - **Deep Directories** (10 layers, 1,000 folders): Approximately 12 seconds

-----

## Troubleshooting

### Common Issues

**Q: The program displays "Batch file not found."**
A: Ensure the batch file is located in the target directory and has execution permissions.

**Q: Some files cannot be deleted.**
A: Check if the files are being used by other programs or have special permission settings.

**Q: Memory usage continues to increase.**
A: Close other memory-intensive applications and re-run the program.

**Q: Deletion speed is slow.**
A: Check your antivirus software settings; temporarily disable real-time scanning.

### Error Codes

  - **Error 1**: Insufficient permissions; please run as administrator.
  - **Error 2**: Target path does not exist or is inaccessible.
  - **Error 5**: File is locked by another program.

-----

## Version Information

### Current Version: v2.1

  - Added real-time file display functionality.
  - Optimized memory usage efficiency.
  - Enhanced self-protection mechanism.
  - Improved error handling logic.

### Update History

  - **v2.0**: Refactored core deletion logic, improving execution speed.
  - **v1.5**: Added multi-stage deletion strategy.
  - **v1.0**: Implemented basic functionalities.

-----

## License Information

This project is licensed under the MIT License, allowing free use, modification, and distribution.

-----

## Technical Support

If you encounter technical issues or have feature suggestions, please:

  - Confirm you have read the troubleshooting section.
  - Gather error messages and system environment information.
  - Describe the specific usage scenario and expected outcome.

-----

## Contribution Guidelines

Contributions for code optimization are welcome, especially for:

  - Execution speed optimization
  - Memory usage efficiency improvement
  - Error handling mechanism enhancement
  - Cross-platform compatibility improvements
