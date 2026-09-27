const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "myapp",

        .root_module = b.createModule(.{
            .target = target,
            .optimize = optimize,

            // C/C++ runtime libraries
            .link_libc = true,
            .link_libcpp = true,
        }),
    });

    exe.root_module.addCSourceFiles(.{
        .root = b.path("src"),
        .files = &.{
            "main.cpp",
            "foo.cpp",
        },
        .flags = &.{
            "-std=c++23",
            "-Wall",
            "-Wextra",
        },
    });

    exe.root_module.addIncludePath(b.path("include"));

    b.installArtifact(exe);
}
