# External Libraries
All external libraries will be placed here. The build system will automatically download any required libraries and place them here.

The expected directory structure is as follows:
- Include (This directory will be searched for headers, create it if required)
- $PlatformName$ (e.g. Win32, Win64, etc)
    - $CompilerName$ (e.g. MinGW-w64, MSVC, etc)
        - $BuildType$ (e.g. Debug, Release, etc. NOTE: This will not exist for MSVC)
