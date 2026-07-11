#!/usr/bin/env zsh

# Only run this for interactive shells
if [[ $- == *i* ]]; then
    
    clear 
    
    # 1. Random Fun Greetings Array (Manually padded with spaces to perfectly align the right border)
    GREETINGS=(
        "Welcome back, Parth! 🚀              "
        "Systems nominal, Parth. 🟢           "
        "What are we building today? ☕       "
        "Awaiting your commands, Parth... ⚡  "
        "Back to the command line! 💻         "
    )
    
    # Fix for Zsh's 1-based array indexing!
    GREETING=${GREETINGS[$(( (RANDOM % ${#GREETINGS[@]}) + 1 ))]}
    
    # 2. Fully Closed Greeting Box
    echo -e "  \e[1;36m╭───────────────────────────────────────╮\e[0m"
    echo -e "  \e[1;36m│\e[0m \e[1;32m$GREETING\e[0m \e[1;36m│\e[0m"
    echo -e "  \e[1;36m╰───────────────────────────────────────╯\e[0m"
    
    # 3. System Stats
    echo -e "\e[1;35m  ⚡ Uptime:\e[0m  $(uptime -p | sed 's/up //')"
    echo -e "\e[1;35m  🧠 Memory:\e[0m  $(free -m | awk '/Mem:/ { printf "%s MB / %s MB", $3, $2 }')"
    echo ""

    # 4. Read and display the cached item cleanly
    QUOTE_FILE="$HOME/.cache/motd_quote.txt"
    if [ -f "$QUOTE_FILE" ]; then
        command cat "$QUOTE_FILE"
        echo "" 
    else
        echo -e "  \e[3m\"Setting up your daily drops for next time...\"\e[0m\n"
    fi

    # 5. Fetch the NEXT item randomly in the background (Silent)
    (
        # Using 'shuf' instead of $RANDOM to guarantee perfect randomness in subshells
        CHOICE=$(shuf -i 0-2 -n 1)
        
        case $CHOICE in
            0)
                # Dad Joke -> PINK
                JOKE=$(curl -s -H "Accept: text/plain" https://icanhazdadjoke.com/)
                echo -e "  \e[3;35m$JOKE\e[0m" > "$QUOTE_FILE"
                ;;
            1)
                # ZenQuotes (Inspirational) -> GREEN
                QUOTE=$(curl -s https://zenquotes.io/api/random | jq -r '.[0] | "\(.q)\n    — \(.a)"')
                echo -e "  \e[3;32m\"$QUOTE\"\e[0m" > "$QUOTE_FILE"
                ;;
            2)
                # Advice Slip -> YELLOW
                ADVICE=$(curl -s https://api.adviceslip.com/advice | jq -r '.slip.advice')
                echo -e "  \e[3;33m\"$ADVICE\"\e[0m" > "$QUOTE_FILE"
                ;;
        esac
    ) > /dev/null 2>&1 &!
    
fi
