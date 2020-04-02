//
//  ViewController.swift
//  porate-chai
//
//  Created by Md Ashfaqur Rahman on 29/3/20.
//  Copyright © 2020 Md Ashfaqur Rahma. All rights reserved.
//

import UIKit
import FirebaseAuth
//import FirebaseDatabase
//import FirebaseStorage

class ViewController: UIViewController {
@IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        emailTextField.backgroundColor = UIColor.clear
        emailTextField.tintColor = UIColor.white
        emailTextField.textColor = UIColor.white
        emailTextField.attributedPlaceholder = NSAttributedString(string: emailTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
        let bottomLayer = CALayer()
        bottomLayer.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayer.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        emailTextField.layer.addSublayer(bottomLayer)
        
        passwordTextField.backgroundColor = UIColor.clear
        passwordTextField.tintColor = UIColor.white
        passwordTextField.textColor = UIColor.white
        passwordTextField.attributedPlaceholder = NSAttributedString(string: passwordTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
        let bottomLayer2 = CALayer()
        bottomLayer2.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayer2.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        passwordTextField.layer.addSublayer(bottomLayer2)
            
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            performSegue(withIdentifier: "signInToTabBarVC", sender: nil)
        }
    }
    
    @IBAction func signInButtonAction(_ sender: Any) {
        view.endEditing(true)
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            strongSelf.performSegue(withIdentifier: "signInToTabBarVC", sender: nil)
        }
    }
}

//
//    @IBOutlet weak var imageview: UIImageView!
//    @IBOutlet weak var emailTextView: UITextField!
//    @IBOutlet weak var passwordTextView: UITextField!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//    }
//
//    @IBAction func buttonAction(_ sender: Any) {
//
//        Auth.auth().createUser(withEmail: emailTextView.text!, password: passwordTextView.text!){ (result, error) in
//            if let _eror = error {
//                print(_eror.localizedDescription)
//                return
//            }
//            print("check: 1 >> After creating user\(result!)")
//
//
//            let uid = result?.user.uid
//
//            let storage = Storage.storage()
//            let storageRef = storage.reference(forURL: "gs://porate-chai-4deee.appspot.com").child("profile_image").child(uid!)
//            print("check: 2 >> \(storageRef)")
//
//
//
//            //                    guard let imageData = self.profileImageView.image!.jpegData(compressionQuality: 0.75) else { return }
//                           //                    let uploadMetaData = StorageMetadata.init()
//                           //                    uploadMetaData.contentType = "image/jpeg"
//                           //
//                           //                    uploadFileRef.putData(imageData, metadata: uploadMetaData) { (downloadMetadata, error) in
//                           //                        if let error = error {
//                           //                            print("got an error \(error.localizedDescription)")
//                           //                            return
//                           //                        }
//                           //                        print("Put is complete\(String(describing: downloadMetadata))")
//                           //            }
//
//
//
//            if let profileImage = self.imageview!.image, let imageData = profileImage.jpegData(compressionQuality: 0.1) {
//                print("check: 3 >> \(imageData)")
//                storageRef.putData(imageData, metadata: nil) { (metadata, error) in
//                    if error != nil {
//                        print("check: 4 >> Don't put image")
//                        return
//                    }
//                    print("put image on firebase storage")
//                    storageRef.downloadURL(completion: {(url, error) in
//                        if error != nil {
//                            print(error!.localizedDescription)
//                            return
//                        }
//                        let downloadURL = url?.absoluteString
//                        print(downloadURL!)
//                        let ref = Database.database().reference()
//                        print("seeref\(ref)")
//                        let userReference = ref.child("tutor")
//                        let newUserReference = userReference.child(uid!)
//                        newUserReference.setValue([
//                            "email": self.emailTextView.text!,
//                            "profileimageurl": downloadURL!
//                        ])
//                    })
//                }
//            }
//        }
//    }
//}
