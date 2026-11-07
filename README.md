# ISGB!

**I Said Go Back!** A directory history navigation plugin for Yazi.

ISGB! lets you navigate forwards and backwards through directories you've visited.

The plugin uses an array and an index position to store your navigation history. ISGB! also maintains a separate history for each tab!

# Installation

Use **ya pkg** to install ISGB!:

```bash
ya pkg add pero-sk/i-s-g-b
```

## init.lua

Add the following to your **init.lua** file (usually located at **~/.config/yazi/init.lua**):

```lua
require("i-s-g-b"):setup()
```

## keymap.toml

Add the following keybindings to your **keymap.toml** file (usually located at **~/.config/yazi/keymap.toml**):

```toml
[[mgr.prepend_keymap]]
on = [ "g", "s" ]
run = "plugin i-s-g-b back"
desc = "ISGB: Go back"

[[mgr.prepend_keymap]]
on = [ "g", "w" ]
run = "plugin i-s-g-b forward"
desc = "ISGB: Go forward"
```

# Compatibility

ISGB! has only been tested on the latest version of Yazi (**26.9.1**) and may not work on older versions.

# Known limitations

1. Following symlinks using Yazi's built-in **follow** (**g+f**) action can cause history entries to resolve to the symlink's destination rather than the original symlink path.
