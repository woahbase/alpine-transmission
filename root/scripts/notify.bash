#!/usr/bin/env bash

# Example Transmission script to notify using gotify.
# Replace with your own.

############################################
# These are inherited from Transmission.
# Reference: https://github.com/transmission/transmission/blob/main/docs/Scripts.md
# Do not declare these. Just use as needed.
#
# TR_APP_VERSION
# TR_TIME_LOCALTIME
# TR_TORRENT_BYTES_DOWNLOADED
# TR_TORRENT_DIR
# TR_TORRENT_HASH
# TR_TORRENT_ID
# TR_TORRENT_LABELS
# TR_TORRENT_NAME
# TR_TORRENT_PRIORITY
# TR_TORRENT_TRACKERS
#
############################################

fn_notify () { # usage: $1 = "added" / "seeding" / "done seeding"
  local status="$1";

  echo "Id       : $TR_TORRENT_ID";
  echo "Name     : $TR_TORRENT_NAME";
  echo "Hash     : $TR_TORRENT_HASH";
  echo "Size     : $TR_TORRENT_BYTES_DOWNLOADED (bytes)";
  echo "Priority : ${TR_TORRENT_PRIORITY:-0}";
  echo "Labels   : ${TR_TORRENT_LABELS:-none}";
  echo "Location : $TR_TORRENT_DIR";
  echo "Status   : $status";
  echo "At       : $TR_TIME_LOCALTIME";

  if [ -n "${GOTIFY_URL}" ] && [ -n "${GOTIFY_TOKEN}" ];
  then
    wget -qO /dev/null \
      --header "Content-Type: application/json" \
      --header "X-Gotify-Key: ${GOTIFY_TOKEN}" \
      "${GOTIFY_URL}/message?format=markdown" \
      --post-data "{ \"title\" : \"${TR_TORRENT_NAME}\", \"message\" : \"Torrent is ${status,,}. id: ${TR_TORRENT_ID}, hash: ${TR_TORRENT_HASH}\" }" \
      -T 5 \
    ;
  fi
}

# if not sourcing, run
[[ "$0" == "$BASH_SOURCE" ]] && fn_notify $@;
