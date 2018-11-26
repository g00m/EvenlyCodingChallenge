//
//  POITableViewDelegate.swift
//  EvenlyCodingChallenge
//
//  Created by Ed Negro on 26.11.18.
//  Copyright © 2018 Etienne Negro. All rights reserved.
//

import UIKit

class POITableViewDelegate: NSObject, UITableViewDelegate {
    typealias CellListener = (Int) -> ()

    private let cellListener: CellListener
    
    init(listener: @escaping CellListener) {
        self.cellListener = listener
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellListener(indexPath.row)
    }

}
