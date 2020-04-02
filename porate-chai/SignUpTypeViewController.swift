//
//  SignUpViewController.swift
//  Porate-Chai
//
//  Created by Md Ashfaqur Rahman on 26/3/20.
//  Copyright © 2020 Md Ashfaqur Rahma. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class SignUpTypeViewController: UIViewController {
    
    @IBOutlet weak var imgOfProfileImageView: UIImageView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var imagepicker = UIImagePickerController()
    var selectedImage: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgOfProfileImageView.layer.cornerRadius = 50
        imgOfProfileImageView.clipsToBounds = true
        
        userNameTextField.backgroundColor = UIColor.clear
        userNameTextField.tintColor = UIColor.white
        userNameTextField.textColor = UIColor.white
        userNameTextField.attributedPlaceholder = NSAttributedString(string: userNameTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
        let bottomLayer = CALayer()
        bottomLayer.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayer.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        userNameTextField.layer.addSublayer(bottomLayer)
        
        emailTextField.backgroundColor = UIColor.clear
        emailTextField.tintColor = UIColor.white
        emailTextField.textColor = UIColor.white
        emailTextField.attributedPlaceholder = NSAttributedString(string: emailTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
        let bottomLayer2 = CALayer()
        bottomLayer2.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayer2.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        emailTextField.layer.addSublayer(bottomLayer2)
        
        
        passwordTextField.backgroundColor = UIColor.clear
        passwordTextField.tintColor = UIColor.white
        passwordTextField.textColor = UIColor.white
        passwordTextField.attributedPlaceholder = NSAttributedString(string: passwordTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.6)])
        let bottomLayer3 = CALayer()
        bottomLayer3.frame = CGRect(x: 0, y: 29, width: 1000, height: 0.6)
        bottomLayer3.backgroundColor = UIColor(red: 50/255, green: 50/255, blue: 25/255, alpha: 1).cgColor
        passwordTextField.layer.addSublayer(bottomLayer3)
        
        imagepicker.delegate = self
        
        // Do any additional setup after loading the view.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func dismiss_onClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func imageEditAction(_ sender: Any) {
        imagepicker.sourceType = .photoLibrary
        imagepicker.allowsEditing = true
        present(imagepicker, animated: true, completion: nil)
    }
    
    @IBAction func guardianSignUpAction(_ sender: Any) {
        view.endEditing(true)
        performSegue(withIdentifier: "gotoGuardianSignUp", sender: self)
    }
    
    @IBAction func tutorSignUpAction(_ sender: Any) {
        view.endEditing(true)
        performSegue(withIdentifier: "gotoTutorDetailsSignUp", sender: self)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoTutorDetailsSignUp" {
            let distinationVC = segue.destination as! TutorSignUpViewController
            distinationVC.userProfileImage = imgOfProfileImageView.image
            distinationVC.userFullName = userNameTextField.text
            distinationVC.userEmail = emailTextField.text
            distinationVC.userPassword = passwordTextField.text
            
        } else if segue.identifier == "gotoGuardianSignUp" {
            let distinationVC = segue.destination as! GuardianSignUpViewController
            distinationVC.userProfileImage = imgOfProfileImageView.image
            distinationVC.userFullName = userNameTextField.text
            distinationVC.userEmail = emailTextField.text
            distinationVC.userPassword = passwordTextField.text
        }
    }
}
extension SignUpTypeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImage = image
            imgOfProfileImageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}
