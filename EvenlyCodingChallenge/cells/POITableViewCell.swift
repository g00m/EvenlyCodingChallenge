//
//  POITableViewCell.swift
//  EvenlyCodingChallenge
//
//  Created by Ed Negro on 27.11.18.
//  Copyright © 2018 Etienne Negro. All rights reserved.
//

import UIKit

class POITableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    func bind(item: Item) {
        self.titleLabel.text = item.venue.name
        self.distanceLabel.text = "\(item.venue.location.distance) m"
        self.addressLabel.text = item.venue.location.address
        self.categoryLabel.text = item.venue.categories[0].name
    }

}
