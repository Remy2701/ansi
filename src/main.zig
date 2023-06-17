const std = @import("std");

pub const Cursor = union(enum) {
    Home: void,
    MoveTo: struct {
        line: usize,
        column: usize
    },
    MoveUp: usize,
    MoveDown: usize,
    MoveRight: usize,
    MoveLeft: usize,
    MoveDownBeginning: usize,
    MoveUpBeginning: usize,
    MoveToColumn: usize,
    MoveOneUp: void,
    SaveDEC: void,
    LoadDEC: void,
    SaveSCO: void,
    LoadSCO: void,

    pub fn home() Cursor {
        return Cursor {
            .Home = void {}
        };
    }

    pub fn moveTo(line: usize, column: usize) Cursor {
        return Cursor {
            .MoveTo = . {
                .line = line,
                .column = column
            }
        };
    }

    pub fn moveUp(lines: usize) Cursor {
        return Cursor {
            .MoveUp = lines
        };
    } 

    pub fn moveDown(lines: usize) Cursor {
        return Cursor {
            .MoveDown = lines
        };
    } 

    pub fn moveRight(columns: usize) Cursor {
        return Cursor {
            .MoveRight = columns
        };
    } 

    pub fn moveLeft(columns: usize) Cursor {
        return Cursor {
            .MoveLeft = columns
        };
    } 

    pub fn moveDownBeginning(lines: usize) Cursor {
        return Cursor {
            .MoveDownBeginning = lines
        };
    } 

    pub fn moveUpBeginning(lines: usize) Cursor {
        return Cursor {
            .MoveUpBeginning = lines
        };
    } 

    pub fn moveToColumn(column: usize) Cursor {
        return Cursor {
            .MoveToColumn = column
        };
    }

    pub fn moveOneUp() Cursor {
        return Cursor {
            .MoveOneUp = void {}
        };
    }

    pub fn saveDEC() Cursor {
        return Cursor {
            .SaveDEC = void {}
        };
    }

    pub fn loadDEC() Cursor {
        return Cursor {
            .LoadDEC = void {}
        };
    }

    pub fn saveSCO() Cursor {
        return Cursor {
            .SaveSCO = void {}
        };
    }

    pub fn loadSCO() Cursor {
        return Cursor {
            .LoadSCO = void {}
        };
    }

    pub fn format(self: Cursor, comptime fmt: []const u8, options: std.fmt.FormatOptions, writer: anytype) !void {
        _ = fmt;
        _ = options;
        switch(self) {
            .Home => try writer.writeAll("\x1B[H"),
            .MoveTo => |where| {
                try std.fmt.format(writer, "\x1B[{};{}H", .{where.line, where.column});
            },
            .MoveUp => |value| {
                try std.fmt.format(writer, "\x1B[{}A", .{value});
            },
            .MoveDown => |value| {
                try std.fmt.format(writer, "\x1B[{}B", .{value});
            },
            .MoveRight => |value| {
                try std.fmt.format(writer, "\x1B[{}C", .{value});
            },
            .MoveLeft => |value| {
                try std.fmt.format(writer, "\x1B[{}D", .{value});
            },
            .MoveUpBeginning => |value| {
                try std.fmt.format(writer, "\x1B[{}E", .{value});
            },
            .MoveDownBeginning => |value| {
                try std.fmt.format(writer, "\x1B[{}F", .{value});
            },
            .MoveToColumn => |value| {
                try std.fmt.format(writer, "\x1B[{}G", .{value});
            },
            .MoveOneUp => try writer.writeAll("\x1B M"),
            .SaveDEC => try writer.writeAll("\x1B7"),
            .LoadDEC => try writer.writeAll("\x1B8"),
            .SaveSCO => try writer.writeAll("\x1B[s"),
            .LoadSCO => try writer.writeAll("\x1B[u")
        }
    }
};  

pub const Erase = enum {
    FromCursorToEnd,
    FromCursorToStart,
    All,
    SavedLines,
    FromCursorToEndOfLine,
    FromCursorToStartOfLine,
    EntireLine,

    pub fn fromCursorToEnd() Erase {
        return Erase.FromCursorToEnd;
    }

    pub fn fromCursorToStart() Erase {
        return Erase.FromCursorToStart;
    }

    pub fn all() Erase {
        return Erase.All;
    }

    pub fn savedLines() Erase {
        return Erase.SavedLines;
    }

    pub fn fromCursorToEndOfLine() Erase {
        return Erase.FromCursorToEndOfLine;
    }

    pub fn fromCursorToStartOfLine() Erase {
        return Erase.FromCursorToStartOfLine;
    }

    pub fn entireLine() Erase {
        return Erase.EntireLine;
    }

    pub fn format(self: Erase, comptime fmt: []const u8, options: std.fmt.FormatOptions, writer: anytype) !void {
        _ = fmt;
        _ = options;
        switch (self) {
            .FromCursorToEnd => try writer.writeAll("\x1B[0J"),
            .FromCursorToStart => try writer.writeAll("\x1B[1J"),
            .All => try writer.writeAll("\x1B[2J"),
            .SavedLines => try writer.writeAll("\x1B[3J"),
            .FromCursorToEndOfLine => try writer.writeAll("\x1B[0K"),
            .FromCursorToStartOfLine => try writer.writeAll("\x1B[1K"),
            .EntireLine => try writer.writeAll("\x1B[2K"),
        }
    }
};

pub const Graphics = enum {
    Reset,
    Bold,
    Faint,
    ResetWeight,
    Italic,
    ResetItalic,
    Underline,
    ResetUnderline,
    Blinking,
    ResetBlinking,
    Inverse,
    ResetInverse,
    Invisible,
    ResetInvisible,
    Strikethrough,
    ResetStrikethrough,

    pub fn reset() Graphics {
        return Graphics.Reset;
    }

    pub fn bold() Graphics {
        return Graphics.Bold;
    }

    pub fn faint() Graphics {
        return Graphics.Faint;
    }

    pub fn resetWeight() Graphics {
        return Graphics.ResetWeight;
    }

    pub fn italic() Graphics {
        return Graphics.Italic;
    }

    pub fn resetItalic() Graphics {
        return Graphics.ResetItalic;
    }

    pub fn underline() Graphics {
        return Graphics.Underline;
    }

    pub fn resetUnderline() Graphics {
        return Graphics.ResetUnderline;
    }

    pub fn blinking() Graphics {
        return Graphics.Blinking;
    }

    pub fn resetBlinking() Graphics {
        return Graphics.ResetBlinking;
    }

    pub fn inverse() Graphics {
        return Graphics.Inverse;
    }

    pub fn resetInverse() Graphics {
        return Graphics.ResetInverse;
    }

    pub fn invisible() Graphics {
        return Graphics.Invisible;
    }

    pub fn resetInvisible() Graphics {
        return Graphics.ResetInvisible;
    }

    pub fn strikethrought() Graphics {
        return Graphics.Strikethrough;
    }

    pub fn resetStrikethrought() Graphics {
        return Graphics.ResetStrikethrough;
    }

    pub fn format(self: Graphics, comptime fmt: []const u8, options: std.fmt.FormatOptions, writer: anytype) !void {
        _ = fmt;
        _ = options;
        switch(self) {
            .Reset => try writer.writeAll("\x1B[0m"),
            .Bold => try writer.writeAll("\x1B[1m"),
            .Faint => try writer.writeAll("\x1B[2m"),
            .ResetWeight => try writer.writeAll("\x1B[22m"),
            .Italic => try writer.writeAll("\x1B[3m"),
            .ResetItalic => try writer.writeAll("\x1B[23m"),
            .Underline => try writer.writeAll("\x1B[4m"),
            .ResetUnderline => try writer.writeAll("\x1B[24m"),
            .Blinking => try writer.writeAll("\x1B[5m"),
            .ResetBlinking => try writer.writeAll("\x1B[25m"),
            .Inverse => try writer.writeAll("\x1B[7m"),
            .ResetInverse => try writer.writeAll("\x1B[27m"),
            .Invisible => try writer.writeAll("\x1B[8m"),
            .ResetInvisible => try writer.writeAll("\x1B[28m"),
            .Strikethrough => try writer.writeAll("\x1B[9m"),
            .ResetStrikethrough => try writer.writeAll("\x1B[29m"),
        }
    }
};

pub const Foreground = union(enum) {
    Black: void,
    Red: void,
    Green: void,
    Yellow: void,
    Blue: void,
    Magenta: void,
    Cyan: void,
    White: void,
    Default: void,
    BrightBlack: void,
    BrightRed: void,
    BrightGreen: void,
    BrightYellow: void,
    BrightBlue: void,
    BrightMagenta: void,
    BrightCyan: void,
    BrightWhite: void,
    Color256: u8,
    RGB: struct {
        red: u8,
        green: u8,
        blue: u8
    },

    pub fn black() Foreground {
        return Foreground {
            .Black = void {}
        };
    }

    pub fn red() Foreground {
        return Foreground {
            .Red = void {}
        };
    }

    pub fn green() Foreground {
        return Foreground {
            .Green = void {}
        };
    }

    pub fn yellow() Foreground {
        return Foreground {
            .Yellow = void {}
        };
    }

    pub fn blue() Foreground {
        return Foreground {
            .Blue = void {}
        };
    }

    pub fn magenta() Foreground {
        return Foreground {
            .Magenta = void {}
        };
    }

    pub fn cyan() Foreground {
        return Foreground {
            .Cyan = void {}
        };
    }

    pub fn white() Foreground {
        return Foreground {
            .White = void {}
        };
    }

    pub fn default() Foreground {
        return Foreground {
            .Default = void {}
        };
    }

    pub fn brightBlack() Foreground {
        return Foreground {
            .BrightBlack = void {}
        };
    }

    pub fn brightRed() Foreground {
        return Foreground {
            .BrightRed = void {}
        };
    }

    pub fn brightGreen() Foreground {
        return Foreground {
            .BrightGreen = void {}
        };
    }

    pub fn brightYellow() Foreground {
        return Foreground {
            .BrightYellow = void {}
        };
    }

    pub fn brightBlue() Foreground {
        return Foreground {
            .BrightBlue = void {}
        };
    }

    pub fn brightMagenta() Foreground {
        return Foreground {
            .BrightMagenta = void {}
        };
    }

    pub fn brightCyan() Foreground {
        return Foreground {
            .BrightCyan = void {}
        };
    }

    pub fn brightWhite() Foreground {
        return Foreground {
            .BrightWhite = void {}
        };
    }

    pub fn color256(color: u8) Foreground {
        return Foreground {
            .Color256 = color
        };
    }

    pub fn rgb(r: u8, g: u8, b: u8) Foreground {
        return Foreground {
            .RGB = .{
                .red = r,
                .green = g,
                .blue = b
            }
        };
    }

    pub fn format(self: Foreground, comptime fmt: []const u8, options: std.fmt.FormatOptions, writer: anytype) !void {
        _ = fmt;
        _ = options;
        switch(self) {
            .Black => try writer.writeAll("\x1B[1;30m"),
            .Red => try writer.writeAll("\x1B[1;31m"),
            .Green => try writer.writeAll("\x1B[1;32m"),
            .Yellow => try writer.writeAll("\x1B[1;33m"),
            .Blue => try writer.writeAll("\x1B[1;34m"),
            .Magenta => try writer.writeAll("\x1B[1;35m"),
            .Cyan => try writer.writeAll("\x1B[1;36m"),
            .White => try writer.writeAll("\x1B[1;37m"),
            .Default => try writer.writeAll("\x1B[1;39m"),
            .BrightBlack => try writer.writeAll("\x1B[1;90m"),
            .BrightRed => try writer.writeAll("\x1B[1;91m"),
            .BrightGreen => try writer.writeAll("\x1B[1;92m"),
            .BrightYellow => try writer.writeAll("\x1B[1;93m"),
            .BrightBlue => try writer.writeAll("\x1B[1;94m"),
            .BrightMagenta => try writer.writeAll("\x1B[1;95m"),
            .BrightCyan => try writer.writeAll("\x1B[1;96m"),
            .BrightWhite => try writer.writeAll("\x1B[1;97m"),
            .Color256 => |color| try std.fmt.format(writer, "\x1B[38;5;{}m", .{color}),
            .RGB => |color| try std.fmt.format(writer, "\x1B[38;2;{};{};{}m", .{color.red, color.green, color.blue})
        }
    }
};

pub const Background = union(enum) {
    Black: void,
    Red: void,
    Green: void,
    Yellow: void,
    Blue: void,
    Magenta: void,
    Cyan: void,
    White: void,
    Default: void,
    BrightBlack: void,
    BrightRed: void,
    BrightGreen: void,
    BrightYellow: void,
    BrightBlue: void,
    BrightMagenta: void,
    BrightCyan: void,
    BrightWhite: void,
    Color256: u8,
    RGB: struct {
        red: u8,
        green: u8,
        blue: u8
    },

    pub fn black() Background {
        return Background {
            .Black = void {}
        };
    }

    pub fn red() Background {
        return Background {
            .Red = void {}
        };
    }

    pub fn green() Background {
        return Background {
            .Green = void {}
        };
    }

    pub fn yellow() Background {
        return Background {
            .Yellow = void {}
        };
    }

    pub fn blue() Background {
        return Background {
            .Blue = void {}
        };
    }

    pub fn magenta() Background {
        return Background {
            .Magenta = void {}
        };
    }

    pub fn cyan() Background {
        return Background {
            .Cyan = void {}
        };
    }

    pub fn white() Background {
        return Background {
            .White = void {}
        };
    }

    pub fn default() Background {
        return Background {
            .Default = void {}
        };
    }

    pub fn brightBlack() Background {
        return Background {
            .BrightBlack = void {}
        };
    }

    pub fn brightRed() Background {
        return Background {
            .BrightRed = void {}
        };
    }

    pub fn brightGreen() Background {
        return Background {
            .BrightGreen = void {}
        };
    }

    pub fn brightYellow() Background {
        return Background {
            .BrightYellow = void {}
        };
    }

    pub fn brightBlue() Background {
        return Background {
            .BrightBlue = void {}
        };
    }

    pub fn brightMagenta() Background {
        return Background {
            .BrightMagenta = void {}
        };
    }

    pub fn brightCyan() Background {
        return Background {
            .BrightCyan = void {}
        };
    }

    pub fn brightWhite() Background {
        return Background {
            .BrightWhite = void {}
        };
    }

    pub fn color256(color: u8) Background {
        return Background {
            .Color256 = color
        };
    }

    pub fn rgb(r: u8, g: u8, b: u8) Background {
        return Background {
            .RGB = .{
                .red = r,
                .green = g,
                .blue = b
            }
        };
    }

    pub fn format(self: Background, comptime fmt: []const u8, options: std.fmt.FormatOptions, writer: anytype) !void {
        _ = fmt;
        _ = options;
        switch(self) {
            .Black => try writer.writeAll("\x1B[1;40m"),
            .Red => try writer.writeAll("\x1B[1;41m"),
            .Green => try writer.writeAll("\x1B[1;42m"),
            .Yellow => try writer.writeAll("\x1B[1;43m"),
            .Blue => try writer.writeAll("\x1B[1;44m"),
            .Magenta => try writer.writeAll("\x1B[1;45m"),
            .Cyan => try writer.writeAll("\x1B[1;46m"),
            .White => try writer.writeAll("\x1B[1;47m"),
            .Default => try writer.writeAll("\x1B[1;49m"),
            .BrightBlack => try writer.writeAll("\x1B[1;100m"),
            .BrightRed => try writer.writeAll("\x1B[1;101m"),
            .BrightGreen => try writer.writeAll("\x1B[1;102m"),
            .BrightYellow => try writer.writeAll("\x1B[1;103m"),
            .BrightBlue => try writer.writeAll("\x1B[1;104m"),
            .BrightMagenta => try writer.writeAll("\x1B[1;105m"),
            .BrightCyan => try writer.writeAll("\x1B[1;106m"),
            .BrightWhite => try writer.writeAll("\x1B[1;107m"),
            .Color256 => |color| try std.fmt.format(writer, "\x1B[48;5;{}m", .{color}),
            .RGB => |color| try std.fmt.format(writer, "\x1B[48;2;{};{};{}m", .{color.red, color.green, color.blue})
        }
    }
};

pub fn main() !void {
    std.debug.print("Hey{}{}My name is {}john{}{}{}remy{}!\n", .{
        Erase.all(),
        Cursor.home(),
        Cursor.saveDEC(), 
        Cursor.loadDEC(),
        Graphics.bold(),
        Background.red(),
        Graphics.reset()
    });
}