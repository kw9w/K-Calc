//
//  Calculator.swift
//  Calc
//
//  Created by kw9w on 10/7/21.
//

import UIKit

class Calculator: NSObject {
    
    var radOn:Bool = false
    
    enum Operation{
        case UnaryOp((Double)->Double)
        case BinaryOp((Double,Double)->Double)
        case EqualOp
        case Constant(Double)
        case RadOp
        case RadDeg((Double)->Double)
    }
    
    var operations = [
        "+": Operation.BinaryOp{
            (op1, op2) in
            return op2 + op1
        },
        "−": Operation.BinaryOp{
            (op1, op2) in
            return op1 - op2
        },
        "×": Operation.BinaryOp{
            (op1, op2) in
            return op1 * op2
        },
        "÷": Operation.BinaryOp{
            (op1, op2) in
            return op1 / op2
        },
        "=": Operation.EqualOp,
        "%": Operation.UnaryOp{
            op in
            return op / 100.0
        },
        "+/-": Operation.UnaryOp{
            op in
            return -op
        },
        "AC": Operation.UnaryOp{
            _ in
            return 0
        },
        "Rand": Operation.UnaryOp{
            _ in
            return drand48()
        },
        "π": Operation.Constant(Double.pi),
        "1/x": Operation.UnaryOp{
            op in
            return 1/op
        },
        "sin": Operation.RadDeg{
            op in
            return sin(op)
        },
        "cos": Operation.RadDeg{
            op in
            return cos(op)
        },
        "tan": Operation.RadDeg{
            op in
            return tan(op)
        },
        "sinh": Operation.RadDeg{
            op in
            return sinh(op)
        },
        "cosh": Operation.RadDeg{
            op in
            return cosh(op)
        },
        "tanh": Operation.RadDeg{
            op in
            return tanh(op)
        },
        "Rad": Operation.RadOp
    ]
    
    struct Intermediate{
        var firstOp: Double
        var watingOperation: (Double, Double) -> Double
    }
    
    var pendingOp: Intermediate? = nil
    
    var buttonBinOp = false
    
    func performOperation(operation: String, operand: Double)->Double? {
        if let op = operations[operation]{
            switch op{
            case .BinaryOp(let function):
                pendingOp = Intermediate(firstOp: operand, watingOperation: function)
                buttonBinOp = true
                return nil
            case .Constant(let value):
                return value
            case .EqualOp:
                if buttonBinOp{
                    buttonBinOp = false
                    return pendingOp!.watingOperation(pendingOp!.firstOp, operand)
                }
                else{
                    return operand
                }
            case .UnaryOp(let function):
                return function(operand)
            case .RadOp:
                radOn = !radOn
//                print(radOn)
                return operand
            case .RadDeg(let function):
                if radOn{
                    return function(operand)
                }
                else{
//                    print("on")
//                    print(operand)
                    return function(operand*Double.pi/180)
                }
            }
        }
        return nil
    }
}
