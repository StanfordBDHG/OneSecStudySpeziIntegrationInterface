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
///
/// ### Instance Methods
/// - ``makeSpeziOneSecSheet()``
@available(iOS 17, *)
@Observable
@MainActor
open class SpeziOneSecModule: NSObject, Sendable {
    public enum State: Int, Hashable, Codable, Sendable {
        /// The study is not available for this user.
        /// This may occur if the user has been deemed ineligible (e.g., underage)
        /// based on information from a previous survey attempt or other eligibility criteria.
        case unavailable
        /// The study is available but has not yet been initiated.
        case available
        /// The study was started by the participant, but they indicated being underage.
        /// The study is currently on hold until a parent or guardian provides consent.
        case awaitingParentalConsent
        /// The study is currently active.
        case active
        /// The study has been completed.
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
    
    @_spi(APISupport)
    open func triggerHealthExport(forceSessionReset: Bool) async throws {
        fatalError("implemented in SpeziOneSec")
    }
}


public struct HealthExportConfiguration: Sendable {
    /// Callback that lets the app know that a health export was started.
    ///
    /// - parameter files: An `AsyncSequence` that will yield the `URL`s of the local files created from the individual export batches.
    public typealias DidStartExport = @Sendable @MainActor (_ files: AnyAsyncSequence<URL, Never>) -> Void
    
    /// Directory to which the Health export files should be written.
    public let destination: URL
    /// The sample types that should be included in the export.
    public let sampleTypes: Set<HKObjectType>
    /// The time range for which health samples should be exported.
    public let timeRange: Range<Date>
    /// Callback that will be invoked when a health export is started.
    public let didStartExport: DidStartExport
    
    /// Create a new Health Export Configuration.
    public init(
        destination: URL,
        sampleTypes: Set<HKObjectType>,
        timeRange: Range<Date>,
        didStartExport: @escaping DidStartExport
    ) {
        self.destination = destination
        self.sampleTypes = sampleTypes
        self.timeRange = timeRange
        self.didStartExport = didStartExport
    }
}
