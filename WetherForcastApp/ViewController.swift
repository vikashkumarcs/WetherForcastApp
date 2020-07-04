//
//  ViewController.swift
//  WetherForcastApp
//
//  Created by Vikash on 29/06/20.
//  Copyright © 2020 Vikash. All rights reserved.
//

// API Key e26f3bd7ce6442eb9bffd7228043997b

//  api.openweathermap.org/data/2.5/weather?q=London&appid=e26f3bd7ce6442eb9bffd7228043997b
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func stepHandler(_ sender: UIButton) {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "\("Step")\(sender.tag)\("_ViewController")") as UIViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

