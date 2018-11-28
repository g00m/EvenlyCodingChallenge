//
//  Mocks.swift
//  EvenlyCodingChallengeTests
//
//  Created by Ed Negro on 28.11.18.
//  Copyright © 2018 Etienne Negro. All rights reserved.
//

import Foundation

@testable import EvenlyCodingChallenge

class MockApiService: Api {

    func getAllPOI(_at lat: NSNumber, lng: NSNumber, limit: Int, callback: @escaping (FoursquareResponse?) -> Void) {

        let path = Bundle(for: type(of: self)).path(forResource: "fsq", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))

        callback(try! JSONDecoder().decode(FoursquareResponse.self, from: data))

    }


}
