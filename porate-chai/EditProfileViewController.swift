//
//  EditProfileViewController.swift
//  porate-chai
//
//  Created by Md Ashfaqur Rahman on 2/4/20.
//  Copyright © 2020 Md Ashfaqur Rahma. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    @IBOutlet weak var profileimage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileimage.layer.cornerRadius = 50
        profileimage.clipsToBounds = true

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
