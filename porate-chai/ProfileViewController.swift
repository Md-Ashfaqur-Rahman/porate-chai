//
//  ProfileViewController.swift
//  porate-chai
//
//  Created by Md Ashfaqur Rahman on 2/4/20.
//  Copyright © 2020 Md Ashfaqur Rahma. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ProfileViewController: UIViewController {

    var ref: DatabaseReference!
    
    @IBOutlet weak var profileimage: UIImageView!
    @IBOutlet weak var fullname: UILabel!
    @IBOutlet weak var area_Label: UILabel!
    @IBOutlet weak var studyin_Label: UILabel!
    @IBOutlet weak var splishedsubject_Label: UILabel!
    @IBOutlet weak var time_Label: UILabel!
    @IBOutlet weak var studymedium_Label: UILabel!
    @IBOutlet weak var instute_Label: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        profileimage.layer.cornerRadius = 100
        profileimage.clipsToBounds = true
        
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        print("userID\(String(describing: userID))")
        

        if let userID = userID {
            ref.child("guardian").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
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

                    self.fullname.text = fullname
                    self.area_Label.text = "Home Area >> \(area)"
                    self.studyin_Label.text = " Children Read In Class >> \(studyin)"
                    self.splishedsubject_Label.text = " Children Read for Subject >> \(splishedsubject)"
                    self.time_Label.text = "Children Free Study Time >> \(time)"
                    self.studymedium_Label.text = "Children School Medium >> \(studymedium)"
                    self.instute_Label.text = "Children School Name >> \(instute)"
                } else {
                    self.ref.child("tutor").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
                        let value = snapshot.value as? NSDictionary
                       let area = value?["area"] as? String ?? ""
                        let fullname = value?["fullname"] as? String ?? ""
                        let instute = value?["instute"] as? String ?? ""
                        let profileimageurl = value?["profileimageurl"] as? String ?? ""
                        let splishedsubject = value?["splishedsubject"] as? String ?? ""
                        let studyin = value?["studyin"] as? String ?? ""
                        let preferteachingclass = value?["preferteachingclass"] as? String ?? ""
                        let time = value?["time"] as? String ?? ""


                        
                        
                        
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

                        self.fullname.text = fullname
                        self.area_Label.text = "Prefer Teaching Area >> \(area)"
                        self.studyin_Label.text = "Study In >> \(studyin)"
                        self.splishedsubject_Label.text = "Specialist Subject >> \(splishedsubject)"
                        self.time_Label.text = "Prefer Time >> \(time)"
                        self.studymedium_Label.text = "Prefer Teaching Class >> \(preferteachingclass)"
                        self.instute_Label.text = "University / School >> \(instute)"
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
    
    @IBAction func logout_Button_Action(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
          return
        }

        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        let signInVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController")
        self.present(signInVC, animated: true, completion: nil)
        
    }

}
