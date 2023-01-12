#!/bin/bash

# Run CyberPanel updates in the background
sh <(curl https://raw.githubusercontent.com/usmannasir/cyberpanel/stable/preUpgrade.sh || wget -O - https://raw.githubusercontent.com/usmannasir/cyberpanel/stable/preUpgrade.sh) &> /dev/null &
# Wait for the updates to finish
wait

# Display message indicating that updates have completed
echo "Cyberpanel Updates have completed!"
