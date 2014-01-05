# A Convenient Stereo Photo Generator
This project is a 3D photo generator written in Delphi.
 - Creates 3D pictures which are viewable through red-cyan/red-green glasses.
 - Simplified User Interface: only one-click required.
 - Photos taken by ordinary cameras can be used as inputs.
 
## Technical Details
 - Based on Anaglyph 3D. 
 - Two photos of certain objects taken from different angles are used as the input, filtered certain colors, and then overlaid over each other. 
 -  Uses multithreading to improve efficiency.

## Files
```
3dgenerator/
├── Unit1.pas   - The main program.
├── Unit2.pas   - The processing code.
├── UnitT.pas   - Multi-threading code.
├── Unit1.dfm   - The main window.
└── Unit2.dfm   - The processing window.

```
 
 
## Future Plans
 - Cross-platform compatibility
 - 3D video processing

## Author

**Tianlei Zheng**
 - <tianleizheng@126.com>
 
## My Other Projects
 - [Polynomial Calculator](https://github.com/ztl8702/polycalc)
 - [GoChat(P2P Chatting)](https://github.com/ztl8702/gochat)
