# Setup Windows Terminal

## settings.json

### 1. Set default `fontFace` into `profiles.defaults`

```json
"defaults":
{
    "fontFace": "HackGen35 Console"
}
```

### 2. Define color scheme for WSL

```json
"schemes": [
    {
        "name": "WSL",
        "background": "#0C0C0C",
        "black": "#000000",
        "blue": "#4040C4",
        "brightBlack": "#606060",
        "brightBlue": "#6060FF",
        "brightCyan": "#60FFFF",
        "brightGreen": "#60FF60",
        "brightPurple": "#FF60FF",
        "brightRed": "#FF6060",
        "brightWhite": "#FFFFFF",
        "brightYellow": "#FFFF60",
        "cyan": "#40C4C4",
        "foreground": "#C4C4C4",
        "green": "#40C440",
        "purple": "#33CCFF",
        "red": "#C44040",
        "white": "#FFFFFF",
        "yellow": "#C4C440"
    }
]
```

### 3. Set color scheme to WSL console

```json
{
    "name": "Ubuntu",
    "colorScheme": "WSL"
}
```

### 4. Set `startingDirectory` (Command Prompt, Windows PowerShell)

```json
{
    "startingDirectory": "%USERPROFILE%\\Desktop"
}
```

### 5. Add `-NoLogo` option to Windows PowerShell

```json
{
    "name": "Windows PowerShell",
    "commandline": "powershell.exe -NoLogo"
}
```
