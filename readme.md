# ANSI

This library provides abstraction to write ANSI codes, this allows you to
- Set background and foreground color
- Set text mode (Bold, Italic, Strikethrough, ...)
- Erase
- Manipulate the cursor

## Installation

Clone this repository in your libs folder.

```sh
git clone https://github.com/Remy2701/ansi
```

Then add the following line in the `build.zig`:

```zig
const ansi = @import("libs/ansi/build.zig");

pub fn build(b: *Build) !void {
    ...
    exe.addModule("ansi", ansi.module(b));
}
```

## Usage

```zig
const std = @import("std");
const ansi = @import("ansi");

pub fn main() void {
    std.debug.print("Hello, {}{}World{}!\n", .{
        ansi.Graphics.bold(),
        ansi.Foreground.blue(),
        ansi.Graphics.reset()
    });
}
```
