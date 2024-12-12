# Correctly: Grammar Correction and Text Enhancement with Local LLMs

Correctly is a shell script that uses local large language models (LLMs) to correct grammar, improve clarity, and enhance the readability of text. It works by taking text from your clipboard, sending it to an OpenAI-compatible API server (like LM Studio), and then displaying the improved text in a notification. The corrected text can also be copied back to the clipboard.

## Features

*   **Local LLM Processing:** Uses a local LLM (e.g., GRMR-2b-instruct-GGUF) for offline grammar correction.
*   **OpenAI-Compatible API:** Integrates seamlessly with any API server that follows the OpenAI API standard, like LM Studio.
*   **Clipboard Integration:** Automatically retrieves the text you've copied to your clipboard.

## Prerequisites

1. **An OpenAI-Compatible API Server:** You need a running instance of an API server that can serve local LLMs. LM Studio is a great option and easy to set up.
2. **A Suitable LLM:** Download a model designed for grammar correction, such as `GRMR-2b-instruct-GGUF`. Load this model into your API server.
3. **Dependencies:**
    *   `curl`: For making HTTP requests.
    *   `jq`: For parsing JSON.
    *   `wl-clipboard`: For interacting with the Wayland clipboard ( `wl-copy`, `wl-paste` ).
    *   `notify-send`: For displaying desktop notifications.

    Install these using your distribution's package manager, e.g., on Arch:

    ```bash
    sudo pacman -S curl jq wl-clipboard libnotify
    ```

## Installation

1. **Save the Script:**
    *   Copy the provided script code.
    *   Save it to a file named `correctly.sh` (or any name you prefer).
    *   Place it in a directory of your choice (e.g., `/home/username/scripts/`).
2. **Make it Executable:**
    ```bash
    chmod +x /home/username/scripts/correctly.sh
    ```
3. **Configure (Optional):**
    *   If you want to change the default settings (base URL, API key, model, temperature), modify the corresponding variables at the beginning of the script.

## Usage

1. **Start your API Server:** Make sure your API server (e.g., LM Studio) is running and has the `GRMR-2b-instruct-GGUF` model loaded.
2. **Copy Text:** Copy the text you want to correct to your clipboard.
3. **Run the Script:**
    *   **Manually:** Execute the script from your terminal:
        ```bash
        /home/username/scripts/correctly.sh
        ```
    *   **GNOME Keyboard Shortcut (Recommended):**
        1. Go to GNOME Settings -> Keyboard -> Keyboard Shortcuts -> View and Customize Shortcuts -> Custom Shortcuts.
        2. Click the "+" button to add a new shortcut.
        3. Name: `Correctly` (or any name you like).
        4. Command: `/home/username/scripts/correctly.sh`
        5. Shortcut: Set your preferred shortcut (e.g., Ctrl + Alt + =).

        Now, whenever you press your chosen shortcut after copying text, the script will run.

4. **Notification:** A notification will appear with the corrected text. If the "copy" action is triggered, the corrected text will also be copied back to your clipboard.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
