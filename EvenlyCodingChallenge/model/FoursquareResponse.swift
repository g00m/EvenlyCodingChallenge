//
//  POI.swift
//  EvenlyCodingChallenge
//
//  Created by Ed Negro on 25.11.18.
//  Copyright © 2018 Etienne Negro. All rights reserved.
//

import Foundation

struct FoursquareResponse: Codable {
    let response: Response
    enum CodingKeys: String, CodingKey { case response }
}

struct Response: Codable {
    let groups: [Groups]
    enum CodingKeys: String, CodingKey { case groups }
}

struct Groups: Codable {
    let items: [Item]
    enum CodingKeys: String, CodingKey { case items }
}

struct Item: Codable {
    let venue: POI
    enum CodingKeys: String, CodingKey { case venue }
}

struct POI: Codable {
    let id: String
    let name: String
    let location: Location
    let categories: [Category]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case location
        case categories
    }
}

struct Location: Codable {
    let address: String
    let lat: Double
    let lng: Double
    let distance: Int
    let formattedAddress: [String]

    enum CodingKeys: String, CodingKey {
        case address
        case lat
        case lng
        case distance
        case formattedAddress
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        address = try! container.decode(String.self, forKey: .address)

        lat = try! container.decode(Double.self, forKey: .lat)
        lng = try! container.decode(Double.self, forKey: .lng)

        distance = try! container.decode(Int.self, forKey: .distance)
        formattedAddress = try! container.decode([String].self, forKey: .formattedAddress)

    }
}

struct Category: Codable {
    let name: String
    let icon: Icon

    enum CodingKeys: String, CodingKey {
        case name
        case icon
    }
}

struct Icon: Codable {
    let prefix: String
    let suffix: String

    enum CodingKeys: String, CodingKey {
        case prefix
        case suffix
    }

}
