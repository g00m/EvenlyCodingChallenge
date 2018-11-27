//
//  ApiService.swift
//  EvenlyCodingChallenge
//
//  Created by Ed Negro on 25.11.18.
//  Copyright © 2018 Etienne Negro. All rights reserved.
//

import Foundation
import Alamofire

struct FoursquareConfig: Codable {
    let baseUrl = "https://api.foursquare.com/v2"
    var clientID: String!
    var clientSecret: String!

    enum CodingKeys: String, CodingKey {
        case baseUrl
        case clientID = "client_id"
        case clientSecret = "client_secret"
    }
    
}

protocol Api {
    func getAllPOI (_at lat: NSNumber, lng: NSNumber, limit: Int, callback: @escaping (FoursquareResponse?) -> Void)
}

class ApiService: Api {

    var config: FoursquareConfig!
    var sessionManager: SessionManager!

    init(config: FoursquareConfig, sessionManager: SessionManager) {
        self.config = config
        self.sessionManager = sessionManager
    }

    func getAllPOI(_at lat: NSNumber, lng: NSNumber, limit: Int = 100, callback: @escaping (FoursquareResponse?) -> Void) {

        let params = ["v": "20180323",
            "limit": "\(limit)",
            "client_id": config.clientID!,
            "client_secret": config.clientSecret!,
            "ll": "\(lat), \(lng)"]

        sessionManager.request("\(config.baseUrl)/venues/explore",
            parameters: params as Parameters)
            .validate(statusCode: 200..<300)
            .responseJSON { response in

                response.result.ifSuccess {

                    if let data = response.data {
                        do {
                            callback(try JSONDecoder().decode(FoursquareResponse.self, from: data))
                        } catch {
                            callback(nil)
                        }
                    }
                }

                response.result.ifFailure {
                    callback(nil)
                }

        }

    }

}
