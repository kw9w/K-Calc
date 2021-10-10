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
    
    @IBOutlet weak var sin2nd: UIButton!
    @IBOutlet weak var cos2nd: UIButton!
    @IBOutlet weak var tan2nd: UIButton!
    @IBOutlet weak var sinh2nd: UIButton!
    @IBOutlet weak var cosh2nd: UIButton!
    @IBOutlet weak var tanh2nd: UIButton!
    @IBOutlet weak var ex2nd: UIButton!
    @IBOutlet weak var tenx2nd: UIButton!
    @IBOutlet weak var ln2nd: UIButton!
    @IBOutlet weak var log102nd: UIButton!
    
    var digitOnDisplay: String{
        get {
            return self.display.text!
        }
        
        set {
            self.display.text! = newValue
        }
    }
    
    
    var inTypingMode = false
    var in2ndMode = false

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
    
    
    @IBAction func ifPressed2nd(_ sender: UIButton) {
        if let op = sender.titleLabel!.text{
            if op == "2nd"{
                in2ndMode = !in2ndMode
    //                print("on")
    //                print(sin2nd.titleLabel!.text == "sin")
                if in2ndMode{
                    self.sin2nd.setTitle("sin-1", for: .normal)
                    self.cos2nd.setTitle("cos-1", for: .normal)
                    self.tan2nd.setTitle("tan-1", for: .normal)
                    self.sinh2nd.setTitle("sinh-1", for: .normal)
                    self.cosh2nd.setTitle("cosh-1", for: .normal)
                    self.tanh2nd.setTitle("tanh-1", for: .normal)
                    self.ex2nd.setTitle("y^x", for: .normal)
                    self.tenx2nd.setTitle("2^x", for: .normal)
                    self.ln2nd.setTitle("logy", for: .normal)
                    self.log102nd.setTitle("log2", for: .normal)
//                    self.sin2nd.titleLabel?.font =  UIFont(name: "Futura-Medium", size: 20)
                }
                else{
                    self.sin2nd.setTitle("sin", for: .normal)
                    self.cos2nd.setTitle("cos", for: .normal)
                    self.tan2nd.setTitle("tan", for: .normal)
                    self.sinh2nd.setTitle("sinh", for: .normal)
                    self.cosh2nd.setTitle("cosh", for: .normal)
                    self.tanh2nd.setTitle("tanh", for: .normal)
                    self.ex2nd.setTitle("e^x", for: .normal)
                    self.tenx2nd.setTitle("10^x", for: .normal)
                    self.ln2nd.setTitle("ln", for: .normal)
                    self.log102nd.setTitle("㏒10", for: .normal)
//                    self.sin2nd.titleLabel?.font =  UIFont(name: "Futura-Medium", size: 20)
                }
            }
        }
    }
    
    
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
