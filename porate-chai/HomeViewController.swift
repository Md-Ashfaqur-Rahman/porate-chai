//
//  HomeViewController.swift
//  Porate-Chai
//
//  Created by Md Ashfaqur Rahman on 26/3/20.
//  Copyright © 2020 Md Ashfaqur Rahma. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    

    var tutors = [Tutor]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadValueFromDatabase()
    }
    func loadValueFromDatabase() {
        Database.database().reference().child("tutor").observe(.childAdded) { (dataSnapshort) in
            if let dict = dataSnapshort.value as? [String: Any] {
                let areaString = dict["area"] as! String
                let emailString = dict["email"] as! String
                let fullnameString = dict["fullname"] as! String
                let instuteString = dict["instute"] as! String
                let preferteachingclassString = dict["preferteachingclass"] as! String
                let profileimageurlString = dict["profileimageurl"] as! String
                let splishedsubjectString = dict["splishedsubject"] as! String
                let studyinString = dict["studyin"] as! String
                let timeString = dict["time"] as! String
                
                
                let tutor = Tutor(areaString: areaString, emailString: emailString, fullnameString: fullnameString, instuteString: instuteString, preferteachingclassString: preferteachingclassString, profileimageurlString: profileimageurlString, splishedsubjectString: splishedsubjectString, studyinString: studyinString, timeString: timeString)
                
                self.tutors.append(tutor)
                self.tableView.reloadData()
                print(self.tutors)
            }
            
        }
        
    }
    
    @IBAction func sign_Out_Action(_ sender: Any) {
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
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tutors.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeTableViewcell", for: indexPath) as! HomeTableViewCell
        
//        cell.backgroundColor = UIColor.blue
        //        cell.imageProfileTableViewCell.image = #imageLiteral(resourceName: "rowImage")
        cell.fullname.text = tutors[indexPath.row].fullname
        cell.instute.text = tutors[indexPath.row].instute
        cell.splishedsubject.text = tutors[indexPath.row].splishedsubject
        cell.time.text = tutors[indexPath.row].time
        cell.preferTeachingClass.text = tutors[indexPath.row].preferteachingclass
        
        
        
        if let imageURL = URL(string: tutors[indexPath.row].profileimageurl){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.imageProfileTableViewCell.image = image
                    }
                }
            }
        }
        
        
        
        
        
        
        
        
        
        
        
        return cell
    }
    
    
}
