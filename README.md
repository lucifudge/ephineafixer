# EphineaFixer v1.5d (03/03/2022)

This is an unofficial Powershell GUI script to assist with troubleshooting Phantasy Star Online Ephinea launch issues on Windows 10. UI design based on the official Ephinea launcher.

**Usage**:
- Save anywhere. Right-click and "Run With Powershell"
- On launch, will automatically check for some game breaking settings (full list of fixes below), offers fix with Yes/No dialog
- Click _AUTO WHITELIST_ to exclude the EphineaPSO folder from Windows Defender, exclude psobb.exe from Windows DEP and prompt user to set psobb.exe to High Priority
- _MANUAL WHITELIST_ allows manual selection of your EphineaPSO install directory (performs all _AUTO WHITELIST_ changes)

![1](https://user-images.githubusercontent.com/13704242/156550759-fed661aa-d039-447c-a574-132b62ec04e4.png)

- "VIEW EXCLUSIONS" provides a list of your computer's Windows Defender and DEP exclusions, ephinea.dll presence, and button for copying full diagnostics to clipboard

![2](https://user-images.githubusercontent.com/13704242/156550760-8dfb10ac-6a14-4bfb-a32b-a523f1d72497.png)


---
**Game Launch fixes**:
- ephinea.dll presence detection (required file that is commonly removed by antivirus, false positive due to packer Ephinea uses)
- Windows Defender exclusion rule for default Ephinea PSO folder path (if present)
- Manual folder selection for non-standard install paths
- Repair missing registry keys (fixes portable installs or game installed by a different Windows user)
- x86 and x64 C++ redist presence checks and repair options
- psobb.exe settings for DPI, Windows compatibility mode, Run as Admin elevation

**Game Crash fixes**:
- Adds DEP exclusion for psobb.exe (fix for random game crash)
- Detect if screensaver is on (screensaver will cause Direct3D game crash)
- Detect UAC status to disables UAC dimming (an app triggering UAC dim crashes game)
- Detects windowed/fullscreen conflicts (windowed causes crash if alt tabbing)
- Detects advanced effects and classic fullscreen conflict (Ephinea launcher allows settings conflict)

**Compatibility/QOL fixes**:
- psobb.exe CPU priority check (fixes title screen audio stutter)
- Detects if IME is enabled for PSO and warn if Google/Microsoft IME not installed (prevents typing, only needed for East Asian languages)

**Clipboard Diagnostics**:
- Copies various system and game settings to clipboard for troubleshooting (in multiline code block wrapper), including:
  - ephinea.dll presence, OS version, Defender exclusions, DEP exclusions, UAC status, name of AV installed, screensaver status, PSOBB.exe CPU priority, classic/fullscreen/windowed status, advanced effect and IME status
  
  
