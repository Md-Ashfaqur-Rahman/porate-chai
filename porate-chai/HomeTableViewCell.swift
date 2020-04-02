//
//  HomeTableViewCell.swift
//  Porate-Chai
//
//  Created by Md Ashfaqur Rahman on 31/3/20.
//  Copyright © 2020 Md Ashfaqur Rahma. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var imageProfileTableViewCell: UIImageView!
    @IBOutlet weak var fullname: UILabel!
    @IBOutlet weak var instute: UILabel!
    @IBOutlet weak var splishedsubject: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var preferTeachingClass: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageProfileTableViewCell.layer.cornerRadius = 40
        imageProfileTableViewCell.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
