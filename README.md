# BES

An attempt to code a NES emulator in BeefLang. Making each component of the NES independently.

## Components

### 1. CPU (Central Processing Unit)
![status](https://img.shields.io/badge/status-finished-brightgreen)
6502-based CPU with no decimal mode (still programmed in to pass tests but disabled)

### 2. Memory Mapper
![status](https://img.shields.io/badge/status-WIP-yellow)
Memory mapper to handle memory mapping for different cartridges. Just implemented a basic memory mapper interface and created a 64kb memory array that implements it.

### 3. PPU (Picture Processing Unit)
![status](https://img.shields.io/badge/status-WIP-yellow)
NES' PPU, responsible for rendering graphics. Just started.

### 4. APU (Audio Processing Unit)
![status](https://img.shields.io/badge/status-TODO-red)
NES' APU, responsible for generating audio.

### 5. Input Handling
![status](https://img.shields.io/badge/status-TODO-red)
I guess this goes with the memory mapper. Will work on it

### 6. Cartridge Handling
![status](https://img.shields.io/badge/status-TODO-red)
Cartridge handling to load NES ROMs. Also think it's linked to the memory mapper.

### 7. Debugging Tools
![status](https://img.shields.io/badge/status-TODO-red)
Debugging tools to help with development.

## Progress Overview

| Component           | Status                 | Notes                                                   |
|---------------------|------------------------|---------------------------------------------------------|
| CPU                 | Finished               | Independently tested with functional tests              |
| Memory Mapper       | Work in Progress (WIP) | Basic memory mapping implemented                        |
| PPU                 | Work In Progress (WIP) | Just started                                            |
| APU                 | TODO                   |                                                         |
| Input Handling      | TODO                   |                                                         |
| Cartridge Handling  | TODO                   |                                                         |
| Debugging Tools     | TODO                   |                                                         |


## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.
