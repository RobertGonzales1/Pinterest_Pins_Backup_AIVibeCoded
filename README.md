# Pinterest Pins Backup

A small Windows batch script that backs up **all of your saved Pinterest pins** to your computer, organized into one folder per board. It's a thin wrapper around [gallery-dl](https://github.com/mikf/gallery-dl).

> Built with AI assistance ("vibe coded") — simple, readable, and easy to tweak.

## Features

- Downloads every pin from every board on your profile
- Saves files into a separate folder for each board (`pinterest_downloads/<board name>/`)
- **Incremental**: remembers what it already downloaded, so re-running only grabs new pins
- Writes a timestamped log and prints a per-board file count at the end
- Checks for common setup mistakes (missing username, gallery-dl not installed, missing cookie file) before starting

## Requirements

- Windows 10 or 11
- [Python 3.9+](https://www.python.org/downloads/) (tick **"Add Python to PATH"** during install)
- [gallery-dl](https://github.com/mikf/gallery-dl)
- A browser extension that exports cookies in Netscape `cookies.txt` format, for example **"Get cookies.txt LOCALLY"** (Chrome/Edge) or **"cookies.txt"** (Firefox)

## Installation

1. **Install gallery-dl** — open Command Prompt and run:

   ```bat
   pip install -U gallery-dl
   ```

   Check it worked with `gallery-dl --version`.

2. **Download this repo** — click **Code → Download ZIP** and extract it, or:

   ```bat
   git clone https://github.com/robertgonzales1/Pinterest_Pins_Backup_AIVibeCoded.git
   cd Pinterest_Pins_Backup_AIVibeCoded
   ```

3. **Export your Pinterest cookies**
   1. Log in to [pinterest.com](https://www.pinterest.com) in your browser.
   2. Use the cookie extension to export cookies for `pinterest.com`.
   3. Save the file as `pinterest_cookies.txt` in the same folder as `pinterest_backup.bat`.

4. **Set your username** — open `pinterest_backup.bat` in Notepad and change:

   ```bat
   set PINTEREST_USER=your_pinterest_username
   ```

   Your username is the part after `pinterest.com/` in your profile URL, e.g. `https://www.pinterest.com/janedoe/` → `janedoe`.

## Usage

Double-click `pinterest_backup.bat`, or run it from Command Prompt:

```bat
pinterest_backup.bat
```

Run it again any time to pick up newly saved pins — already-downloaded pins are skipped.

### Output

```
pinterest_downloads/
├── recipes/
│   ├── 1234567890.jpg
│   └── ...
├── home ideas/
└── ...
pinterest_download_log.txt     <- log of every run
pinterest_archive.sqlite3      <- tracks what's been downloaded (delete to force a full re-download)
```

## Configuration

All settings are at the top of `pinterest_backup.bat`:

| Variable         | Default                       | Description                                   |
| ---------------- | ----------------------------- | --------------------------------------------- |
| `PINTEREST_USER` | `your_pinterest_username`     | Your Pinterest username (**required**)        |
| `COOKIES`        | `pinterest_cookies.txt`       | Path to your exported cookie file             |
| `OUTPUT_DIR`     | `pinterest_downloads`         | Where pins are saved                          |
| `LOG_FILE`       | `pinterest_download_log.txt`  | Log file location                             |
| `ARCHIVE`        | `pinterest_archive.sqlite3`   | Download history used to skip existing pins   |

## Troubleshooting

| Problem | Fix |
| ------- | --- |
| `gallery-dl was not found` | Run `pip install -U gallery-dl` and make sure Python is on your PATH (reopen Command Prompt after installing). |
| Nothing downloads / 401 / login errors | Your cookies have expired. Log in to Pinterest again and re-export `pinterest_cookies.txt`. |
| Secret boards are missing | Make sure the cookies come from the account that owns the boards. |
| Downloads suddenly fail | Pinterest changes its site often — update with `pip install -U gallery-dl`. |

## ⚠️ Security note

`pinterest_cookies.txt` contains your **logged-in Pinterest session** — anyone who has it can access your account. Keep it private. It is listed in `.gitignore` so it won't be committed by accident; never share it or upload it anywhere.

## Disclaimer

This tool is intended for backing up **your own** saved pins for personal use. Respect Pinterest's Terms of Service and the copyright of the original creators. Use at your own risk.

## Credits

- [gallery-dl](https://github.com/mikf/gallery-dl) by Mike Fährmann, which does all the heavy lifting.

## License

[MIT](LICENSE)
