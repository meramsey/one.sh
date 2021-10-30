#!/usr/bin/env bash
# flockit.sh -- Singleton command execution for Linux/BSD via flock
#
# Makes sure only one instance of the same process is running at once. This
# script does nothing if it was previously used to launch the same command
# and that instance is still running.
#
# /tmp/flockit-<md5sum of the arguments>.pid is used as the lock file. This file
# is removed if the process it refers to isn't actually running.
#
# Usage:   ./flockit.sh <command> <arguments>
# Example: ./flockit.sh wget --mirror http://mysite.com
#
# See http://patrickmylund.com/projects/one/ for more information.

# Switch out LFILE for something static to avoid running md5sum and cut, e.g.
# LFILE=/tmp/flockit-{pid}.pid
LFILE="/tmp/one-$(echo "$@" | md5sum | cut -d\  -f1).pid"

# /usr/bin/flock -w 0 /tmp/flockit-{pid}.pid <command>
flock -w 0 ${LFILE} $@
