//
// This source file is part of the OneSecStudySpeziIntegration open source project
//
// SPDX-FileCopyrightText: 2025 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

public import SwiftUI
public import UIKit


@available(iOS 17, *) // swiftlint:disable:next attributes
@MainActor private var speziOneSec: SpeziOneSecModule.Type? {
    guard let frameworkUrl = Bundle.main.privateFrameworksURL?.appendingPathComponent("SpeziOneSec", conformingTo: .framework),
          let bundle = Bundle(url: frameworkUrl),
          bundle.load() else {
        return nil
    }
    return NSClassFromString("SpeziOneSec") as? SpeziOneSecModule.Type
}


/// Initializes the Spezi integration for the current app.
///
/// This function should be called as part of the parent app's `-[UIApplicationDelegate application:willFinishLaunchingWithOptions:]` method.
/// Once this function has returned, the ``SwiftUICore/View/spezi()`` view modifier is available and should be called on the root level of the app's view hierarchy.
///
/// - Note: If the device is running below iOS 17, this function will have no effect.
@MainActor
public func initialize(
    _ application: UIApplication,
    launchOptions: [UIApplication.LaunchOptionsKey: Any]?, // swiftlint:disable:this discouraged_optional_collection
    healthExportConfig: HealthExportConfiguration
) {
    guard #available(iOS 17, *), let speziOneSec else {
        return
    }
    speziOneSec.initialize(application: application, launchOptions: launchOptions, healthExportConfig: healthExportConfig)
}


extension View {
    /// Injects Spezi into the SwiftUI view hierarchy,
    ///
    /// - Note: This modifier should be called on the root view of the application.
    ///     If the device is running below iOS 17, this modifier will have no effect.
    @ViewBuilder
    public func spezi() -> some View {
        if #available(iOS 17, *), let speziOneSec {
            AnyView(speziOneSec.speziInjectionViewModifier.applying(to: self))
        } else {
            self
        }
    }
}


extension ViewModifier {
    fileprivate func applying(to view: some View) -> some View {
        view.modifier(self)
    }
}
