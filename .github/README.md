# ![logo](https://community.trinitycore.org/public/style_images/1_trinitycore.png) TrinityCore (master)

[![Average time to resolve an issue](https://isitmaintained.com/badge/resolution/TrinityCore/TrinityCore.svg)](https://isitmaintained.com/project/TrinityCore/TrinityCore "Average time to resolve an issue") [![Percentage of issues still open](https://isitmaintained.com/badge/open/TrinityCore/TrinityCore.svg)](https://isitmaintained.com/project/TrinityCore/TrinityCore "Percentage of issues still open")

--------------


* [Build Status](#build-status)
* [Introduction](#introduction)
* [Requirements](#requirements)
* [Install](#install)
* [Reporting issues](#reporting-issues)
* [Submitting fixes](#submitting-fixes)
* [Copyright](#copyright)
* [Authors &amp; Contributors](#authors--contributors)
* [Links](#links)



## Estado de construcción

7.3.5 | 
:------------:
[![master Build Status](https://circleci.com/gh/TrinityCore/TrinityCore/tree/master.svg?style=shield)](https://circleci.com/gh/TrinityCore/TrinityCore/tree/master) | [![3.3.5 Build Status](https://circleci.com/gh/TrinityCore/TrinityCore/tree/3.3.5.svg?style=shield)](https://circleci.com/gh/TrinityCore/TrinityCore/tree/3.3.5) | [![wotlk_classic Build Status](https://circleci.com/gh/TrinityCore/TrinityCore/tree/wotlk_classic.svg?style=shield)](https://circleci.com/gh/TrinityCore/TrinityCore/tree/wotlk_classic)
[![master Build status](https://ci.appveyor.com/api/projects/status/54d0u1fxe50ad80o/branch/master?svg=true)](https://ci.appveyor.com/project/DDuarte/trinitycore/branch/master) | [![Build status](https://ci.appveyor.com/api/projects/status/54d0u1fxe50ad80o/branch/3.3.5?svg=true)](https://ci.appveyor.com/project/DDuarte/trinitycore/branch/3.3.5) | [![Build status](https://ci.appveyor.com/api/projects/status/54d0u1fxe50ad80o/branch/wotlk_classic?svg=true)](https://ci.appveyor.com/project/DDuarte/trinitycore/branch/wotlk_classic)
[![master GCC Build status](https://github.com/TrinityCore/TrinityCore/actions/workflows/gcc-build.yml/badge.svg?branch=master&event=push)](https://github.com/TrinityCore/TrinityCore/actions?query=workflow%3AGCC+branch%3Amaster+event%3Apush) | [![3.3.5 GCC Build status](https://github.com/TrinityCore/TrinityCore/actions/workflows/gcc-build.yml/badge.svg?branch=3.3.5&event=push)](https://github.com/TrinityCore/TrinityCore/actions?query=workflow%3AGCC+branch%3A3.3.5+event%3Apush) | [![wotlk_classic GCC Build status](https://github.com/TrinityCore/TrinityCore/actions/workflows/gcc-build.yml/badge.svg?branch=wotlk_classic&event=push)](https://github.com/TrinityCore/TrinityCore/actions?query=workflow%3AGCC+branch%3Awotlk_classic+event%3Apush)
[![master macOS arm64 Build status](https://github.com/TrinityCore/TrinityCore/actions/workflows/macos-arm-build.yml/badge.svg?branch=master&event=push)](https://github.com/TrinityCore/TrinityCore/actions?query=workflow%3AGCC+branch%3Amaster+event%3Apush) | | 

## Introducción

ThunderCore es una aplicacion y un marco de servidor de juegos de codigo abierto diseñado para alojar juegos de rol multijugador masivos en linea (MMORPG). Esta bado en el popular MMORPG World of Warcraft (WoW) y busca recrear la experiencia de juego del juego original a partir del parche 3.3.5a.

El codigo original se basa en AzerothCore, TrinityCore y SunwellCore y desde entonces ha tenido un desarrollo extenso para mejorar la estabilidad, la mecanica del juego y la modularidad del mismo. TC tambien se ha convertido en un proyecto impulsado por la comunidad con una cantidad significativa de colaboradores y desarrolladores. Esta escrito en C++ y proporciona una base salida para crear servidores privados que imitan la mecanica y el comportamiento de los servidores oficiales de WoW.


## Requirementos
* Microsoft Visual Studio 2017 x64
* Boost 1.64
* Open SSL 1.0
* CMake
* Git
* Github Desktop
* MySQL Server 5.1-8.3

## Install

Detailed installation guides are available in the [wiki](https://trinitycore.info/en/home) for
Windows, Linux and macOS.


## Reporte de problemas

Issues can be reported via the [Github issue tracker](https://github.com/TrinityCore/TrinityCore/labels/Branch-master).

Please take the time to review existing issues before submitting your own to
prevent duplicates.

In addition, thoroughly read through the [issue tracker guide](https://community.trinitycore.org/topic/37-the-trinitycore-issuetracker-and-you/) to ensure
your report contains the required information. Incorrect or poorly formed
reports are wasteful and are subject to deletion.


## Submitting fixes

C++ fixes are submitted as pull requests via Github. For more information on how to
properly submit a pull request, read the [how-to: maintain a remote fork](https://community.trinitycore.org/topic/9002-howto-maintain-a-remote-fork-for-pull-requests-tortoisegit/).
For SQL only fixes, open a ticket; if a bug report exists for the bug, post on an existing ticket.


## Copyright

License: GPL 2.0

Read file [COPYING](COPYING).


## Authors &amp; Contributors

Read file [AUTHORS](AUTHORS).


## Links

* [Website](https://www.trinitycore.org)
* [Wiki](https://www.trinitycore.info)
* [Forums](https://talk.trinitycore.org/)
* [Discord](https://discord.trinitycore.org/)
