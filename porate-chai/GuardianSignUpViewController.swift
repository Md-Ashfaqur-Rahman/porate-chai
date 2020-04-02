//
//  GurdianSignUpViewController.swift
//  Porate-Chai
//
//  Created by Md Ashfaqur Rahman on 27/3/20.
//  Copyright © 2020 Md Ashfaqur Rahma. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class GuardianSignUpViewController: UIViewController {
    
    var userProfileImage: UIImage?
    var userFullName: String?
    var userEmail: String?
    var userPassword: String?
    
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var schoolTextField: UITextField!
    @IBOutlet weak var readClassTextField: UITextField!
    @IBOutlet weak var studyMediumTextField: UITextField!
    @IBOutlet weak var findSplishedSubjectTextField: UITextField!
    @IBOutlet weak var houseAreaTextField: UITextField!
    @IBOutlet weak var preferTimeTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.image = userProfileImage
        profileImageView.layer.cornerRadius = 50
        profileImageView.clipsToBounds = true
        
        schoolTextField.backgroundColor = UIColor.clear
        schoolTextField.tintColor = UIColor.white
        schoolTextField.textColor = UIColor.white
        schoolTextField.attributedPlaceholder = NSAttributedString(string: schoolTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
        let bottomLayer = CALayer()
        bottomLayer.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayer.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        schoolTextField.layer.addSublayer(bottomLayer)
        
        
        readClassTextField.backgroundColor = UIColor.clear
        readClassTextField.tintColor = UIColor.white
        readClassTextField.textColor = UIColor.white
        readClassTextField.attributedPlaceholder = NSAttributedString(string: readClassTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
        let bottomLayer2 = CALayer()
        bottomLayer2.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayer2.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        readClassTextField.layer.addSublayer(bottomLayer2)
        
        studyMediumTextField.backgroundColor = UIColor.clear
        studyMediumTextField.tintColor = UIColor.white
        studyMediumTextField.textColor = UIColor.white
        studyMediumTextField.attributedPlaceholder = NSAttributedString(string: studyMediumTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
        let bottomLayer3 = CALayer()
        bottomLayer3.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayer3.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        studyMediumTextField.layer.addSublayer(bottomLayer3)
        
        findSplishedSubjectTextField.backgroundColor = UIColor.clear
        findSplishedSubjectTextField.tintColor = UIColor.white
        findSplishedSubjectTextField.textColor = UIColor.white
        findSplishedSubjectTextField.attributedPlaceholder = NSAttributedString(string: findSplishedSubjectTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
        let bottomLayer4 = CALayer()
        bottomLayer4.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayer4.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        findSplishedSubjectTextField.layer.addSublayer(bottomLayer4)
        
        houseAreaTextField.backgroundColor = UIColor.clear
        houseAreaTextField.tintColor = UIColor.white
        houseAreaTextField.textColor = UIColor.white
        houseAreaTextField.attributedPlaceholder = NSAttributedString(string: houseAreaTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
        let bottomLayer5 = CALayer()
        bottomLayer5.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayer5.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        houseAreaTextField.layer.addSublayer(bottomLayer5)
        
        preferTimeTextField.backgroundColor = UIColor.clear
        preferTimeTextField.tintColor = UIColor.white
        preferTimeTextField.textColor = UIColor.white
        preferTimeTextField.attributedPlaceholder = NSAttributedString(string: preferTimeTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
        let bottomLayer6 = CALayer()
        bottomLayer6.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayer6.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        preferTimeTextField.layer.addSublayer(bottomLayer6)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    @IBAction func guardianSignUpAction(_ sender: Any) {
        view.endEditing(true)
        Auth.auth().createUser(withEmail: userEmail!, password: userPassword!) { (result, error) in
            if let _eror = error {
                //something bad happning
                print(_eror.localizedDescription )
            } else {
                //user registered successfully
                print("After creating user\(result!)")
                let uid = result?.user.uid
                
                let uploadFileRef = Storage.storage().reference(withPath: "guardian_profile_images/\(uid!).jpg")
                print(uploadFileRef)
                
                if let profileImage = self.userProfileImage, let imageData = profileImage.jpegData(compressionQuality: 0.1) {
                    print("check: 3 >> \(imageData)")
                    uploadFileRef.putData(imageData, metadata: nil) { (metadata, error) in
                        if error != nil {
                            return
                        }
                        print("put image on firebase storage")
                        uploadFileRef.downloadURL(completion: {(url, error) in
                            if error != nil {
                                print(error!.localizedDescription)
                                return
                            }
                            let downloadURL = url?.absoluteString
                            print(downloadURL!)
                            let ref = Database.database().reference()
                            print("seeref\(ref)")
                            let userReference = ref.child("guardian")
                            let newUserReference = userReference.child(uid!)
                            newUserReference.setValue([
                                "fullname": self.userFullName!,
                                "email": self.userEmail!,
                                "instute": self.schoolTextField.text!,
                                "studyin": self.readClassTextField.text!,
                                "studymedium": self.studyMediumTextField.text!,
                                "splishedsubject": self.findSplishedSubjectTextField.text!,
                                "area": self.houseAreaTextField.text!,
                                "time": self.preferTimeTextField.text!,
                                "profileimageurl": downloadURL!
                            ])
                            self.performSegue(withIdentifier: "guardianDetailstoTabBar", sender: nil)
                            
                        })
                    }
                }
            }
        }
    }
    
    
    @IBAction func dismissButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
