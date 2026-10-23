const std = @import("std");
const Io = std.Io;

const AdventureGame = @import("AdventureGame");

pub fn runCommand(inputstr: []const u8) void {
    // var s = "ok";
    // var wordList: []const u8 = undefined;
    const trimmed = std.mem.trim(u8, inputstr, " \t\n\r");
    //std.debug.print("trimmed: '{s}'\n", .{trimmed});

    if (!std.ascii.eqlIgnoreCase(trimmed, "q")) {
        if (trimmed.len == 0) {
            std.debug.print("You Must Enter A Command!\n", .{});
        } else {
            std.debug.print("Ready to Parse Command: {s}\n", .{trimmed});
        }
    }
}
