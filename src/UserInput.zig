const std = @import("std");
const Io = std.Io;

const AdventureGame = @import("AdventureGame");

pub fn runCommand(inputstr: []const u8) void {
    // const s = "ok";

    for (inputstr) |letter| {
        const lowerletter = std.ascii.toLower(letter);
        if (std.ascii.isWhitespace(lowerletter)) {
            continue;
        }
        std.debug.print("{c}\n", .{lowerletter});
    }
}
