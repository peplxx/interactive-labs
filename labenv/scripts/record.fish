#!/usr/bin/fish

# Handles zellij session recording with asciinema

set -Ux fish_greeting ""
mkdir -p recordings

while true
    set DATE_TIME $(TZ=Europe/Moscow date '+%Y-%m-%d_%H-%M-%S')
    asciinema rec -i 1 "recordings/$DATE_TIME.cast" -c zellij

    read -P 'Session finished. Upload recording to asciinema? [y/N]: ' confirm
    if test "$confirm" = "y"
        asciinema upload "recordings/$DATE_TIME.cast"
    end

    read -P 'Press Enter to start a new session: ' restart
end
