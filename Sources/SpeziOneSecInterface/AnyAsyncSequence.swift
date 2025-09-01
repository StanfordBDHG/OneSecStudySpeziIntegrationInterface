//
// This source file is part of the OneSecStudySpeziIntegration open source project
//
// SPDX-FileCopyrightText: 2025 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//


//public struct AsyncIteratorSequence<Base: AsyncIteratorProtocol>: AsyncIteratorProtocol, AsyncSequence {
//    public typealias Element = Base.Element
//    @available(iOS 18.0, *)
//    public typealias Failure = Base.Failure
//    
//    @usableFromInline var base: Base
//    
//    @inlinable
//    public init(_ base: Base) {
//        self.base = base
//    }
//    
//    @inlinable
//    public func makeAsyncIterator() -> Self {
//        self
//    }
//    
//    @inlinable
//    public mutating func next() async throws -> Element? {
//        try await base.next()
//    }
//    
//    @available(iOS 18.0, *)
//    @inlinable
//    public mutating func next(isolation actor: isolated (any Actor)?) async throws(Base.Failure) -> Base.Element? {
//        try await base.next(isolation: actor)
//    }
//}


public struct AnyAsyncSequence<Element, Failure: Error>: AsyncSequence {
    @usableFromInline let makeIterator: () -> AnyAsyncIterator<Element, Failure>
    
    @available(iOS 18.0, *)
    @inlinable
    public init(_ base: some AsyncSequence<Element, Failure>) {
        makeIterator = {
            AnyAsyncIterator(base.makeAsyncIterator())
        }
    }
    
    @_disfavoredOverload
    @inlinable
    public init<S: AsyncSequence>(_ base: S) where S.Element == Element, Failure == any Error {
        makeIterator = {
            AnyAsyncIterator(base.makeAsyncIterator())
        }
    }
    
    @inlinable
    public func makeAsyncIterator() -> AnyAsyncIterator<Element, Failure> {
        makeIterator()
    }
}



public struct AnyAsyncIterator<Element, Failure: Error>: AsyncIteratorProtocol {
    @usableFromInline var base: any AsyncIteratorProtocol
    
    @_disfavoredOverload
    @inlinable
    public init<I: AsyncIteratorProtocol>(_ base: I) where I.Element == Element, Failure == any Error {
        self.base = base
    }
    
    @available(iOS 18, *)
    @inlinable
    public init(_ base: some AsyncIteratorProtocol<Element, Failure>) {
        self.base = base
    }
    
    @inlinable
    mutating public func next() async throws -> Element? {
        try await base.next() as? Element
    }
    
    @available(iOS 18.0, *)
    @inlinable
    mutating public func next(isolation actor: isolated (any Actor)?) async throws(Failure) -> Element? {
        do {
            return try await base.next(isolation: actor) as? Element
        } catch {
            throw error as! Failure
        }
    }
}


//@available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
//internal struct AnyAsyncSequence<Element>: AsyncSequence {
//    private let _makeAsyncIterator: () -> AsyncIterator
//
//    internal init<S: AsyncSequence>(wrapping sequence: S) where S.Element == Element {
//        self._makeAsyncIterator = {
//            AsyncIterator(wrapping: sequence.makeAsyncIterator())
//        }
//    }
//
//    internal func makeAsyncIterator() -> AsyncIterator {
//        self._makeAsyncIterator()
//    }
//
//    internal struct AsyncIterator: AsyncIteratorProtocol {
//        private var iterator: any AsyncIteratorProtocol
//
//        init<I: AsyncIteratorProtocol>(wrapping iterator: I) where I.Element == Element {
//            self.iterator = iterator
//        }
//
//        internal mutating func next() async throws -> Element? {
//            try await self.iterator.next() as? Element
//        }
//    }
//}
