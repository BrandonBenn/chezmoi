const std = @import("std");
const eql = std.mem.eql;
const testing = std.testing;
const expect = testing.expect;

const BLACK = "\x1b[30m";
const BLUE = "\x1b[34m";
const GREEN = "\x1b[32m";
const MAGENTA = "\x1b[35m";
const RED = "\x1b[31m";
const RESET = "\x1b[0m";
const YELLOW = "\x1b[33m";
const CYAN = "\x1b[36m";
const WHITE = "\x1b[37m";
const BRIGHT_BLACK = "\x1b[90m";
const BRIGHT_BLUE = "\x1b[94m";
const BRIGHT_GREEN = "\x1b[92m";
const BRIGHT_MAGENTA = "\x1b[95m";
const BRIGHT_RED = "\x1b[91m";
const BRIGHT_YELLOW = "\x1b[93m";
const BRIGHT_CYAN = "\x1b[96m";
const BRIGHT_WHITE = "\x1b[97m";
const UNDERLINE = "\x1b[4m";

const Code = enum {
    Black,
    Red,
    Green,
    Blue,
    Yellow,
    Magenta,
    Cyan,
    White,
    BrightBlack,
    BrightRed,
    BrightGreen,
    BrightBlue,
    BrightYellow,
    BrightMagenta,
    BrightCyan,
    BrightWhite,
    Underline,
};

pub fn set(allocator: std.mem.Allocator, code: Code, str: []const u8) ![]u8 {
    const concat = std.mem.concat;
    const colored = switch (code) {
        .Black => &[_][]const u8{ BLACK, str, RESET },
        .Red => &[_][]const u8{ RED, str, RESET },
        .Green => &[_][]const u8{ GREEN, str, RESET },
        .Blue => &[_][]const u8{ BLUE, str, RESET },
        .Yellow => &[_][]const u8{ YELLOW, str, RESET },
        .Magenta => &[_][]const u8{ MAGENTA, str, RESET },
        .Cyan => &[_][]const u8{ CYAN, str, RESET },
        .White => &[_][]const u8{ WHITE, str, RESET },
        .BrightBlack => &[_][]const u8{ BRIGHT_BLACK, str, RESET },
        .BrightRed => &[_][]const u8{ BRIGHT_RED, str, RESET },
        .BrightGreen => &[_][]const u8{ BRIGHT_GREEN, str, RESET },
        .BrightBlue => &[_][]const u8{ BRIGHT_BLUE, str, RESET },
        .BrightYellow => &[_][]const u8{ BRIGHT_YELLOW, str, RESET },
        .BrightMagenta => &[_][]const u8{ BRIGHT_MAGENTA, str, RESET },
        .BrightCyan => &[_][]const u8{ BRIGHT_CYAN, str, RESET },
        .BrightWhite => &[_][]const u8{ BRIGHT_WHITE, str, RESET },
        .Underline => &[_][]const u8{ UNDERLINE, str, RESET },
    };

    return try concat(allocator, u8, colored);
}

test "set" {
    const allocator = testing.allocator;
    const expected = try set(allocator, .Red, "test");
    try expect(eql(u8, expected, "\x1b[31mtest\x1b[0m"));
    defer testing.allocator.free(expected);
}
