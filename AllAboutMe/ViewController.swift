//
//  ViewController.swift
//  AllAboutMe
//
//  Created by Eric rabiner on 2019-09-12.
//  Copyright © 2019 Eric Rabiner. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    // Variables
    
    // Outlets
    @IBOutlet weak var resultText: UITextView!
    @IBOutlet weak var programSelector: UISegmentedControl!
    @IBOutlet weak var levelSelector: UISegmentedControl!
    @IBOutlet weak var gpaSelector: UISlider!
    @IBOutlet weak var gpaInput: UITextField!
    
    // Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Disable level 7 and level 8 on start
        levelSelector.setEnabled(false, forSegmentAt: 3)
        levelSelector.setEnabled(false, forSegmentAt: 4)
        
        // Set the delegates in code statements
        gpaInput.delegate = self
        
        updateGpaInputText()
        updateResultText()
    }
    
    func updateResultText() {
        // Read results from UI controls
        
        // Get and store program selected
        let programValue = programSelector.selectedSegmentIndex == 0 ? "CPA" : "BSD"
        
        // Get and store level selected
        let levelValue = String(levelSelector.selectedSegmentIndex + 4)
        
        // Get and store gpa value
        let gpaValue = String(format: "%1.2f", gpaSelector.value)
        
        // Assemble text view string
        resultText.text = "I am in the \(programValue) program, in level \(levelValue), and my GPA is \(gpaValue)."
        
    }
    
    func updateGpaInputText() {
        gpaInput.text = String(format: "%1.2f", gpaSelector.value)
    }
    
    func updateGpaSelectorValue() {
        gpaSelector.value = Float(gpaInput.text!) ?? 0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Actions

    @IBAction func programChanged(_ sender: UISegmentedControl) {
//        updateResultText()
        
        // CPA selected
        if (sender.selectedSegmentIndex == 0) {
            levelSelector.setEnabled(false, forSegmentAt: 3)
            levelSelector.setEnabled(false, forSegmentAt: 4)
        }
        // BSD selected
        else {
            if (levelSelector.selectedSegmentIndex == 3 || levelSelector.selectedSegmentIndex == 4) {
                levelSelector.selectedSegmentIndex = 2
                print(levelSelector.selectedSegmentIndex)
            }
            levelSelector.setEnabled(true, forSegmentAt: 3)
            levelSelector.setEnabled(true, forSegmentAt: 4)
        }
        updateResultText()
        print("program changed")
    }
    
    @IBAction func levelChanged(_ sender: UISegmentedControl) {
        updateResultText()
        print(sender.selectedSegmentIndex)
        print("level changed")
    }
    
    @IBAction func gpaSelectorChanged(_ sender: UISlider) {
        updateResultText()
        updateGpaInputText()
        print("gpa selector changed")
    }
    
    @IBAction func gpaInputChanged(_ sender: UITextField) {
        updateGpaSelectorValue()
        updateResultText()
        let gpaInputValue = Float(gpaInput.text!) ?? 0
        if (gpaInputValue > 4) {
            gpaInput.text = "4.00"
        }
        else if (gpaInputValue < 2) {
            gpaInput.text = "2.00"
        }
        updateGpaInputText()
        
        print("gpa input changed")
    }
}
