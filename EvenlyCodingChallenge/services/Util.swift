//
//  Util.swift
//  EvenlyCodingChallenge
//
//  Created by Ed Negro on 27.11.18.
//  Copyright © 2018 Etienne Negro. All rights reserved.
//

import Foundation

// TODO - Needs to vanish
func parseConfig(filename: String) -> FoursquareConfig {
    let url = Bundle.main.url(forResource: filename, withExtension: "plist")!
    let data = try! Data(contentsOf: url)
    let decoder = PropertyListDecoder()
    return try! decoder.decode(FoursquareConfig.self, from: data)
}
