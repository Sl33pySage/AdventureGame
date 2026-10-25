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

        // 1. TODO: prototyping UserInput function and currently working on allocator
        // a. instantiate allocator state
        var gpa = std.heap.DebugAllocator(.{}){};
        defer _ = gpa.deinit(); // Clean up the allocator when main function exits
        // b. Extract the universal 'std.mem.Allocator' interface value
        const my_allocator = gpa.allocator();
        // c. Pass the interface value to the function argument
        _ = try UserInput.runCommand(my_allocator, user_input);
        defer my_allocator.free();
        try stdout.flush();
        if (std.mem.eql(u8, "quit", user_input)) {
            game_active = false;
        }
    }
}
