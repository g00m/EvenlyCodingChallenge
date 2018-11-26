//
//  ApiTests.swift
//  EvenlyCodingChallengeTests
//
//  Created by Ed Negro on 25.11.18.
//  Copyright © 2018 Etienne Negro. All rights reserved.
//

import XCTest
import UIKit
import Alamofire

@testable import EvenlyCodingChallenge

class ApiTests: XCTestCase {

    var apiService: ApiService!
    var networkRequestExpectation: XCTestExpectation!

    override func setUp() {
        let config = parseConfig()
        
        apiService = ApiService(
            config: config,
            sessionManager: SessionManager())
    }
    
    func parseConfig() -> FoursquareConfig {
        let url = Bundle.main.url(forResource: "Config", withExtension: "plist")!
        let data = try! Data(contentsOf: url)
        let decoder = PropertyListDecoder()
        return try! decoder.decode(FoursquareConfig.self, from: data)
    }
    
    func testNetworkRequest() {
    
        networkRequestExpectation = self.expectation(description: "fetch poi")

        apiService.getAllPOI(_at: 52.500342, lng: 13.425170, limit: 1) { fsqResponse in

            if fsqResponse != nil && fsqResponse?.response.groups[0].items.count == 1 {
                self.networkRequestExpectation.fulfill()
            } 
        }

        wait(for: [networkRequestExpectation], timeout: 5)
    }
    
    // TODO - Create more tests with for example mocked connections

}
