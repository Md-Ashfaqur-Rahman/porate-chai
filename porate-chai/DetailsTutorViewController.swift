//
//  DetailsTutorViewController.swift
//  porate-chai
//
//  Created by Md Ashfaqur Rahman on 2/4/20.
//  Copyright © 2020 Md Ashfaqur Rahma. All rights reserved.
//

import UIKit

class DetailsTutorViewController: UIViewController {

    
    var area: String = ""
    var fullname: String = ""
    var instute: String = ""
    var preferteachingclass: String = ""
    var profileimageurl: String = ""
    var splishedsubject: String = ""
    var studyin: String = ""
    var time: String = ""
    
    
    @IBOutlet weak var profileimageurl_UIImageView: UIImageView!
    @IBOutlet weak var fullname_UILabel: UILabel!
    @IBOutlet weak var instute_UILabel: UILabel!
    @IBOutlet weak var studyin_UILabel: UILabel!
    @IBOutlet weak var preferteachingclass_UILabel: UILabel!
    @IBOutlet weak var splishedsubject_UILabel: UILabel!
    @IBOutlet weak var time_UILabel: UILabel!
    @IBOutlet weak var area_UILabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileimageurl_UIImageView.layer.cornerRadius = 100
        profileimageurl_UIImageView.clipsToBounds = true
        
        if let imageURL = URL(string: profileimageurl){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        self.profileimageurl_UIImageView.image = image
                    }
                }
            }
        }
        
        fullname_UILabel.text = fullname
        instute_UILabel.text = instute
        studyin_UILabel.text = studyin
        preferteachingclass_UILabel.text = preferteachingclass
        splishedsubject_UILabel.text = splishedsubject
        time_UILabel.text = time
        area_UILabel.text = area
    }
    
    @IBAction func sendMessage_Button_Action(_ sender: Any) {
        performSegue(withIdentifier: "goto_DetailsVC_To_ChatVC", sender: nil)
    }

    
}
