//
//  Step1TableViewCell.swift
//  WetherForcastApp
//
//  Created by Vikash on 29/06/20.
//  Copyright © 2020 Vikash. All rights reserved.
//

import UIKit

class Step1TableViewCell: UITableViewCell {

    @IBOutlet weak var wetherDescLbl: UILabel!
    @IBOutlet weak var windSpeedLbl: UILabel!
    @IBOutlet weak var maxTempLbl: UILabel!
    @IBOutlet weak var minTempLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellConfiguration(cellInfo: Step1CellModel) {
        self.wetherDescLbl.text = cellInfo.wetherDescription
        self.minTempLbl.text = String(cellInfo.minTemp!)
        self.maxTempLbl.text = String(cellInfo.maxTemp!)
        self.windSpeedLbl.text = String(cellInfo.windSpeed!)
    }

}
