# ruvbot - Devops using OpenAi ChatGPT Model
This script is the Mac default shell (zsh) port of Reuven Cohen's (ruvnet) command-line tool that utilizes OpenAI's GPT-3.5 Turbo to generate shell commands based on user input. 

## More details
This script serves as a valuable tool for server administrators and DevOps professionals who want to simplify their daily tasks and improve their workflow. By leveraging the OpenAI API and ChatGPT model, the script generates shell command suggestions based on user input, allowing users to perform a wide range of operations with ease.

The key advantage of using this script is its ability to understand natural language input and translate it into relevant shell commands. This not only saves time but also reduces the likelihood of human error when performing complex tasks. Moreover, the script provides multiple command options, empowering users to make informed decisions while executing their tasks. This can help admins and devops professionals with macOS environments manage and maintain their systems with a helpful AI assistant. 

Here's a breakdown of the script:

* Define a show_help function that displays usage instructions and script options.
* Check for the -h or --help arguments to show the help message if needed.
* Define a get_response function to make an API call to OpenAI, passing the user input and a temperature setting for the GPT-3.5 Turbo model.
* Make two API calls with different temperature settings and extract the generated commands from the API responses.
* Display the generated commands as options for the user to choose from.
* Prompt the user to choose a command option or cancel.
* Exit the program OR execute the desired command
* Display the command output and, if there is any output.
* Stay alive and ask the user for additional instructions. 

## Install & Usage Instructions:

This script was made for macOS.

Update the OpenAI API Key: Replace <YOUR API KEY> near the top of the script with your actual OpenAI API key. There are two instances where you need to replace this placeholder. The lines are:

### API_KEY=\"<YOUR API KEY>\"  
Replace <YOUR API KEY> with your API key from OpenAI

### chmod +x script_name.sh  
Replace script_name.sh with the actual name of the script. In our case ruv.zsh

### Run the script:

`cd src`

Make sure you are in the `src` directory. 
  
` ./ruv.zsh [OPTIONS]  ` 

You can pass `--help` to get some pointers

### The script will prompt you to describe a system operation to perform
For instance: 

* create a local directory called test 
* find a network route to www.wall.org   
* install the express package globally
* check the IP address of my local machine

The script will provide you with up to two options to select and you can choose to execute one, or type 'quit' to exit. 

## Available options:

### -h or --help: Show the help message and exit.  
For example, to run the script with the user input "create a new directory called test", you would execute the following command:

