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

    override func viewDidLoad() {
        super.viewDidLoad()
        let chosenPhrase : Int = {
            let keys = PhrasesDataSource.sharedInstance.phrases.keys.array
            var i = 0
            for x in keys{
                if (x == PhrasesDataSource.sharedInstance.chosen.0){
                    return i
                }
                i++
            }
            return 0
        }()
        
        let chosenVoice : Int = {
            let keys = PhrasesDataSource.sharedInstance.phrases[PhrasesDataSource.sharedInstance.chosen.0]?.voices.keys.array
            if (keys != nil){
                var i = 0
                for x in keys!{
                    if (x == PhrasesDataSource.sharedInstance.chosen.1){
                        return i
                    }
                    i++
                }
            }
            return 0
        }()
        
        phrasePicker.selectRow(chosenPhrase, inComponent: 0, animated: true)
        voicePicker.selectRow(chosenVoice, inComponent: 0, animated: true)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(sender: AnyObject) {
        let phraseKeyToSave = PhrasesDataSource.sharedInstance.phrases.keys.array[phrasePicker.selectedRowInComponent(0)]
        let voiceKeyToSave = PhrasesDataSource.sharedInstance.phrases[phraseKeyToSave]!.voices.keys.array[voicePicker.selectedRowInComponent(0)]
        PhrasesDataSource.sharedInstance.save((phraseKeyToSave,voiceKeyToSave))
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
            case voicePicker: return selectedPhrase().voices.count
            case phrasePicker: return PhrasesDataSource.sharedInstance.phrases.count
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
                myAppDelegate.playFromUrl(selectedVoice().url)
                break;
            default: return
        }
    }
    
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String! {
        switch(pickerView){
            case phrasePicker: return PhrasesDataSource.sharedInstance.phrases.values.array[row].name
            case voicePicker:  return selectedPhrase().voices.values.array[row].name
            default: return ""
        }
    }
    func selectedPhrase() -> Phrase{
        let selectedPhraseName = PhrasesDataSource.sharedInstance.phrases.keys.array[phrasePicker.selectedRowInComponent(0)]
        return PhrasesDataSource.sharedInstance.phrases[selectedPhraseName]!
    }
    private func selectedVoice() -> Voice{
        let selectedVoiceName = selectedPhrase().voices.keys.array[voicePicker.selectedRowInComponent(0)]
        return selectedPhrase().voices[selectedVoiceName]!
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
