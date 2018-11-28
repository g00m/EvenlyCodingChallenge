//
//  ViewModelTest.swift
//  EvenlyCodingChallengeTests
//
//  Created by Ed Negro on 28.11.18.
//  Copyright © 2018 Etienne Negro. All rights reserved.
//

import XCTest

@testable import EvenlyCodingChallenge

class ViewModelTest: XCTestCase {

    var mockApiService: Api!
    var viewModelToTest: POIViewModel!

    var reloadTableViewExpectation: XCTestExpectation!

    override func setUp() {
        reloadTableViewExpectation = self.expectation(description: "reload tableview")

        mockApiService = MockApiService()
        viewModelToTest = POIViewModel(apiService: mockApiService) {
            self.reloadTableViewExpectation.fulfill()
        }

        wait(for: [reloadTableViewExpectation], timeout: 5)

    }

    func testItemCount() {
        XCTAssert(viewModelToTest.items.count == 1)
    }

    func testItemAtRow() {
        let item = viewModelToTest.getItemAtRow(_atRow: 0)

        XCTAssertEqual(item.venue.name, "Biererei")
        XCTAssertEqual(item.venue.categories[0].name, "Beer Store")
        XCTAssertEqual(item.venue.categories[0].icon.prefix, "https://ss3.4sqi.net/img/categories_v2/nightlife/beergarden_")
        XCTAssertEqual(item.venue.categories[0].icon.suffix, ".png")

        XCTAssertEqual(item.venue.location.address, "Oranienstr. 19")
        XCTAssertEqual(item.venue.location.lat, 52.500465522175624)
        XCTAssertEqual(item.venue.location.lng, 13.422283312417841)
        XCTAssertEqual(item.venue.location.distance, 196)

        XCTAssertEqual(item.venue.location.formattedAddress[0], "Oranienstr. 19")
        XCTAssertEqual(item.venue.location.formattedAddress[1], "10999 Berlin")
        XCTAssertEqual(item.venue.location.formattedAddress[2], "Deutschland")

    }

}
