//
//  FourthViewController.swift
//  Safe Travel
//
//  Created by Medha Gupta on 9/6/17.
//  Copyright © 2017 Medha Gupta. All rights reserved.
//

import UIKit
import MessageUI

class FourthViewController: UIViewController, MFMailComposeViewControllerDelegate {
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var countdownButton: UILabel!
    @IBOutlet var doNotSendButton: UIButton!
    
    let address:String = UserDefaults.standard.object(forKey: "location") as! String
    
    var timer = Timer()
    var time = 30
    
    var emergencymsg:String = UserDefaults.standard.object(forKey: "message") as! String

    @IBAction func sendButton(_ sender: Any) {
        
        timer.invalidate()
        
    }
    
    func decrease()
    {
        if time > 0
        {
            time -= 1
            countdownButton.text = String(time)
        }
        else
        {
            timer.invalidate()
            emergencymsg = "Message sent: " + emergencymsg + " The nearest address for my current location is: " + self.address
            messageLabel.text = emergencymsg
            doNotSendButton.isHidden = true
            
        }
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        doNotSendButton.layer.cornerRadius = 12
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.decrease), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
