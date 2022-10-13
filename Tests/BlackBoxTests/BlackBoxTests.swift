//
//  BlackBoxTests.swift
//  BlackBoxTests
//
//  Created by Алексей Берёзка on 01.08.2020.
//  Copyright © 2020 Dodo Pizza Engineering. All rights reserved.
//

import XCTest
@testable import BlackBox

class BlackBoxTests: XCTestCase {
    var logger: DummyLogger!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        logger = .init()
        BlackBox.instance = .init(loggers: [logger])
    }
    
    override func tearDownWithError() throws {
        logger = nil
        try super.tearDownWithError()
    }
    
    func log(
        _ message: String,
        userInfo: BBUserInfo? = nil,
        serviceInfo: BBServiceInfo? = nil,
        level: BBLogLevel = .debug,
        category: String? = nil,
        parentEvent: BlackBox.GenericEvent? = nil,
        fileID: StaticString = #fileID,
        function: StaticString = #function,
        line: UInt = #line
    ) {
        let expectation = expectation(description: "Log received")
        logger.expectation = expectation
        
        BlackBox.log(
            message,
            userInfo: userInfo,
            serviceInfo: serviceInfo,
            level: level,
            category: category,
            parentEvent: parentEvent,
            fileID: fileID,
            function: function,
            line: line
        )
        
        wait(for: [expectation], timeout: 1)
    }
    
    func log(
        _ error: Error,
        serviceInfo: BBServiceInfo? = nil,
        category: String? = nil,
        parentEvent: BlackBox.GenericEvent? = nil,
        fileID: StaticString = #fileID,
        function: StaticString = #function,
        line: UInt = #line
    ) {
        let expectation = expectation(description: "Log received")
        logger.expectation = expectation
        
        BlackBox.log(
            error,
            serviceInfo: serviceInfo,
            category: category,
            parentEvent: parentEvent,
            fileID: fileID,
            function: function,
            line: line
        )
        
        wait(for: [expectation], timeout: 1)
    }
    
    @discardableResult
    func logStart(
        _ message: String,
        userInfo: BBUserInfo? = nil,
        serviceInfo: BBServiceInfo? = nil,
        level: BBLogLevel = .debug,
        category: String? = nil,
        parentEvent: BlackBox.GenericEvent? = nil,
        fileID: StaticString = #fileID,
        function: StaticString = #function,
        line: UInt = #line
    ) -> BlackBox.StartEvent {
        let expectation = expectation(description: "Log received")
        logger.expectation = expectation
        
        let event = BlackBox.logStart(
            message,
            userInfo: userInfo,
            serviceInfo: serviceInfo,
            level: level,
            category: category,
            parentEvent: parentEvent,
            fileID: fileID,
            function: function,
            line: line
        )
        
        wait(for: [expectation], timeout: 1)
        return event
    }
    
    func logStart(
        _ event: BlackBox.StartEvent
    ) {
        let expectation = expectation(description: "Log received")
        logger.expectation = expectation
        
        BlackBox.logStart(
            event
        )
        
        wait(for: [expectation], timeout: 1)
    }
    
    func logEnd(
        _ event: BlackBox.StartEvent,
        message: String? = nil,
        userInfo: BBUserInfo? = nil,
        serviceInfo: BBServiceInfo? = nil,
        category: String? = nil,
        parentEvent: BlackBox.GenericEvent? = nil,
        fileID: StaticString = #fileID,
        function: StaticString = #function,
        line: UInt = #line
    ) {
        let expectation = expectation(description: "Log received")
        logger.expectation = expectation
        
        BlackBox.logEnd(
            event,
            message: message,
            userInfo: userInfo,
            serviceInfo: serviceInfo,
            category: category,
            parentEvent: parentEvent,
            fileID: fileID,
            function: function,
            line: line
        )
        
        wait(for: [expectation], timeout: 1)
    }
}
