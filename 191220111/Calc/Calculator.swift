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
        case UnaryOp((Double)->Double?)
        case BinaryOp((Double,Double)->Double)
        case EqualOp
        case Constant(Double)
        case RadOp
        case RadDeg((Double)->Double)
        case FactOp
        case RadDeg2nd((Double)->Double)
        case MOp
    }
    
//    memory for m+,m-,mr
    var memoryM:Double = 0
    
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
        "sinh": Operation.UnaryOp{
            op in
            return sinh(op)
        },
        "cosh": Operation.UnaryOp{
            op in
            return cosh(op)
        },
        "tanh": Operation.UnaryOp{
            op in
            return tanh(op)
        },
        "Rad": Operation.RadOp,
        "x!": Operation.FactOp,
        "2√x": Operation.UnaryOp{
            op in
            return sqrt(op)
        },
        "∛x": Operation.UnaryOp{
            op in
            return pow(op, 1/3)
        },
        "x^2": Operation.UnaryOp{
            op in
            return pow(op, 2)
        },
        "x^3": Operation.UnaryOp{
            op in
            return pow(op, 3)
        },
        "10^x": Operation.UnaryOp{
            op in
            return pow(10, op)
        },
        "e^x": Operation.UnaryOp{
            op in
            return exp(op)
        },
        "ln": Operation.UnaryOp{
            op in
            return log(op)
        },
        "e": Operation.Constant(M_E),
        "㏒10": Operation.UnaryOp{
            op in
            return log10(op)
        },
        "EE": Operation.BinaryOp{
            (op1, op2) in
            return op1*pow(10, op2)
        },
        "x^y": Operation.BinaryOp{
            (op1, op2) in
            return pow(op1, op2)
        },
        "y√x": Operation.BinaryOp{
            (op1, op2) in
            return pow(op1, 1/op2)
        },
        "sin-1": Operation.RadDeg2nd{
            op in
            return asin(op)
        },
        "cos-1": Operation.RadDeg2nd{
            op in
            return acos(op)
        },
        "tan-1": Operation.RadDeg2nd{
            op in
            return atan(op)
        },
        "2^x": Operation.UnaryOp{
            op in
            return pow(2, op)
        },
        "y^x": Operation.BinaryOp{
            (op1, op2) in
            return pow(op2, op1)
        },
        "logy": Operation.BinaryOp{
            (op1, op2) in
            return log(op1)/log(op2)
        },
        "log2": Operation.UnaryOp{
            op in
            return log2(op)
        },
        "sinh-1": Operation.UnaryOp{
            op in
            return asinh(op)
        },
        "cosh-1": Operation.UnaryOp{
            op in
            return acosh(op)
        },
        "tanh-1": Operation.UnaryOp{
            op in
            return atanh(op)
        },
        "mc": Operation.MOp,
        "m+": Operation.MOp,
        "m-": Operation.MOp,
        "mr": Operation.MOp
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
            case .RadDeg2nd(let function):
                if radOn{
                    return function(operand)
                }
                else{
//                    print("on")
//                    print(operand)
                    return function(operand)/Double.pi*180
                }
            case .FactOp:
//                print(operand)
                return factorial(N: operand)
            case .MOp:
                return memoryMode(mode: operation, N: operand)
            }
        }
        return nil
    }
    
    func memoryMode(mode: String, N: Double)->Double? {
        if mode == "mc"{
            memoryM = 0
        }
        else if mode == "m+"{
            memoryM = memoryM + N
        }
        else if mode == "m-"{
            memoryM = memoryM - N
        }
        else if mode == "mr"{
            return memoryM
        }
        else{
            return nil
        }
        return nil
    }
    
    func factorial(N: Double)->Double? {
        if N==0{
            return 1
        }
        else if N > 0{
            if N != floor(N){
                return nil
            }
            else{
                let intN = Int(N)
                var array:Array<Int> = []
                for i in 1...intN {
                    array.append(i)
                }
                return Double(array.reduce(1) {$0*$1})
            }
        }
        else{
            if N != floor(N){
                return nil
            }
            else{
                let res = factorial(N: -N)!
                return -res
            }
        }
    }
}
