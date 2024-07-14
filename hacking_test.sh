#!/bin/bash

# Base directory for sound files
BASE_DIR="$(cd "$(dirname "$0")"; pwd)" || exit 2

# Function to generate a random string of characters
generate_random_chars() {
    local len=$1
    tr -dc 'A-Za-z0-9!@#$%^&*()_+-=[]{}|;:,.<>/?' < /dev/urandom | head -c $len
}

# Function to insert passwords randomly into a line of random characters
generate_line_with_password() {
    local password=$1
    local line_length=60  # Increased line length to accommodate spacing
    local password_length=${#password}
    local start=$(( RANDOM % (line_length - password_length - 2) + 1 ))  # Ensure space for leading and trailing spaces
    local pre=$(generate_random_chars $start)
    local post=$(generate_random_chars $(( line_length - start - password_length - 2 )))
    echo "$pre $password $post"  # Spaces added around the password
}

# Function to display the hacking interface
display_interface() {
    local start_line=3  # Starting line for passwords display
    tput cup 0 0
    echo "0xF9C1 |$(generate_random_chars 10)|"
    for i in "${!passwords[@]}"; do
        line=$(generate_line_with_password "${passwords[$i]}")
        tput cup $((start_line + i)) 0
        if [[ $i -eq $cursor_position ]]; then
            pre=${line%%${passwords[$i]}*}
            post=${line#*${passwords[$i]}}
            echo -n "|$pre"
            tput setab 4
            echo -n "${passwords[$i]}"
            tput sgr0
            echo "|$post"
        else
            echo "|$line|"
        fi
    done
    tput cup $((start_line + ${#passwords[@]})) 0
    echo "|$(generate_random_chars 50)| 0xFA3E"
}

# Function to update a single line
update_line() {
    local index=$1
    local start_line=3  # Starting line for passwords display
    tput cup $((start_line + index)) 0
    line=$(generate_line_with_password "${passwords[$index]}")
    if [[ $index -eq $cursor_position ]]; then
        pre=${line%%${passwords[$index]}*}
        post=${line#*${passwords[$index]}}
        echo -n "|$pre"
        tput setab 4
        echo -n "${passwords[$index]}"
        tput sgr0
        echo "|$post"
    else
        echo "|$line|"
    fi
}

# Function to center multiline text
center_multiline_text() {
    local lines=("$@")
    for line in "${lines[@]}"; do
        printf "%s\n" "$line"
    done
}

# Function to display attempt count and closeness at the bottom of the screen
display_attempt_info() {
    local attempts=$1
    local max_attempts=$2
    local correct_count=$3
    local term_height=$(tput lines)
    tput cup $((term_height - 1)) 0
    printf "Attempts used: %d/%d | Correct letters: %d/%d" "$attempts" "$max_attempts" "$correct_count" "${#correct_password}"
}

# Function to clear the attempt info area
clear_attempt_info() {
    local term_height=$(tput lines)
    tput cup $((term_height - 1)) 0
    printf "%-50s" ""
}

# Function to start the game
hacking_game() {
    clear
    passwords=("WINTER" "FILTER" "MINTER" "KITTEN" "BINDER" "WINNER" "FINDER" "THINKER" "SPLINTER" "TINKER" "CLINKER" "SINKER" "PINKER" "RISKER" "BLINKER")
    local max_attempts=6
    local cursor_position=0

    # Randomly select one password from the list
    local correct_password="${passwords[$RANDOM % ${#passwords[@]}]}"

    # Initialize attempts
    local attempt_count=0
    local guess=""
    local correct_count=0

    center_multiline_text "Passcode Bypass Terminal Activated"
    center_multiline_text "Guess the password. All passwords have ${#correct_password} characters."
    echo
    read -p "Press enter to continue"
    
    display_interface
    display_attempt_info $attempt_count $max_attempts $correct_count

    while (( attempt_count < max_attempts )); do
        while true; do
            read -s -n 1 key
            case "$key" in
                $'\x1b')  # Escape sequence
                    read -s -n 1 -t 0.1 key
                    if [[ "$key" == "[" ]]; then
                        read -s -n 1 -t 0.1 key
                        case "$key" in
                            "A")  # Up arrow
                                previous_position=$cursor_position
                                ((cursor_position--))
                                if (( cursor_position < 0 )); then
                                    cursor_position=$((${#passwords[@]} - 1))
                                fi
                                update_line $previous_position
                                update_line $cursor_position
                                ;;
                            "B")  # Down arrow
                                previous_position=$cursor_position
                                ((cursor_position++))
                                if (( cursor_position >= ${#passwords[@]} )); then
                                    cursor_position=0
                                fi
                                update_line $previous_position
                                update_line $cursor_position
                                ;;
                        esac
                    fi
                    ;;
                "")  # Enter key
                    guess=${passwords[$cursor_position]}
                    break
                    ;;
            esac
        done

        guess=$(echo "$guess" | tr '[:lower:]' '[:upper:]')  # Convert to uppercase for comparison

        # Check if guess is valid
        if [[ "${#guess}" -ne "${#correct_password}" ]]; then
            clear_attempt_info
            aplay "$BASE_DIR/ui_hacking_passbad.wav" > /dev/null 2>&1
            display_attempt_info $attempt_count $max_attempts $correct_count
            continue
        fi

        # Check if the guess is correct
        if [[ "$guess" == "$correct_password" ]]; then
            clear_attempt_info
            sleep 1.5
            clear
            aplay "$BASE_DIR/ui_hacking_passgood.wav" > /dev/null 2>&1
            welcome_art=$(cat <<-EOF
                Access Granted.
                Welcome, Overseer.
EOF
            )

            center_multiline_text "$welcome_art"
            sleep 1.5
            aplay "$BASE_DIR/ui_hacking_charscroll.wav" > /dev/null 2>&1
            mainmenufunc
            return  # Exit the game loop and function after success
        fi

        # Calculate correct letters in the correct positions
        correct_count=$(check_password "$guess" "$correct_password")
        clear_attempt_info
        aplay "$BASE_DIR/ui_hacking_passbad.wav" > /dev/null 2>&1
        ((attempt_count++))
        display_attempt_info $attempt_count $max_attempts $correct_count
        sleep 1

        # Check for attempt exhaustion
        if (( attempt_count >= max_attempts )); then
            clear_attempt_info
            clear
            aplay "$BASE_DIR/ui_hacking_passbad.wav" > /dev/null 2>&1
            center_multiline_text "Terminal locked. Starting cooldown..."
            for (( i=10; i>0; i-- )); do
                aplay "$BASE_DIR/ui_hacking_charscroll.wav" > /dev/null 2>&1
                center_multiline_text "$i... "
                sleep 1
            done
            aplay "$BASE_DIR/ui_hacking_charenter_01.wav" > /dev/null 2>&1
            center_multiline_text "Cooldown complete. You may try again."
            hacking_game
            return  # Exit the current instance of the game loop and function
        fi
    done
}

# Function to compare guess with the correct password
check_password() {
    local guess=$1
    local correct=$2
    local count=0

    for (( i=0; i<${#guess}; i++ )); do
        if [[ "${guess:$i:1}" == "${correct:$i:1}" ]]; then
            ((count++))
        fi
    done

    echo $count
}

# Start the game
hacking_game
