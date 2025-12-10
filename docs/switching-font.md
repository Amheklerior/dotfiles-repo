# Switching Font

## Downloading a new font

To download and install a new font simply run the following command:

```sh
brew install font-victor-mono-nerd-font
```

### Currently installed fonts

- [Victor Mono Nerd Font](https://rubjo.github.io/victor-mono/) (`font-victor-mono-nerd-font`) - by Rubjo
- [Geist Mono Nerd Font](https://vercel.com/font) (`font-geist-mono-nerd-font`) - by Vercel
- [JetBrains Mono Nerd Font](https://www.jetbrains.com/lp/mono/) (`font-jetbrains-mono-nerd-font`) - by JetBrains
- [Zed Mono Nerd Font](https://github.com/zed-industries/zed-fonts) (`font-zed-mono-nerd-font`) - by Zed Industries
- [Monaspace](https://monaspace.githubnext.com/) (`font-monaspace-nf`) - by GitHub
- [Lilex](https://lilex.myrt.co/) (`font-lilex-nerd-font`) - by IBM

> **NOTE**: Vicotr Mono is the only font actually installed (the others are present on the Brewfile but commented out to speed up the bootstrap process). Find out more by running `brew search font`.

## Ghostty

Just update its [`~/.config/ghostty/config`](../dotfiles/.config/ghostty/config) file with the following line:

```sh
font-family=Victor Mono Nerd Font
```

> **HINT**: run `ghostty +list-fonts | rg "^\w"` to get the list of possible fonts to set.

## VSCode

Update its [`settings.json`](../prefs/vscode/settings.json) file with the following lines:

```json
"editor.fontFamily": "'VictorMono Nerd Font', Menlo, Monaco, 'Courier New', monospace",
"editor.fontSize": 14,
"editor.fontLigatures": true,
```
