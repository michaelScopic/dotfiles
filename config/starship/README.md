# Starship prompt

Starship is a shell prompt written in Rust. It aims to be very fast, customizable, and cross platform compatable.

## Note

My rounded config is not my own. It is copied from [Syndrizzle's hotfiles](https://github.com/syndrizzle/hotfiles/), but I tweaked the colors to work with any terminal color scheme. (Note: Some color schemes might make the gray)

The plain text config is also not my own. It is from [Starship's offical presets](https://starship.rs/presets).

`starship.toml` is not my own as well.

## Installation

(Inside the dotfiles directory...)

```sh
# Use the rounded prompt
cp config/starship/rounded.toml ~/.config/starship.toml

# Use the plain text prompt
cp config/starship/plain-text-symbols.toml ~/.config/starship.toml

# Use my personal favorite prompt
cp config/starship/starship.toml ~/.config/
```

## Preview

![starship preview](https://github.com/michaelScopic/dotfiles/blob/main/assets/starshipPreview.png)
