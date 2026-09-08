{ lib, pkgs, profile, ... }:
{
  home.packages =
    lib.optionals profile.dev.devTools (with pkgs; [
      gnumake
      ripgrep
      fd
    ])
    ++ lib.optionals profile.dev.pythonDev (with pkgs; [
      uv
      (python314.withPackages (ps: with ps; [
        pip
        virtualenv
        pytest
        ipython
        debugpy
        pydantic
        pygame
        mypy
        flake8
      ]))
      ruff
      pyright
      black
    ])
    ++ lib.optionals profile.dev.goDev (with pkgs; [
      go
      gopls
      gotools
    ])
    ++ lib.optionals profile.dev.guiDev (with pkgs; [
      libGL
      libX11
      libXcursor
      libXrandr
      libXinerama
      libXi
      libXext
      libXxf86vm
    ])
    ++ lib.optionals profile.dev.cDev (with pkgs; [
      gcc
      glib
      glibc.dev
      stdenv.cc.cc.lib
      gdb
      valgrind
      norminette
      lldb
      bear
      man-pages
      man-pages-posix
      SDL2
      SDL2_mixer
      SDL2_image
      SDL2_ttf
      pkg-config
    ]);
}