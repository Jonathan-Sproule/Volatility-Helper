#!/bin/bash

# ============================================
# CONFIGURATION
# ============================================
MEMORY_IMAGE="/data/cridex.vmem"
SCANS_DIR="./scans"

# ============================================
# SETUP
# ============================================
# Create scans directory if it doesn't exist
mkdir -p "$SCANS_DIR"

# Extract image name without path and extension
IMAGE_NAME=$(basename "$MEMORY_IMAGE" | sed 's/\.[^.]*$//')

# Docker command base
DOCKER_CMD="docker run -it --rm -v $(pwd):/data blacktop/volatility:latest vol.py"

# ============================================
# FUNCTIONS
# ============================================

print_header() {
    clear
    echo "========================================"
    echo "  VOLATILITY MEMORY ANALYSIS HELPER"
    echo "========================================"
    echo "Memory Image: $MEMORY_IMAGE"
    echo "Output Directory: $SCANS_DIR"
    echo "========================================"
    echo ""
}

print_menu() {
    echo "Available Commands:"
    echo ""
    printf "  %-40s %-40s\n" "[1]  imageinfo    - Image information" "[10] dlllist     - List DLLs per process"
    printf "  %-40s %-40s\n" "[2]  pslist       - List processes" "[11] handles     - List open handles"
    printf "  %-40s %-40s\n" "[3]  pstree       - Process tree" "[12] hivelist    - List registry hives"
    printf "  %-40s %-40s\n" "[4]  psscan       - Scan for processes" "[13] hashdump    - Dump password hashes"
    printf "  %-40s %-40s\n" "[5]  connscan     - Scan for connections" "[14] ldrmodules  - Detect unlinked DLLs"
    printf "  %-40s %-40s\n" "[6]  netscan      - Network connections" "[15] modscan     - Scan kernel modules"
    printf "  %-40s %-40s\n" "[7]  filescan     - Scan for file objects" "[16] svcscan     - Scan Windows services"
    printf "  %-40s %-40s\n" "[8]  malfind      - Find injected code" "[17] mutantscan  - Scan for mutexes"
    printf "  %-40s %-40s\n" "[9]  cmdline      - Process command lines" ""
    echo ""
    echo "  [0]  Exit"
    echo ""
}

run_command() {
    local cmd_num=$1
    local cmd_name=""
    local output_file=""
    
    case $cmd_num in
        1)
            cmd_name="imageinfo"
            ;;
        2)
            cmd_name="pslist"
            ;;
        3)
            cmd_name="pstree"
            ;;
        4)
            cmd_name="psscan"
            ;;
        5)
            cmd_name="connscan"
            ;;
        6)
            cmd_name="netscan"
            ;;
        7)
            cmd_name="filescan"
            ;;
        8)
            cmd_name="malfind"
            ;;
        9)
            cmd_name="cmdline"
            ;;
        10)
            cmd_name="dlllist"
            ;;
        11)
            cmd_name="handles"
            ;;
        12)
            cmd_name="hivelist"
            ;;
        13)
            cmd_name="hashdump"
            ;;
        14)
            cmd_name="ldrmodules"
            ;;
        15)
            cmd_name="modscan"
            ;;
        16)
            cmd_name="svcscan"
            ;;
        17)
            cmd_name="mutantscan"
            ;;
        0)
            echo ""
            echo "Exiting... Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid selection. Please try again."
            return 1
            ;;
    esac
    
    # Set output file name
    output_file="$SCANS_DIR/${IMAGE_NAME}_${cmd_name}.txt"
    
    echo ""
    echo "Running: $cmd_name"
    echo "Output will be saved to: $output_file"
    echo "----------------------------------------"
    
    # Run the command and save to file
    $DOCKER_CMD -f "$MEMORY_IMAGE" $cmd_name | tee "$output_file"
    
    echo "----------------------------------------"
    echo "✓ Scan complete! Results saved to: $output_file"
    echo ""
}

# ============================================
# MAIN LOOP
# ============================================

while true; do
    print_header
    print_menu
    
    read -p "Select command number: " selection
    
    run_command "$selection"
    
    if [ $? -eq 0 ]; then
        echo ""
        read -p "Press Enter to continue..."
    fi
done
