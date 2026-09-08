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
      libglvnd.dev
      libx11.dev
      libxcursor.dev
      libxrandr.dev
      libxinerama.dev
      libxi.dev
      libxext.dev
      libxxf86vm.dev
      libxrender.dev
      libxfixes.dev
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

  home.sessionVariables = lib.optionalAttrs profile.dev.guiDev (let
    guiDevPkgs = with pkgs; [
      libglvnd.dev libx11.dev libxcursor.dev libxrandr.dev
      libxinerama.dev libxi.dev libxext.dev libxxf86vm.dev xorgproto
      libxrender.dev libxfixes.dev
    ];
  in {
    PKG_CONFIG_PATH = lib.concatMapStringsSep ":"
      (p: "${p}/lib/pkgconfig:${p}/share/pkgconfig") guiDevPkgs
      + ":$PKG_CONFIG_PATH";
    CPATH = lib.concatMapStringsSep ":" (p: "${p}/include") guiDevPkgs
      + ":$CPATH";
    LIBRARY_PATH = lib.concatMapStringsSep ":" (p: "${p}/lib") guiDevPkgs
      + ":$LIBRARY_PATH";
  });
}