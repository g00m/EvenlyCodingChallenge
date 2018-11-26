//
//  POITableViewController.swift
//  EvenlyCodingChallenge
//
//  Created by Ed Negro on 25.11.18.
//  Copyright © 2018 Etienne Negro. All rights reserved.
//

import UIKit
import Alamofire

class POITableViewController: UITableViewController {

    private var dataSource: POITableViewDatasource<UITableViewCell, Items>!
    private var viewModel: POIViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = POIViewModel(apiService: ApiService(
            config: parseConfig(filename: "Config"),
            sessionManager: SessionManager()),
            updateListener: {

                self.dataSource = POITableViewDatasource(cellIdentifier: "Cell",
                    items: self.viewModel.items,
                    configureCell: { cell, model in
                        cell.textLabel?.text = model.venue.name
                    })

                self.tableView.dataSource = self.dataSource
                self.tableView.reloadData()

            })

    }

    // TODO - Needs to vanish
    func parseConfig(filename: String) -> FoursquareConfig {
        let url = Bundle.main.url(forResource: filename, withExtension: "plist")!
        let data = try! Data(contentsOf: url)
        let decoder = PropertyListDecoder()
        return try! decoder.decode(FoursquareConfig.self, from: data)
    }

}
