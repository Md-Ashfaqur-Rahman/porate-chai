//
//  EditProfileViewController.swift
//  porate-chai
//
//  Created by Md Ashfaqur Rahman on 2/4/20.
//  Copyright © 2020 Md Ashfaqur Rahma. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class EditProfileViewController: UIViewController {
   var ref: DatabaseReference!
    
    @IBOutlet weak var profileimage: UIImageView!
    @IBOutlet weak var fullname: UITextField!
    @IBOutlet weak var email_TextField: UITextField!
    @IBOutlet weak var area_Label: UITextField!
    @IBOutlet weak var studyin_Label: UITextField!
    @IBOutlet weak var splishedsubject_Label: UITextField!
    @IBOutlet weak var time_Label: UITextField!
    @IBOutlet weak var studymedium_Label: UITextField!
    @IBOutlet weak var instute_Label: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        profileimage.layer.cornerRadius = 50
        profileimage.clipsToBounds = true
        
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        print("userID\(String(describing: userID))")
        

        ref.child("guardian").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
          // Get user value
            if snapshot.exists() {
                let value = snapshot.value as? NSDictionary
                let area = value?["area"] as? String ?? ""
                let fullname = value?["fullname"] as? String ?? ""
                let instute = value?["instute"] as? String ?? ""
                let profileimageurl = value?["profileimageurl"] as? String ?? ""
                let splishedsubject = value?["splishedsubject"] as? String ?? ""
                let studyin = value?["studyin"] as? String ?? ""
                let studymedium = value?["studymedium"] as? String ?? ""
                let time = value?["time"] as? String ?? ""
                let email = value?["email"] as? String ?? ""


                
                
                if let imageURL = URL(string: profileimageurl){
                    DispatchQueue.global().async {
                        let data = try? Data(contentsOf: imageURL)
                        if let data = data {
                            let image = UIImage(data: data)
                            DispatchQueue.main.async {
                                self.profileimage.image = image
                            }
                        }
                    }
                }

                self.email_TextField.text = email
                self.fullname.text = fullname
                self.area_Label.text = "\(area)"
                self.studyin_Label.text = "\(studyin)"
                self.splishedsubject_Label.text = "\(splishedsubject)"
                self.time_Label.text = "\(time)"
                self.studymedium_Label.text = "\(studymedium)"
                self.instute_Label.text = "\(instute)"
            } else {
                self.ref.child("tutor").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                    let value = snapshot.value as? NSDictionary
                   let area = value?["area"] as? String ?? ""
                    let fullname = value?["fullname"] as? String ?? ""
                    let instute = value?["instute"] as? String ?? ""
                    let profileimageurl = value?["profileimageurl"] as? String ?? ""
                    let splishedsubject = value?["splishedsubject"] as? String ?? ""
                    let studyin = value?["studyin"] as? String ?? ""
                    let preferteachingclass = value?["preferteachingclass"] as? String ?? ""
                    let time = value?["time"] as? String ?? ""

                    let email = value?["email"] as? String ?? ""

                    
                    
                    
                    if let imageURL = URL(string: profileimageurl){
                        DispatchQueue.global().async {
                            let data = try? Data(contentsOf: imageURL)
                            if let data = data {
                                let image = UIImage(data: data)
                                DispatchQueue.main.async {
                                    self.profileimage.image = image
                                }
                            }
                        }
                    }

                    self.email_TextField.text = email
                    self.fullname.text = fullname
                    self.area_Label.text = "\(area)"
                    self.studyin_Label.text = "\(studyin)"
                    self.splishedsubject_Label.text = "\(splishedsubject)"
                    self.time_Label.text = "\(time)"
                    self.studymedium_Label.text = "\(preferteachingclass)"
                    self.instute_Label.text = "\(instute)"
                    }) { (error) in
                        print(error.localizedDescription)
                    }
            }
          
          // ...
          }) { (error) in
            print(error.localizedDescription)
        }
    }

}
