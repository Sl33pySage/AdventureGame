const std = @import("std");
const Io = std.Io;

const AdventureGame = @import("AdventureGame");
const UserInput = @import("UserInput.zig");

pub fn main(init: std.process.Init) !void {
    // 1. Initialize stdout/stdin using the new 0.15 process context
    var stdout_buffer: [1024]u8 = undefined;
    var stdout_writer = std.Io.File.stdout().writer(init.io, &stdout_buffer);
    const stdout = &stdout_writer.interface;

    var stdin_buffer: [1024]u8 = undefined;
    var stdin_reader = std.Io.File.stdin().reader(init.io, &stdin_buffer);
    const stdin = &stdin_reader.interface;

    var game_active = true;

    while (game_active) {
        // Flush macro ensures prompt prints before blocking for input
        try stdout.print("> ", .{});
        try stdout.flush();

        // 2. Read input up to the newline delimiter
        // Use takeDelimiter to safely advance past the newline for subsequent reads
        const raw_input = try stdin.takeDelimiter('\n') orelse return;

        // 3. Clean up Windows carriage returns (\r\r -> \n)
        const user_input: []const u8 = std.mem.trimEnd(u8, raw_input, "\r");

        // 4. Output the result
        try stdout.print("You entered '{s}'\n", .{user_input});
        try stdout.flush();

        // TODO: trying to figure out the allocator
        // 1. Initialize testAllocator
        var gpa = std.heap.DebugAllocator(.{}){};

        // 2. Get the allocator interface from interface
        const allocator = gpa.allocator();

        // 3. This checks for and prints memeory leaks when main exits
        defer {
            const check = gpa.deinit();
            if (check == .leak) {
                std.debug.print("Memory leak detected!\n", .{});
            }
        }

        // 4. Pass allocator to UserInput function
        const result = try UserInput.runCommand(allocator, user_input);
        std.debug.print("Result: {s}\n", .{result});
        if (std.mem.eql(u8, "quit", user_input)) {
            game_active = false;
        }
    }
}
