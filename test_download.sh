#!/bin/bash
echo "Testing download of system-prompt-orchestrator..."
wget -S --spider https://raw.githubusercontent.com/PARS-DOE/roopars/main/config/.roo/system-prompt-orchestrator 2>&1 | grep "HTTP/"
echo "Done testing."