//
//  Step1_ViewController.swift
//  WetherForcastApp
//
//  Created by Vikash on 29/06/20.
//  Copyright © 2020 Vikash. All rights reserved.
//

import UIKit

class Step1_ViewController: UIViewController {

    @IBOutlet weak var cityNameTextfield: UITextField!
    @IBOutlet weak var tableview: UITableView!
    
    
    lazy var viewModal: Step1ViewModel = {
        let viewModal = Step1ViewModel(services: APIService(),dataMaping: DataMaping())
        return viewModal
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModal.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModal.alertMessage {
                    self?.showAlert( message )
                }
            }
        }
        
        viewModal.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableview.reloadData()
            }
        }
        
    }

    @IBAction func doneHandler(_ sender: UIButton) {
        
        guard let citiesName = cityNameTextfield.text else {
            showAlert( "Please enter the city name" )
            return
        }
        viewModal.requestedCitiesName(cities: citiesName)
    }
    
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension Step1_ViewController:UITableViewDelegate {
    
}

extension Step1_ViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModal.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = tableView.dequeueReusableCell(withIdentifier: CellConstant.cell1Id, for: indexPath) as? Step1TableViewCell
        
        guard let cell = cell1 else {
            return UITableViewCell()
        }
        
        let cellInfo = viewModal.dataSource[indexPath.row]
        cell.cellConfiguration(cellInfo: cellInfo)
        return cell
    }
}

