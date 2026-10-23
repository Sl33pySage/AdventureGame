const std = @import("std");
const Io = std.Io;

const AdventureGame = @import("AdventureGame");

pub fn runCommand(allocator: std.mem.Allocator, inputstr: []const u8) ![]const u8 {
    // var s = "ok";
    // var wordList: []const u8 = undefined;
    const trimmed = std.mem.trim(u8, inputstr, " \t\n\r");

    const lowstr = try std.ascii.allocLowerString(allocator, trimmed);
    defer allocator.free(lowstr);
    if (!std.ascii.eqlIgnoreCase(trimmed, "q")) {
        if (trimmed.len == 0) {
            std.debug.print("You Must Enter A Command!\n", .{});
        } else {
            // 1. TODO: Eventually call WordList() and parseCommand()
            std.debug.print("Ready to Parse Command: {s}\n", .{trimmed});
        }
    }
}
