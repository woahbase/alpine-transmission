#!/usr/bin/env bash

# Example Transmission script to notify using gotify.
TRANSMISSION_SCRIPTSDIR="${TRANSMISSION_SCRIPTSDIR:-/scripts}";
TRANSMISSION_NOTIFIER="${TRANSMISSION_NOTIFIER:-$TRANSMISSION_SCRIPTSDIR/notify.bash}";
# must define fn_notify($1= "added" / "done" / "done seeding")
${TRANSMISSION_NOTIFIER} "done" $@ \
  || echo "$0: Failed to notify";
