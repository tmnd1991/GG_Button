//
//  Voice.swift
//  GG
//
//  Created by Murgia Antonio on 02/09/14.
//  Copyright (c) 2014 Murgia Antonio. All rights reserved.
//

import UIKit

class Voice: NSObject {
    let url : NSURL?
    let name : String
    let fileName : String
    let fileExtension : String
    init(name: String, fileName: String, fileExtension : String){
        if (name == "" || fileName == "" || fileExtension == ""){
            fatalError("name == \"\" || fileName == \"\" || fileExtension == \"\"")
        }
        self.name = name
        self.fileName = fileName
        self.fileExtension = fileExtension
        if let url = NSBundle.mainBundle().URLForResource(fileName, withExtension: fileExtension) {
            self.url = url
        }
    }
}
