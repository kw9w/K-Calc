//
//  CalcViewController.swift
//  Calc
//
//  Created by kw9w on 10/7/21.
//

import UIKit

class CalcViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    @IBOutlet weak var RadOn: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.display.text! = "0"
        self.RadOn.text! = "Deg"
    }
    
    var digitOnDisplay: String{
        get {
            return self.display.text!
        }
        
        set {
            self.display.text! = newValue
        }
    }
    
    
    var inTypingMode = false

    @IBAction func numberPressed(_ sender: UIButton) {
        if inTypingMode{
            digitOnDisplay = digitOnDisplay + sender.titleLabel!.text!
        }
        else{
            inTypingMode = true
            digitOnDisplay = sender.titleLabel!.text!
        }
    }
    
    
    let calculator = Calculator()
    
    @IBAction func operatorPressed(_ sender: UIButton) {
        if let op = sender.titleLabel!.text{
            if op == "Rad"{
                if self.RadOn.text! == "Deg"{
                    self.RadOn.text! = "Rad"
                }
                else{
                    self.RadOn.text! = "Deg"
                }
            }
            if (Double(digitOnDisplay) == nil){
                digitOnDisplay = String(0)
            }
            
            if let result = calculator.performOperation(operation: op, operand: Double(digitOnDisplay)!){
                digitOnDisplay = String(result)
            }
            else{
                digitOnDisplay = String("Not A Number")
            }
            
            inTypingMode = false
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
