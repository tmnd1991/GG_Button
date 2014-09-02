//
//  Phrase.swift
//  GG
//
//  Created by Murgia Antonio on 02/09/14.
//  Copyright (c) 2014 Murgia Antonio. All rights reserved.
//

import UIKit

class Phrase: NSObject {
    let name : String
    let voices : Dictionary<String,Voice>
    init(name: String, voices: Dictionary<String,Voice>){
        if (name == "" || voices.count == 0)
        {
            fatalError("name cannot be empty, nor can the array of voices")
        }
        self.name = name
        self.voices = voices
    }
    convenience init(name: String, voices : Array<Voice>){
        self.init(name: name, voices: voices.reduce([:]) {
                (var dict, e) in dict[e.name] = e
                return dict
            })
        
    }
}
