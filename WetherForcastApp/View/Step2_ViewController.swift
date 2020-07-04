//
//  Step2_ViewController.swift
//  WetherForcastApp
//
//  Created by Vikash on 30/06/20.
//  Copyright © 2020 Vikash. All rights reserved.
//

import UIKit
import CoreLocation

class Step2_ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    lazy var viewModal: Step2ViewModel = {
        let viewModal = Step2ViewModel(services: APIService(), dataMaping: DataMaping())
        return viewModal
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModal.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableview.reloadData()
            }
        }        
        viewModal.getCurrentlocation()
    }
}

extension Step2_ViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
}

extension Step2_ViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModal.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = tableView.dequeueReusableCell(withIdentifier: CellConstant.cell2Id, for: indexPath) as? Step2TableViewCell
        
        guard let cell = cell1 else {
            return UITableViewCell()
        }
        
        let cellInfo = viewModal.dataSource[indexPath.row]
        cell.cellConfiguration(cellInfo: cellInfo)
        return cell
    }
}
