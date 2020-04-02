//
//  File.swift
//  Porate-Chai
//
//  Created by Md Ashfaqur Rahman on 31/3/20.
//  Copyright © 2020 Md Ashfaqur Rahma. All rights reserved.
//

import Foundation

class Tutor {
    var area: String
    var email: String
    var fullname: String
    var instute: String
    var preferteachingclass: String
    var profileimageurl: String
    var splishedsubject: String
    var studyin: String
    var time: String

    init(areaString: String, emailString: String, fullnameString: String, instuteString: String, preferteachingclassString: String, profileimageurlString: String, splishedsubjectString: String, studyinString: String, timeString: String) {
        
        area = areaString
        email = emailString
        fullname = fullnameString
        instute = instuteString
        preferteachingclass = preferteachingclassString
        profileimageurl = profileimageurlString
        splishedsubject = splishedsubjectString
        studyin = studyinString
        time = timeString
    }
}
