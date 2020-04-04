//
//  ChoiseViewController.swift
//  Porate-Chai
//
//  Created by Md Ashfaqur Rahman on 26/3/20.
//  Copyright © 2020 Md Ashfaqur Rahma. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SearchViewController: UIViewController {


    var selected_TableRow: Int?
    var tutors = [Tutor]()
    var storeTutors = [Tutor]()
    

    @IBOutlet weak var subject_TextField: UITextField!
    @IBOutlet weak var area_TextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
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
                self.storeTutors.append(tutor)
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func subject_Search_Action(_ sender: Any) {
        tutors.removeAll()
        for n in storeTutors {
            if n.splishedsubject.contains(subject_TextField.text!) {
                tutors.append(n)
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func area_Search_Action(_ sender: Any) {
        tutors.removeAll()
        for n in storeTutors {
            if n.area.contains(area_TextField.text!) {
                tutors.append(n)
                self.tableView.reloadData()
            }
        }
    }
}
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tutors.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeTableViewcell", for: indexPath) as! HomeTableViewCell
        
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected_TableRow = indexPath.row
        performSegue(withIdentifier: "goto_SearchVC_DetailsTutorialVC", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goto_SearchVC_DetailsTutorialVC" {
            let distinationVC = segue.destination as! DetailsTutorViewController
            distinationVC.area = tutors[selected_TableRow!].area
            distinationVC.fullname = tutors[selected_TableRow!].fullname
            distinationVC.instute = tutors[selected_TableRow!].instute
            distinationVC.preferteachingclass  = tutors[selected_TableRow!].preferteachingclass
            distinationVC.profileimageurl = tutors[selected_TableRow!].profileimageurl
            distinationVC.splishedsubject = tutors[selected_TableRow!].splishedsubject
            distinationVC.studyin = tutors[selected_TableRow!].studyin
            distinationVC.time = tutors[selected_TableRow!].time
        }
    }
}

