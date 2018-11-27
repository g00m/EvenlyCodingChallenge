//
//  POITableViewController.swift
//  EvenlyCodingChallenge
//
//  Created by Ed Negro on 25.11.18.
//  Copyright © 2018 Etienne Negro. All rights reserved.
//

import UIKit
import Alamofire
import MapKit

class POITableViewController: UITableViewController {

    private var dataSource: POITableViewDatasource<UITableViewCell, Item>!
    private var delegate: POITableViewDelegate!

    private var viewModel: POIViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel = POIViewModel(apiService: ApiService(
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

        self.delegate = POITableViewDelegate { row in
            self.showActionSheet(_forItem: self.viewModel.getItemAtRow(_atRow: row))
        }
        self.tableView.delegate = self.delegate

    }

    private func showActionSheet (_forItem item: Item) {
        let alert = UIAlertController(title: item.venue.name,
            message: nil,
            preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Share POI", style: .default) { UIAlertAction in
                self.showShareSheet(_forItem: item)
            })

        alert.addAction(UIAlertAction(title: "Open in Maps", style: .default) { UIAlertAction in
                self.openMaps(_forItem: item)
            })

        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)

    }

    private func showShareSheet(_forItem item: Item) {
        
        let headline = "Check out this awesome place it is called \(item.venue.name)\n\n"

        if let fsqLink = NSURL(string: "https://foursquare.com/v/\(item.venue.id)") {
            let activityVC = UIActivityViewController(activityItems: [headline, fsqLink],
                                                      applicationActivities: nil)

            self.present(activityVC, animated: true, completion: nil)
        }
    }

    func openMaps(_forItem item: Item) {
        let coordinate = CLLocationCoordinate2DMake(item.venue.location.lat,
            item.venue.location.lng)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: nil))
        mapItem.name = item.venue.name
        mapItem.openInMaps()
    }

    // TODO - Needs to vanish
    func parseConfig(filename: String) -> FoursquareConfig {
        let url = Bundle.main.url(forResource: filename, withExtension: "plist")!
        let data = try! Data(contentsOf: url)
        let decoder = PropertyListDecoder()
        return try! decoder.decode(FoursquareConfig.self, from: data)
    }

}
