//
//  ViewController.swift
//  GG
//
//  Created by Murgia Antonio on 30/08/14.
//  Copyright (c) 2014 Murgia Antonio. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
/*
gg_button.setImage(UIImage(named: "gg_pressed"), forState: .Normal)
*/
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func tap(sender: UIButton) {

        sender.setImage(UIImage(named: "gg_pressed"), forState: .Normal)
        play()

    }
    @IBAction func untap(sender: UIButton) {
        sender.setImage(UIImage(named: "gg_notPressed"), forState: .Normal)
    }
    func play(){
        let myAppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        myAppDelegate.playFromUrl(NSBundle.mainBundle().URLForResource("GG", withExtension: "m4a")!)
    }
}

