//
//  BlackBoxTests+ErrorEvent.swift
//  
//
//  Created by Aleksey Berezka on 13.10.2022.
//

import XCTest
@testable import BlackBox

class BlackBoxTests_ErrorEvent: BlackBoxTests {
    func test_errorLog_error() {
        log(AnakinKills.maceWindu)
        XCTAssertEqual(logger.errorEvent?.error as? AnakinKills, AnakinKills.maceWindu)
    }
    
    func test_errorLog_message() {
        log(AnakinKills.maceWindu)
        XCTAssertEqual(logger.errorEvent?.message, "BlackBoxTests.AnakinKills.maceWindu")
    }
    
    func test_errorLog_messageOfErrorWithAssociatedValue() {
        log(AnakinKills.younglings(count: 12))
        XCTAssertEqual(logger.errorEvent?.message, "BlackBoxTests.AnakinKills.younglings(count: 12)")
    }
    
    func test_errorLog_userInfo() {
        log(AnakinKills.younglings(count: 11))
        XCTAssertEqual(logger.errorEvent?.userInfo as? [String: Int], ["count": 11])
    }
    
    func test_errorLog_serviceInfo() {
        log(AnakinKills.maceWindu, serviceInfo: Lightsaber(color: "purple"))
        XCTAssertEqual(logger.errorEvent?.serviceInfo as? Lightsaber, Lightsaber(color: "purple"))
    }
    
    func test_errorLog_defaultLevel() {
        log(AnakinKills.maceWindu)
        XCTAssertEqual(logger.errorEvent?.level, .error)
    }
    
    func test_errorLog_category() {
        log(AnakinKills.maceWindu, category: "Analytics")
        XCTAssertEqual(logger.errorEvent?.category, "Analytics")
    }
    
    func test_errorLog_parentEvent() {
        let parentEvent = BlackBox.GenericEvent("Test")
        log(AnakinKills.maceWindu, parentEvent: parentEvent)
        XCTAssertEqual(logger.errorEvent?.parentEvent, parentEvent)
    }
    
    func test_errorLog_fileID() {
        log(AnakinKills.maceWindu)
        XCTAssertEqual(logger.errorEvent?.source.fileID.description, "BlackBoxTests/BlackBoxTests+ErrorEvent.swift")
    }
    
    func test_errorLog_module() {
        log(AnakinKills.maceWindu)
        XCTAssertEqual(logger.errorEvent?.source.module, "BlackBoxTests")
    }
    
    func test_errorLog_filename() {
        log(AnakinKills.maceWindu)
        XCTAssertEqual(logger.errorEvent?.source.filename, "BlackBoxTests+ErrorEvent")
    }
    
    func test_errorLog_function() {
        log(AnakinKills.maceWindu)
        XCTAssertEqual(logger.errorEvent?.source.function.description, "test_errorLog_function()")
    }
    
    func test_errorLog_line() {
        log(AnakinKills.maceWindu)
        XCTAssertEqual(logger.errorEvent?.source.line, 69)
    }
}