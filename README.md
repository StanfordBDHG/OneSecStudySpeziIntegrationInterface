<!--
                  
This source file is part of the SpeziOneSecIntegration open source project

SPDX-FileCopyrightText: 2025 Stanford University and the project authors (see CONTRIBUTORS.md)

SPDX-License-Identifier: MIT
             
-->

# SpeziOneSecIntegrationInterface

[![Build and Test](https://github.com/StanfordBDHG/OneSecStudySpeziIntegrationInterface/actions/workflows/build-and-test.yml/badge.svg)](https://github.com/StanfordBDHG/OneSecStudySpeziIntegrationInterface/actions/workflows/build-and-test.yml)
[![codecov](https://codecov.io/gh/StanfordBDHG/OneSecStudySpeziIntegrationInterface/branch/main/graph/badge.svg?token=X7BQYSUKOH)](https://codecov.io/gh/StanfordBDHG/OneSecStudySpeziIntegrationInterface)
[![DOI](https://zenodo.org/badge/573230182.svg)](https://zenodo.org/badge/latestdoi/573230182)
<!-- [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FStanfordBDHG%2FOneSecStudySpeziIntegrationInterface%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/StanfordBDHG/OneSecStudySpeziIntegrationInterface)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FStanfordBDHG%2FOneSecStudySpeziIntegrationInterface%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/StanfordBDHG/OneSecStudySpeziIntegrationInterface) -->

Interface for the [SpeziOneSecIntegration](https://github.com/StanfordBDHG/OneSecStudySpeziIntegration) package.


## Overview

This Swift package implements the interface of the Stanford Spezi integration for the one sec app's Digital Interventions Outcome study.


### Project Structure

In order to support an overall deployment target of iOS 15, this project needs to be split up into 2 separate Swift packages:
- [SpeziOneSecIntegrationInterface](https://github.com/StanfordBDHG/OneSecStudySpeziIntegrationInterface) (this package)
    - package deployment target: iOS 15
    - defines the interface of the integration
    - the app defines a dependency on this package, and adds it to its "link binary with libraries" build phase in Xcode
    - on launch, the app calls this package's `initialize` function, which, if possible, will dynamically
- [SpeziOneSecIntegration](https://github.com/StanfordBDHG/OneSecStudySpeziIntegration)
    - package deployment target: iOS 17
    - implements the interface defined in SpeziOneSecIntegrationInterface
    - the app defines a dependency on this package, but does not add it to its "link binary with libraries" build phase
    - instead, the app should add the "SpeziOneSec" target to its "target dependencies" and its "embed frameworks" build phases
    - this ensures that the package won't get linked automatically, which would crash on pre-iOS 17 devices
    - the app never directly imports this package; instead, all interactions with it go through the interface package


### Usage

Use this package to interface with the [SpeziOneSecIntegration](https://github.com/StanfordBDHG/OneSecStudySpeziIntegration) package in pre-iOS 17 deployment targets.
It acts as a Spezi-independent wrapper around the SpeziOneSecIntegration module (which contains the actual implementation), working around the issue that a Swift package with a deployment target Y cannot be imported into an Xcode project with a deployment target X < Y.

1. In your AppDelegate's `willFinishLaunching` function: call `SpeziOneSecInterface.initialize(_:launchOptions:healthExportConfig:)`
    - If the device is running iOS 17 or newer, this function will dynamically load the SpeziOneSecIntegration package into the current process, and initialize and set up Spezi.
    - If the device is running an iOS version older than iOS 17, the function will simply do nothing.
2. Apply the `.spezi()` view modifier to the root of your SwiftUI view hierarchy (ideally directly in your `App`).
3. You now can, in SwiftUI views that have an availabilty of iOS 17+, use `@Environment(SpeziOneSecModule.self)` to access the SpeziOneSecIntegration package's implementation. See that package for more info.


## Contributing

Contributions to this project are welcome. Please make sure to read the [contribution guidelines](https://github.com/StanfordBDHG/.github/blob/main/CONTRIBUTING.md) and the [contributor covenant code of conduct](https://github.com/StanfordBDHG/.github/blob/main/CODE_OF_CONDUCT.md) first.


## License
This project is licensed under the MIT License. See [Licenses](https://github.com/StanfordBDHG/OneSecStudySpeziIntegrationInterface/tree/main/LICENSES) for more information.

![Spezi Footer](https://raw.githubusercontent.com/StanfordSpezi/.github/main/assets/FooterLight.png#gh-light-mode-only)
![Spezi Footer](https://raw.githubusercontent.com/StanfordSpezi/.github/main/assets/FooterDark.png#gh-dark-mode-only)
