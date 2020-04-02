//
//  ProfileViewController.swift
//  porate-chai
//
//  Created by Md Ashfaqur Rahman on 2/4/20.
//  Copyright © 2020 Md Ashfaqur Rahma. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileimage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileimage.layer.cornerRadius = 100
        profileimage.clipsToBounds = true
        // Do any additional setup after loading the view.
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
