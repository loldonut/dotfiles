#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/logger.sh"

declare -g SUDO_KEEPALIVE_PID=""

sudo_keepalive() {
    if [[ -n "$SUDO_KEEPALIVE_PID" ]] && kill -0 "$SUDO_KEEPALIVE_PID" 2>/dev/null; then
        return 0
    fi

    log "Starting sudo keep alive..."
    if ! sudo true; then
        log_die "Unable to obtain sudo privileges. Exiting."
    fi

    (
        while true; do
            sleep 60
            sudo true 2>/dev/null || exit 0
        done
    ) &
    SUDO_KEEPALIVE_PID=$!

    log "Sudo session started (PID: $SUDO_KEEPALIVE_PID)"
}

sudo_stop() {
    if [[ -n "$SUDO_KEEPALIVE_PID" ]] && kill -0 "$SUDO_KEEPALIVE_PID" 2>/dev/null; then
        kill "$SUDO_KEEPALIVE_PID" 2>/dev/null || true
        wait "$SUDO_KEEPALIVE_PID" 2>/dev/null || true
        SUDO_KEEPALIVE_PID=""
    fi
}
