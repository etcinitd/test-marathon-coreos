#!/bin/bash
set -e

echo "Installing for current user..."
export NCP_INFRASTRUCTURE_HOME=$(pwd)
echo "export NCP_INFRASTRUCTURE_HOME=$NCP_INFRASTRUCTURE_HOME" >> ~/.profile
echo "export NCP_INFRASTRUCTURE_HOME=$NCP_INFRASTRUCTURE_HOME" >> ~/.bash_profile
echo "Success! Make sure to close and reopen all terminals."
