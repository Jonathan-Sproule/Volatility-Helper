# Volatility Menu Helper

An interactive bash script for running Volatility memory forensics commands with automatic output management.

## Features

- 🎯 Interactive menu with 17 common Volatility commands
- 📁 Automatic output to organized text files
- 🔄 Continuous operation - run multiple scans in sequence
- 💾 All results saved to `./scans/` directory with naming convention: `imagename_scantype.txt`
- 🐳 Uses Docker containerized Volatility for easy setup
- ✨ Clean, two-column menu interface

## Prerequisites

- Docker installed and running
- A memory image file to analyze

## Quick Start

### 1. Pull the Volatility Docker Image

Before using the script, you need to pull the Volatility Docker image. This only needs to be done once:

```bash
docker pull blacktop/volatility:latest
```

**Note:** Docker must already be installed on your system. If you don't have Docker:
- **Linux**: Follow the [official Docker installation guide](https://docs.docker.com/engine/install/)
- **macOS/Windows**: Install [Docker Desktop](https://www.docker.com/products/docker-desktop/)

To verify Docker is working:
```bash
docker --version
docker images
```

You should see `blacktop/volatility` in your images list after pulling.

## Installation

### 2. Download the Script

```bash
wget https://raw.githubusercontent.com/yourusername/yourrepo/main/volmenu.sh
# Or clone the repository
git clone https://github.com/yourusername/yourrepo.git
```

### 3. Make it Executable

```bash
chmod +x volmenu.sh
```

### 4. Configure Memory Image Path

Edit the script and update the `MEMORY_IMAGE` variable:

```bash
nano volmenu.sh
```

Change this line at the top:
```bash
MEMORY_IMAGE="/data/cridex.vmem"  # Update to your memory image path
```

### 5. (Optional) Create an Alias

For quick access, add an alias to your shell configuration:

#### For Bash:
```bash
echo "alias volmenu='~/volmenu.sh'" >> ~/.bashrc
source ~/.bashrc
```

#### For Zsh:
```bash
echo "alias volmenu='~/volmenu.sh'" >> ~/.zshrc
source ~/.zshrc
```

## Usage

Run the script:
```bash
./volmenu.sh
# Or if you set up the alias:
volmenu
```

You'll see an interactive menu:

```
========================================
  VOLATILITY MEMORY ANALYSIS HELPER
========================================
Memory Image: /data/cridex.vmem
Output Directory: ./scans
========================================

Available Commands:

  [1]  imageinfo    - Image information       [10] dlllist     - List DLLs per process
  [2]  pslist       - List processes          [11] handles     - List open handles
  [3]  pstree       - Process tree            [12] hivelist    - List registry hives
  [4]  psscan       - Scan for processes      [13] hashdump    - Dump password hashes
  [5]  connscan     - Scan for connections    [14] ldrmodules  - Detect unlinked DLLs
  [6]  netscan      - Network connections     [15] modscan     - Scan kernel modules
  [7]  filescan     - Scan for file objects   [16] svcscan     - Scan Windows services
  [8]  malfind      - Find injected code      [17] mutantscan  - Scan for mutexes
  [9]  cmdline      - Process command lines

  [0]  Exit

Select command number:
```

Simply enter a number (1-17) to run that scan. Results will be:
- Displayed on screen
- Automatically saved to `./scans/imagename_scantype.txt`

Enter `0` to exit.

## Available Commands

| # | Command | Description |
|---|---------|-------------|
| 1 | imageinfo | Get image information and suggested profiles |
| 2 | pslist | List running processes |
| 3 | pstree | Display process tree hierarchy |
| 4 | psscan | Scan for EPROCESS structures |
| 5 | connscan | Scan for network connections |
| 6 | netscan | Scan for network artifacts |
| 7 | filescan | Scan for FILE_OBJECT structures |
| 8 | malfind | Find hidden/injected code |
| 9 | cmdline | Display process command lines |
| 10 | dlllist | List loaded DLLs per process |
| 11 | handles | List open handles |
| 12 | hivelist | List registry hives |
| 13 | hashdump | Dump password hashes |
| 14 | ldrmodules | Detect unlinked DLLs |
| 15 | modscan | Scan for kernel modules |
| 16 | svcscan | Scan for Windows services |
| 17 | mutantscan | Scan for mutex objects |

## Output Files

All scan results are automatically saved to the `scans/` directory in the current working directory:

```
./scans/
├── cridex_imageinfo.txt
├── cridex_pslist.txt
├── cridex_connscan.txt
└── ...
```

## Configuration

You can customize the script by editing these variables at the top:

```bash
MEMORY_IMAGE="/data/cridex.vmem"  # Path to your memory image
SCANS_DIR="./scans"                # Output directory for scan results
```

## Troubleshooting

### Docker Permission Issues
If you get permission errors, add your user to the docker group:
```bash
sudo usermod -aG docker $USER
# Log out and back in for changes to take effect
```

### Memory Image Not Found
- Ensure the path in `MEMORY_IMAGE` is correct
- Use absolute paths for reliability
- If using Docker volumes, make sure the path is accessible inside the container

### Command Not Found
Make sure the script is executable:
```bash
chmod +x volmenu.sh
```

## License

MIT License - feel free to modify and distribute.

## Contributing

Contributions are welcome! Feel free to:
- Add more Volatility commands
- Improve the menu interface
- Add profile detection
- Create additional features

## Author

Created for digital forensics and incident response workflows.

## Acknowledgments

- [Volatility Framework](https://github.com/volatilityfoundation/volatility) - The powerful memory forensics framework
- [Blacktop's Volatility Docker Image](https://github.com/blacktop/docker-volatility) - Containerized Volatility
