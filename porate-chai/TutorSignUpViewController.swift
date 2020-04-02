//
//  TutorSignUpViewController.swift
//  Porate-Chai
//
//  Created by Md Ashfaqur Rahman on 27/3/20.
//  Copyright © 2020 Md Ashfaqur Rahma. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class TutorSignUpViewController: UIViewController {
    
    var userProfileImage: UIImage?
    var userFullName: String?
    var userEmail: String?
    var userPassword: String?
    var selectedImage: UIImage?
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var universityTextField: UITextField!
    @IBOutlet weak var educationHistoryTextField: UITextField!
    @IBOutlet weak var preferTeachingClassTextField: UITextField!
    @IBOutlet weak var splishedSubjectTextField: UITextField!
    @IBOutlet weak var preferedAreaTextField: UITextField!
    @IBOutlet weak var preferedTimeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.image = userProfileImage
    
        selectedImage = userProfileImage
        profileImageView.layer.cornerRadius = 50
        profileImageView.clipsToBounds = true
        
        universityTextField.backgroundColor = UIColor.clear
        universityTextField.tintColor = UIColor.white
        universityTextField.textColor = UIColor.white
        universityTextField.attributedPlaceholder = NSAttributedString(string: universityTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
        let bottomLayer = CALayer()
        bottomLayer.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayer.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        universityTextField.layer.addSublayer(bottomLayer)

        educationHistoryTextField.backgroundColor = UIColor.clear
        educationHistoryTextField.tintColor = UIColor.white
        educationHistoryTextField.textColor = UIColor.white
        educationHistoryTextField.attributedPlaceholder = NSAttributedString(string: educationHistoryTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
        let bottomLayer2 = CALayer()
        bottomLayer2.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayer2.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        educationHistoryTextField.layer.addSublayer(bottomLayer2)
        
        preferTeachingClassTextField.backgroundColor = UIColor.clear
        preferTeachingClassTextField.tintColor = UIColor.white
        preferTeachingClassTextField.textColor = UIColor.white
        preferTeachingClassTextField.attributedPlaceholder = NSAttributedString(string: preferTeachingClassTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
        let bottomLayer3 = CALayer()
        bottomLayer3.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayer3.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        preferTeachingClassTextField.layer.addSublayer(bottomLayer3)
        
        splishedSubjectTextField.backgroundColor = UIColor.clear
        splishedSubjectTextField.tintColor = UIColor.white
        splishedSubjectTextField.textColor = UIColor.white
        splishedSubjectTextField.attributedPlaceholder = NSAttributedString(string: splishedSubjectTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
        let bottomLayer4 = CALayer()
        bottomLayer4.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayer4.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        splishedSubjectTextField.layer.addSublayer(bottomLayer4)
        
        preferedAreaTextField.backgroundColor = UIColor.clear
        preferedAreaTextField.tintColor = UIColor.white
        preferedAreaTextField.textColor = UIColor.white
        preferedAreaTextField.attributedPlaceholder = NSAttributedString(string: preferedAreaTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
        let bottomLayer5 = CALayer()
        bottomLayer5.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayer5.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        preferedAreaTextField.layer.addSublayer(bottomLayer5)
        
        preferedTimeTextField.backgroundColor = UIColor.clear
        preferedTimeTextField.tintColor = UIColor.white
        preferedTimeTextField.textColor = UIColor.white
        preferedTimeTextField.attributedPlaceholder = NSAttributedString(string: preferedTimeTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
        let bottomLayer6 = CALayer()
        bottomLayer6.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayer6.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        preferedTimeTextField.layer.addSublayer(bottomLayer6)
        
        print(userEmail!)
        
        print(userPassword!)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    @IBAction func dismiss_onClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tutorSignUpAction(_ sender: Any) {
        view.endEditing(true)
        Auth.auth().createUser(withEmail: userEmail!, password: userPassword!) { (result, error) in
            if let _eror = error {
                //something bad happning
                print(_eror.localizedDescription )
            } else {
                //user registered successfully
                print("After creating user\(result!)")
                let uid = result?.user.uid
                
                let uploadFileRef = Storage.storage().reference().child("tutor_profile_images").child(uid!)
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
                            let userReference = ref.child("tutor")
                            let newUserReference = userReference.child(uid!)
                            newUserReference.setValue([
                                "fullname": self.userFullName!,
                                "email": self.userEmail!,
                                "instute": self.universityTextField.text!,
                                "studyin": self.educationHistoryTextField.text!,
                                "preferteachingclass": self.preferTeachingClassTextField.text!,
                                "splishedsubject": self.splishedSubjectTextField.text!,
                                "area": self.preferedAreaTextField.text!,
                                "time": self.preferedTimeTextField.text!,
                                "profileimageurl": downloadURL!
                            ])
                            self.performSegue(withIdentifier: "tutorDetailstoTabBar", sender: nil)
                        })
                    }
                }
            }
        }
    }
}
