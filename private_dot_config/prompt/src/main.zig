const std = @import("std");
const colors = @import("colors.zig");
const git = @import("git.zig");
const path = @import("path.zig");
const stdout = std.io.getStdOut().writer();

const Allocator = std.mem.Allocator;

const PROMPT_SYMBOL = "λ";

fn makePrompt(allocator: Allocator, cwd: []u8) ![]u8 {
    const gitprompt = try git.makePrompt(allocator, cwd);
    const truncated = try path.truncatePath(
        allocator,
        cwd,
        std.os.getenv("HOME") orelse "",
    );
    defer allocator.free(truncated);

    const dir = try colors.set(allocator, .Cyan, truncated);
    const git_info = gitprompt orelse "";
    const prompt = &[_][]const u8{ "\n", dir, " ", git_info, "\n" ++ PROMPT_SYMBOL ++ " " };

    return try std.mem.concat(allocator, u8, prompt);
}

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const cwd = try std.fs.cwd().realpathAlloc(allocator, ".");
    try stdout.print("{s}\n", .{makePrompt(allocator, cwd)});
}
