# Setup WSL

## Install

See: https://docs.microsoft.com/en-us/windows/wsl/install-win10

## Configuration

### Set color scheme for Vim

```bash
sudo bash -c 'echo "colorscheme elflord" >> /etc/vim/vimrc.local'
```

## Troubleshooting

### `The attempted operation is not supported for the type of object referenced.`

```bat
netsh winsock reset
```
