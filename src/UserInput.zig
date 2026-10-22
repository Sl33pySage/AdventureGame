const std = @import("std");
const Io = std.Io;

const AdventureGame = @import("AdventureGame");

pub fn runCommand(inputstr: []const u8) void {
    // var s = "ok";
    const trimmed = std.mem.trim(u8, inputstr, " \t\n\r");
    std.debug.print("trimmed: '{s}'\n", .{trimmed});

    for (trimmed) |letter| {
        const lowerletter = std.ascii.toLower(letter);
        if (std.ascii.isWhitespace(lowerletter)) {
            continue;
        }
        // if (letter != 'q') {
        // if (trimmed == '') {
        // std.debug.print("You Must Enter A Command!\n", .{});
        //}
        //}
        std.debug.print("lowerletter: {c}\n", .{lowerletter});
    }
}
