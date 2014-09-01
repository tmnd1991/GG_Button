//
//  OptionsViewController.swift
//  GG
//
//  Created by Murgia Antonio on 01/09/14.
//  Copyright (c) 2014 Murgia Antonio. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var voicePicker: UIPickerView!
    @IBOutlet weak var phrasePicker: UIPickerView!

    let phrase = ["GG", "Bullshit!"]
    let voices = [[("GG1","GG"),("GG2","GG")],[("BS1","GG"),("BS2","GG")]]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }

    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
        switch(pickerView){
            case voicePicker: return voices.count
            case phrasePicker: return phrase.count
            default: return 0
        }
    }
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int) {
        switch(pickerView){
            case phrasePicker:
                voicePicker.reloadComponent(0)
                break
            case voicePicker:
                let myAppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
                myAppDelegate.playFromUrl(NSBundle.mainBundle().URLForResource(voices[phrasePicker.selectedRowInComponent(0)][row].1, withExtension: "m4a")!)
                break;
            default: return
        }
    }
    
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String! {
        switch(pickerView){
            case phrasePicker: return phrase[row]
            case voicePicker: return voices[phrasePicker.selectedRowInComponent(0)][row].0
            default: return ""
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
