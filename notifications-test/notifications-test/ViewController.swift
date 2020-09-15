//
//  ViewController.swift
//  notifications-test
//
//  Created by Uditi Sharma on 31/08/2020.
//  Copyright © 2020 Surender Sharma. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var textfield1: UITextField!
    
    @IBOutlet weak var textfield2: UITextField!
    
    @IBOutlet weak var textfield3: UITextField!
    //
    //  SettingsViewController.swift
    //  Wash your hands!
    //
    //  Created by Uditi Sharma on 03/09/2020.
    //  Copyright © 2020 Surender Sharma. All rights reserved.
    //
    
    
    // MARK:- Variables
    let pickerOptions1 = ["4", "5", "6", "7", "8", "9", "10", "11"]
    let pickerOptions2 = ["20", "21", "22", "23", "00"]
    let pickerOptions3 = ["30", "40", "50", "60"]
    
    
    let defaults = UserDefaults.standard
    let hour = Calendar.current.component(.hour, from: Date())
    
    var endTime = 0
    var startTime = 0
    var timeInterval = 0
    
    let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
    
    // MARK:- viewDidLoad
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        
        let endTimeTime = defaults.integer(forKey: "endTime")
        let startTimeTime =  defaults.integer(forKey: "startTime")
        let timeIntervalTime = defaults.integer(forKey: "timeInterval")
        
        
        if startTimeTime != 0 {
            textfield1.text = "\(startTimeTime)"
            
        }
        
        if endTimeTime != 0 {
            textfield2.text = "\(endTimeTime)"
        }
        if timeIntervalTime != 0 {
            textfield3.text = "\(timeIntervalTime)"
            
        }
        
        let pickerView1 = UIPickerView()
        pickerView1.delegate  = self
        pickerView1.tag = 1
        textfield1.inputView = pickerView1
        
        let pickerView2 = UIPickerView()
        pickerView2.delegate = self
        pickerView2.tag = 2
        textfield2.inputView = pickerView2
        
        let pickerView3 = UIPickerView()
        pickerView3.delegate = self
        pickerView3.tag = 3
        textfield3.inputView = pickerView3
        
        
        print(hour)
        
    }
    
    // MARK:- picker stuff
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return pickerOptions1.count
        }
        
        if pickerView.tag == 2 {
            return pickerOptions2.count
        }
        if pickerView.tag == 3 {
            return pickerOptions3.count
        }
        
        
        return 0
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //        return pickerOptions1[row]
        
        if pickerView.tag == 1 {
            return pickerOptions1[row]
            
        }
        
        if pickerView.tag == 2 {
            return pickerOptions2[row]
        }
        if pickerView.tag == 3 {
            return pickerOptions3[row]
        }
        
        return ""
    }
    
    //MARK:- dark mode
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    //MARK:- did select row
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            textfield1.text = pickerOptions1[row]
            startTime = Int(textfield1.text!) ?? 0
            defaults.set(startTime, forKey: "startTime")
            print(startTime)
            
        }
        if pickerView.tag == 2 {
            textfield2.text = pickerOptions2[row]
            endTime = Int(textfield2.text!) ?? 0
            defaults.set(endTime, forKey: "endTime")
            
            print(endTime)
        }
        
        if pickerView.tag == 3 {
            textfield3.text = pickerOptions3[row]
            print(textfield3.text!)
            timeInterval = Int(textfield3.text!) ?? 0
            defaults.set(timeInterval, forKey: "timeInterval")
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK:- createNotify
    
    
    func createNotify(){
        
        let defaults = UserDefaults.standard
        
        print("show notifications")
        let endTimeTime = defaults.integer(forKey: "endTime")
        let startTimeTime =  defaults.integer(forKey: "startTime")
        
        let timeIntervalTime = defaults.integer(forKey: "timeInterval")
        
        if  hour > startTimeTime && hour < endTimeTime{
            
            let content = UNMutableNotificationContent()
            content.title = "titles.randomElement()!"
            content.body = "contents.randomElement()!"
            content.sound = UNNotificationSound.default
            
            let timeToGive = timeIntervalTime*60
            let interval:TimeInterval = Double(timeToGive)
            //                let interval:TimeInterval = TimeInterval(timeIntervalTime*60) // 1 minute = 60 seconds
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: true)
            
            let request = UNNotificationRequest(identifier:UUID().uuidString, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request)
        }else{
            print("do nothing")
        }
    }
    
    
}




