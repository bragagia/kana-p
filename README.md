# Kana-P: Lite Archlinux complete desktop

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [Intro](#intro)
- [Installation](#installation)
  - [With an AUR-helper](#with-an-aur-helper)
  - [Without AUR-helper](#without-aur-helper)
- [User Guide](#user-guide)
  - [Quick start](#quick-start)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Intro

Kana-p is a package which install and configure quickly everything you need on your Archlinux:

- Awesome WM as desktop manager (tilling)
- LightDM as login manager
- Compton as compositor
- Wi-Fi and Bluetooth working
- USB mount-on-connect
- Automatic screen managing, just connect them
- All great fonts installed
- All this comes with beautiful themes and complete configuration

![Kana-p demo](http://i.imgur.com/ScrXe7A.png)

The goal of this project is to provide an easy to install ArchLinux configuration, but also easy to modify and to understand.

Feel free to fork and publish your own version of this package and/or send a pull request.

## Installation

I recommend to install this package from a fresh install but this is not mandatory.

Just follow the [Installation guide](https://wiki.archlinux.org/index.php/Installation_guide) and start from that.

### With an AUR-helper

Simply install the **kana-p-git** package on the AUR.

Reboot and enjoy.

### Without AUR-helper

Just don't do this. There is too much AUR depencies.

## User Guide

### Quick start

Once you get on your newly installed desktop :
- Toggle the top bar : Win + D
- Run something : Win + R
- Start a terminal : Win + Enter
- Switch of desktop : Win + Right or Left arrow
- Close a window : Win + C

The top bar show a lot of thing, let's see that.

You can click on the top-left icon to show a menu with all applications and a quick way to shutdown your computer.

You can show the tray by clicking on the tiny **<** at right.

Digits at left are all your differents desktop.

Letters at right show some informations of your computer :
- w => wifi, in percentage
- d => Download rate, in megabytes per second
- u => Upload rate, in megabytes per second
- v => Volume, in percentage
- r => RAM used, in megabytes
- c => CPU used, in percentage
