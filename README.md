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

Interface package for the [SpeziOneSecIntegration](https://github.com/StanfordBDHG/OneSecStudySpeziIntegration) package.


## Usage

Use this package to interface with the [SpeziOneSecIntegration](https://github.com/StanfordBDHG/OneSecStudySpeziIntegration) package in pre-iOS 17 deployment targets.
It acts as a Spezi-independent wrapper around the SpeziOneSecIntegration module (which contains the actual implementation), working around the issue that a Swift package with a deployment target Y cannot be imported into an Xcode project with a deployment target X < Y.

1. In your AppDelegate's `willFinishLaunching` function: call `SpeziOneSecInterface.initialize(_:launchOptions:healthExportConfig:)`
    - If the device is running iOS 17 or newer, this function will dynamically load the SpeziOneSecIntegration package into the current process, and initialize and set up Spezi.
    - If the device is running an iOS version older than iOS 17, the function will simply do nothing.
2. Apply the `.spezi()` view modifier to the root of your SwiftUI view hierarchy (ideally directly in your `App`).
3. You now can, in SwiftUI views that have an availabilty of iOS 17+, use `@Environment(SpeziOneSecModule.self)` to access the SpeziOneSecIntegration package's implementation. See that package for more info.


## License
This project is licensed under the MIT License. See [Licenses](https://github.com/StanfordBDHG/OneSecStudySpeziIntegrationInterface/tree/main/LICENSES) for more information.


## Contributors
This project is developed as part of the Stanford Byers Center for Biodesign at Stanford University.
See [CONTRIBUTORS.md](https://github.com/StanfordBDHG/OneSecStudySpeziIntegrationInterface/tree/main/CONTRIBUTORS.md) for a full list of all contributors.

![Stanford Byers Center for Biodesign Logo](https://raw.githubusercontent.com/StanfordBDHG/.github/main/assets/biodesign-footer-light.png#gh-light-mode-only)
![Stanford Byers Center for Biodesign Logo](https://raw.githubusercontent.com/StanfordBDHG/.github/main/assets/biodesign-footer-dark.png#gh-dark-mode-only)
