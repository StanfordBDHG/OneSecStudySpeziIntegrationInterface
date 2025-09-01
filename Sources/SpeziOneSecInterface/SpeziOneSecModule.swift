//
// This source file is part of the OneSecStudySpeziIntegration open source project
//
// SPDX-FileCopyrightText: 2025 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

// swiftlint:disable unavailable_function file_types_order

public import HealthKit
public import SwiftUI
public import UIKit


/// The Spezi integration for the one sec app.
///
/// ## Topics
///
/// ### Instance Properties
/// - ``state``
/// - ``surveyUrl``
/// - ``didStartHealthExport``
///
/// ### Instance Methods
/// - ``makeSpeziOneSecSheet()``
@available(iOS 17, *)
@Observable
@MainActor
open class SpeziOneSecModule: NSObject, Sendable {
    public enum State: Int, Hashable, Codable, Sendable {
        /// The Spezi one sec integration is, for whatever reason, not available.
        case unavailable
        /// The Spezi one sec integration is available, but hasn't yet been initiated.
        case available
        /// The Spezi one sec integration is currently being initiated.
        case initiating
        /// The Spezi one sec integration is currently active.
        case active
        /// The Spezi one sec integration has been completed.
        case completed
    }
    
    /// The `ViewModifier` that integrates Spezi and SpeziOneSec into the SwiftUI view hierarchy
    @_spi(APISupport) // swiftlint:disable:next attributes
    open class var speziInjectionViewModifier: any ViewModifier {
        fatalError("implemented in SpeziOneSec")
    }
    
    /// The URL of the survey the user should fill out in order to enroll in the study.
    ///
    /// This URL should be constructed by the app, based on the survey and the token obtained from REDCap.
    public var surveyUrl: URL?
    
    /// Callback that will be invoked by SpeziOneSec when starting a health export.
    ///
    /// - parameter exportedFiles: An `AsyncSequence` that will yield the `URL`s of the individual export batch files.
    ///     Note that this parameter's `Failure` type will likely be changed to `Never` in a future release.
    public var didStartHealthExport: (@MainActor @Sendable (_ exportedFiles: AnyAsyncSequence<URL, any Error>) -> Void)?
    
    /// The current state of the integration.
    public private(set) var state: State = .unavailable
    
    @_documentation(visibility: internal)
    override public nonisolated init() {}
    
    @_spi(APISupport)
    open class func initialize(
        application: UIApplication,
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?, // swiftlint:disable:this discouraged_optional_collection
        healthExportConfig: HealthExportConfiguration
    ) {
        fatalError("implemented in SpeziOneSec")
    }
    
    open func makeSpeziOneSecSheet() -> AnyView {
        fatalError("implemented in SpeziOneSec")
    }
    
    @_spi(APISupport)
    open func updateState(_ newState: State) {
        state = newState
    }
}


public struct HealthExportConfiguration: Hashable, Sendable {
    public let destination: URL
    public let sampleTypes: Set<HKObjectType>
    public let timeRange: Range<Date>
    
    /// - parameter destination: Directory to which the Health export files should be written.
    public init(destination: URL, sampleTypes: Set<HKObjectType>, timeRange: Range<Date>) {
        self.destination = destination
        self.sampleTypes = sampleTypes
        self.timeRange = timeRange
    }
}
