#!/usr/bin/env zsh

##
## Based on rUvbot v0.01 by Reuven Cohen
## Compliant with new macOS default shell zsh
## github: fxspeiser 
## CAUTION: experimental, use at your own risk 
##

# Set your OpenAI API key here
API_KEY="<YOUR API KEY>" 	#place your Open AI API Key Here 
temp1="0.8" 				#temperature for attempt 1
temp2="1.5" 				#temperature for attempt 2 

# Helper function to show help
show_help() {
  echo "Usage: $(basename "$0") [OPTIONS] <user_input>"
  echo ""
  echo "Options:"
  echo "  -h, --help    Show this help message and exit"
  echo ""
  echo "This script takes user input and generates shell commands based on the input using OpenAI's GPT-3.5 Turbo."
  echo ""
  echo "Common Commands:"
  echo "  File Management & Storage:"
  echo "    ls              List files and directories in the current directory"
  echo "    cd              Change the current working directory"
  echo "    mkdir           Create a new directory"
  echo "    touch           Create a new file"
  echo "    rm              Remove a file or directory"
  echo "    cp              Copy a file or directory"
  echo "    mv              Move or rename a file or directory"
  echo ""
  echo "  Networking:"
  echo "    ping            Test network connectivity to a host"
  echo "    curl            Transfer data from or to a server"
  echo "    ssh             Connect to a remote server securely"
  echo ""
  echo "  Coding:"
  echo "    Rust:"
  echo "      cargo         Package manager for Rust"
  echo "      rustc         Rust compiler"
  echo ""
  echo "    Python:"
  echo "      pip           Package installer for Python"
  echo "      python        Python interpreter"
  echo ""
  echo "    NPM:"
  echo "      npm           Package manager for Node.js"
  echo "      node          Node.js runtime environment"
  echo ""
  echo "    AWS:"
  echo "      awscli        Command-line interface for AWS"
}

# Check for help argument
for arg in "$@"; do
  case $arg in
    -h|--help)
      show_help
      exit 0
      ;;
  esac
done

args="$*"
cwd=$(pwd)

# Function to generate command suggestions
generate_command_suggestions() {
  local temperature="$1"
  local response=$(curl -s -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $API_KEY" \
    -d "{
    \"model\": \"gpt-3.5-turbo\",
    \"messages\": [
      {\"role\": \"system\", \"content\": \"You are a helpful assistant. You will generate $SHELL commands based on user input. Your response should contain ONLY the command and NO explanation. Do NOT ever use newlines to separate commands, instead use ; or &&. The current working directory is $cwd.\"},
      {\"role\": \"user\", \"content\": \"${args//\"/\\\"}\"}
    ],
    \"temperature\": $temperature,
    \"max_tokens\": 200,
    \"top_p\": 1
  }" \
    "https://api.openai.com/v1/chat/completions")

  local command=$(echo "$response" | jq -r '.choices[0].message.content')
  echo "$command"
}

while true; do
  echo "\n##########################################"
  echo "Enter your command or type 'quit' to exit:"
  read -r user_input
  if [ "$user_input" = "quit" ]; then
    break
  fi
  args="$user_input"
  echo "Generating suggestions for command: $args"

  suggestion1=$(generate_command_suggestions "$temp1" "$args")
  suggestion2=$(generate_command_suggestions "$temp2" "$args")

  echo "Suggestion 1: $suggestion1"
  echo "Suggestion 2: $suggestion2"

  echo "Choose which suggestion to execute (1/2) or any other key to skip:"
  read -r choice

  if [ "$choice" -eq "1" ]; then
    echo "Executing: $suggestion1"

	 if [[ "$suggestion1" != *$'\n'* ]]; then
	        eval "$suggestion1"
	      else
	        echo "Error: Suggestion contains a incosistent formatting, which is not allowed."
	      fi
	    elif [ "$choice" -eq "2" ]; then
	      echo "Executing: $suggestion2"
	      if [[ "$suggestion2" != *$'\n'* ]]; then
	        eval "$suggestion2"
	      else
	        echo "Error: Suggestion contains a incosistent formatting, which is not allowed."
	      fi
	    else
	      echo "Skipping execution."
	    fi
	  done
