const std = @import("std");
const colors = @import("colors.zig");
const ArrayList = std.ArrayList;
const Allocator = std.mem.Allocator;

// TODO: use `zig-libgit2` to get the current branch name, Unable to do
// this in a cross-platform method due to libc headers not available;
// compilation does not link against libc

fn getBranchName(allocator: Allocator, path: []const u8) !?[]u8 {
    const result = try std.ChildProcess.exec(.{
        .allocator = allocator,
        .argv = &[_][]const u8{ "git", "branch", "--show-current" },
        .cwd = path,
    });

    const size = result.stdout.len;
    if (size < 2) return null;
    return result.stdout[0 .. size - 1]; // remove trailing newline
}

test "getBranchName" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    const branch = try getBranchName(allocator, ".");
    try std.testing.expectEqualStrings(branch.?, "master");
}

fn getBranchStatus(allocator: Allocator, path: []const u8) !?[]u8 {
    const result = try std.ChildProcess.exec(.{
        .allocator = allocator,
        .argv = &[_][]const u8{ "git", "status", "--porcelain" },
        .cwd = path,
    });

    if (result.stdout.len < 2) return null;
    return result.stdout;
}

pub fn makePrompt(allocator: Allocator, path: []const u8) !?[]u8 {
    const branch = try getBranchName(allocator, path);
    const status = try getBranchStatus(allocator, path);
    if (branch == null) return null;

    var prompt = ArrayList(u8).init(allocator);
    defer prompt.deinit();

    _ = prompt.append('(') catch {};
    _ = prompt.appendSlice(branch.?) catch {};
    _ = prompt.append(' ') catch {};

    // zig fmt: off
    const contains = std.mem.containsAtLeast;
    const added     = contains(u8, status.?, 1, "A");
    const deleted   = contains(u8, status.?, 1, "D");
    const renamed   = contains(u8, status.?, 1, "R");
    const modified  = contains(u8, status.?, 1, "M");
    const untracked = contains(u8, status.?, 1, "?");

    const set = colors.set;
    const a = allocator;
    if (added)     _ = prompt.appendSlice(try set(a, .BrightCyan, "+")) catch {};
    if (deleted)   _ = prompt.appendSlice(try set(a, .BrightRed, "-")) catch {};
    if (renamed)   _ = prompt.appendSlice(try set(a, .BrightYellow, "~")) catch {};
    if (modified)  _ = prompt.appendSlice(try set(a, .BrightYellow, "*")) catch {};
    if (untracked) _ = prompt.appendSlice(try set(a, .BrightRed, "?")) catch {};
    if (status == null) _ = prompt.appendSlice(try set(a, .Green, "✓")) catch {};
    // zig fmt: on
    _ = prompt.append(')') catch {};

    return prompt.toOwnedSlice();
}
