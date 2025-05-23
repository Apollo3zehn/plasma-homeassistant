> [!NOTE]
> This is a fork of https://github.com/korapp/plasma-homeassistant with added functionality to make it more configurable so the Plasmoid can be placed in horizontal and vertical panels as well as on the desktop.

# Home Assistant Plasmoid (Fork)

[![plasma](https://img.shields.io/static/v1?message=KDE%20Store&color=54a3d8&logo=kde&logoColor=FFFFFF&label=)][kdestore]
[![downloads](https://img.shields.io/github/downloads/korapp/plasma-homeassistant/total)][releases]
[![release](https://img.shields.io/github/v/release/korapp/plasma-homeassistant)][releases]

Add Home Assistant to your plasma desktop.

![Plasmoid preview](preview.jpg)

## Features

* Show entity state or attribute
* Call services
* Notify about entity changes

## Use

1. Enter the URL of the Home Assistant instance
2. Create Long Lived Access Token on your Home Assistant Profile page (https://<your_ha_address>/profile) and put it in the plasmoid configuration
3. Add entities

## Requirements

* Active KDE Wallet
* KDE Plasma >= 6.0
* Home Assistant >= 2022.4
* **Qt WebSocket package installed**
  
  Base | Required package
  --|--
  Debian, Ubuntu | qml6-module-qtwebsockets
  Arch | qt6-websockets
  Fedora | qt6-qtwebsockets-devel
  openSUSE | qt6-websockets-imports
  NixOS | kdePackages.qtwebsockets

  **Please remember to restart plasma or re-login after installing the dependency.**

## Installation

**The preferred and easiest way to install is to use Plasma Discover or KDE Get New Stuff and search for *Home Assistant*.**

### From file

Download the latest version of plasmoid from [KDE Store][kdestore]

#### A) Plasma UI

1. Right click on panel or desktop
2. Select *Add Widgets > Get New Widgets > Install From Local File*
3. Choose downloaded plasmoid file

#### B) Terminal

```sh
plasmapkg2 -i plasma-homeassistant-*.plasmoid
```

### From GitHub

Clone repository and go to the project directory

```sh
git clone --recurse-submodules https://github.com/korapp/plasma-homeassistant.git
cd plasma-homeassistant
```

Install

```sh
plasmapkg2 -i package
```

## Support

Say thank you with coffee ☕ if you'd like.

[![liberapay](https://liberapay.com/assets/widgets/donate.svg)](https://liberapay.com/korapp/donate)
[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/korapp)
[<img src="https://img.shields.io/static/v1?message=Revolut&color=FFFFFF&logo=Revolut&logoColor=000000&label=" height="30"/>](https://revolut.me/korapp)

[kdestore]: https://store.kde.org/p/2131364/
[releases]: https://github.com/korapp/plasma-homeassistant/releases
