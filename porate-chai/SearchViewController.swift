//
//  ChoiseViewController.swift
//  Porate-Chai
//
//  Created by Md Ashfaqur Rahman on 26/3/20.
//  Copyright © 2020 Md Ashfaqur Rahma. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {


    
    @IBOutlet weak var imageProfileTableViewCell: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func subject_Search_Action(_ sender: Any) {
        imageProfileTableViewCell.image = #imageLiteral(resourceName: "Chemestry")
    }
    
    @IBAction func area_Search_Action(_ sender: Any) {
        
        imageProfileTableViewCell.image = #imageLiteral(resourceName: "Dhanmondi")
    }
}
