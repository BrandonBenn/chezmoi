const std = @import("std");
const Allocator = std.mem.Allocator;
/// Returns truncated the path to the current directory.
pub fn truncatePath(allocator: Allocator, cwd: []const u8, home: []const u8) ![]u8 {
    const current_path = try std.mem.replaceOwned(u8, allocator, cwd, home, "~");
    defer allocator.free(current_path);

    var tokens = std.mem.tokenize(u8, current_path, "/");
    var truncated = std.ArrayList(u8).init(allocator);
    defer truncated.deinit();

    // if path less than 3 dirs deep, just return
    if (std.mem.count(u8, current_path, "/") < 3) {
        try truncated.appendSlice(current_path);
        return truncated.toOwnedSlice();
    }
    // if doesn't start with '~' then prepend '/'
    if (current_path[0] != '~') try truncated.append('/');

    while (tokens.next()) |token| {
        try truncated.append(token[0]);
        try truncated.append('/');
    }

    // remove last slash and truncated name
    truncated.shrinkAndFree(truncated.items.len - 2);

    // append fullname to end
    const trailing_name = blk: {
        const i = std.mem.lastIndexOf(u8, current_path, "/").?;
        break :blk current_path[i + 1 .. current_path.len];
    };
    try truncated.appendSlice(trailing_name);

    return truncated.toOwnedSlice();
}

test "truncatePath" {
    const allocator = std.testing.allocator;

    const path0 = try truncatePath(allocator, "/home/user", "/home/user");
    defer allocator.free(path0);
    try std.testing.expectEqualStrings("~", path0);

    const path1 = try truncatePath(allocator, "/home/user/foo/bar/baz", "/home/user");
    defer allocator.free(path1);
    try std.testing.expectEqualStrings("~/f/b/baz", path1);

    const path2 = try truncatePath(allocator, "/usr/local/bin", "/home/user");
    defer allocator.free(path2);
    try std.testing.expectEqualStrings("/u/l/bin", path2);

    const path3 = try truncatePath(allocator, "/home/other_user/foo/bar", "/home/user");
    defer allocator.free(path3);
    try std.testing.expectEqualStrings("/h/o/f/bar", path3);

    const path4 = try truncatePath(allocator, "/", "/home/user");
    defer allocator.free(path4);
    try std.testing.expectEqualStrings("/", path4);
}
