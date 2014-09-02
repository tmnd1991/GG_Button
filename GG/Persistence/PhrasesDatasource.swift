//
//  PhrasesDatasource.swift
//  GG
//
//  Created by Murgia Antonio on 02/09/14.
//  Copyright (c) 2014 Murgia Antonio. All rights reserved.
//

import UIKit

class PhrasesDataSource : NSObject {
    class var sharedInstance : PhrasesDataSource {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : PhrasesDataSource? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = PhrasesDataSource()
        }
        return Static.instance!
    }
    private(set) var chosen : (String,String)
    func toPlay() -> Voice? {
        let chosenPhrase = phrases[chosen.0]
        let toRet = chosenPhrase?.voices[chosen.1]
        return toRet
    }
    
    let phrases : Dictionary<String, Phrase> = [
        "GG" : Phrase(name : "GG", voices: [Voice(name: "Zano GG",fileName: "GG", fileExtension: "m4a")]),
        "BS" : Phrase(name : "Bullshit", voices: [Voice(name: "Zano GG",fileName: "GG", fileExtension: "m4a"),
                                                  Voice(name: "Zano GG2",fileName: "GG", fileExtension: "m4a")])
    ]
    
    override init() {
        let defPhrase = NSUserDefaults.standardUserDefaults().stringForKey("defaultPhrase")
        let defVoice = NSUserDefaults.standardUserDefaults().stringForKey("defaultVoice")
        if (defVoice != nil && defPhrase != nil){
            chosen = (defPhrase!,defVoice!)
        }
        else{
            let firstPhrase = phrases.keys.array.first!
            let firstVoice = phrases[firstPhrase]?.voices.keys.array.first!
            chosen = (firstPhrase,firstVoice!)
        }
        
    }
    
    func save(choice : (String,String)){
        chosen = choice
        NSUserDefaults.standardUserDefaults().setObject(chosen.0, forKey: "defaultPhrase")
        NSUserDefaults.standardUserDefaults().setObject(chosen.1, forKey: "defaultVoice")
    }

}
