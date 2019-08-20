//
//  ViewController.swift
//  Safe Travel
//
//  Created by Medha Gupta on 9/5/17.
//  Copyright © 2017 Medha Gupta. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var numOne: UITextField!
    @IBOutlet var numTwo: UITextField!
    @IBOutlet var numThree: UITextField!
    
    @IBOutlet var numLabel: UILabel!
    @IBOutlet var messageField: UITextField!
    @IBOutlet var nextButton: UIBarButtonItem!
    
    
    @IBAction func submitButton(_ sender: Any) {

        UIView.animate(withDuration: 1, animations: {
        
            UserDefaults.standard.set(self.numOne.text, forKey: "numOne")
            self.displayNumone()
            
            UserDefaults.standard.set(self.numTwo.text, forKey: "numTwo")
            self.displayNumtwo()
            
            UserDefaults.standard.set(self.numThree.text, forKey: "numThree")
            self.displayNumthree()
            
        UserDefaults.standard.set(self.messageField.text, forKey: "message")
            self.displayMsg()
        })
        
        nextButton.isEnabled = true
    }
    
    
    var limitLength = 3
    
    @objc(textField:shouldChangeCharactersInRange:replacementString:)
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if textField == numThree
        {
            limitLength = 4
        }
        else
        {
            limitLength = 3
        }
        guard let text = textField.text
            else
        {
            return true
        }
        
        let newLength = text.characters.count + string.characters.count - range.length
            
        return newLength <= limitLength

    }
 
    func displayMsg()
    {
        let msgObject = UserDefaults.standard.object(forKey: "message")
        if let message = msgObject as? String {
            messageField.text = message
        }
    }
    
    func displayNumone()
    {
        let num1Object = UserDefaults.standard.object(forKey: "numOne")
        if let num1 = num1Object as? String {

            numOne.text = num1
        }
    }
    
    func displayNumtwo()
    {
        let num2Object = UserDefaults.standard.object(forKey: "numTwo")
        if let num2 = num2Object as? String {
            
            numTwo.text = num2
        }
    }
    
    func displayNumthree()
    {
        let num3Object = UserDefaults.standard.object(forKey: "numThree")
        if let num3 = num3Object as? String {
            
            numThree.text = num3
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.displayMsg()
        self.displayNumone()
        self.displayNumtwo()
        self.displayNumthree()
        
        numOne.delegate = self
        numTwo.delegate = self
        numThree.delegate = self
    
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    }



