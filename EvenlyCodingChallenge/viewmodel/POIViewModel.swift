//
//  File.swift
//  EvenlyCodingChallenge
//
//  Created by Ed Negro on 26.11.18.
//  Copyright © 2018 Etienne Negro. All rights reserved.
//

import UIKit

class POIViewModel {
    typealias Listener = () -> ()

    private let updateListener: Listener
    private let apiService: ApiService

    private (set) var items: [Item] = [Item]()

    init(apiService: ApiService, updateListener: @escaping Listener) {
        self.apiService = apiService
        self.updateListener = updateListener
        self.getPOIFromApi()
    }

    func getPOIFromApi () {
        apiService.getAllPOI(_at: 52.500342, lng: 13.425170, limit: 30) { fsqResponse in
            guard fsqResponse != nil else { return }
            self.items = fsqResponse!.response.groups[0].items

            self.items.sort(by: {
                $0.venue.location.distance < $1.venue.location.distance
            })

            self.updateListener()
        }
    }

    func getItemAtRow(_atRow row: Int) -> Item {
        return self.items[row]
    }
}
