//
//  CalculatorModel.swift
//  SwiftUIDemo
//
//  Created by Rake Yang on 2021/5/12.
//

import Foundation

class CalculatorModel: ObservableObject {
    @Published var logic: Logic = .left("0")
    @Published var history: [CalculatorButtonItem] = []
    
    var temporaryKept: [CalculatorButtonItem] = []

    func apply(_ item: CalculatorButtonItem) {
        //TODO:连续点击等于
        logic = logic.apply(item: item)
        history.append(item)

        temporaryKept.removeAll()
        slidingIndex = Float(totalCount)
    }

    var historyDetail: String {
        history.map { $0.title }.joined()
    }

    func keepHistory(upTo index: Int) {
        precondition(index <= totalCount, "Out of index.")

        let total = history + temporaryKept

        history = Array(total[..<index])
        temporaryKept = Array(total[index...])

        logic = history.reduce(Logic.left("0")) {
            result, item in
            result.apply(item: item)
        }
    }

    var totalCount: Int {
        history.count + temporaryKept.count
    }

    var slidingIndex: Float = 0 {
        didSet {
            keepHistory(upTo: Int(slidingIndex))
        }
    }
}

enum Logic {
    case left(String)
    case leftOp(left: String, op: CalculatorButtonItem.Op)
    case leftOpRight(left: String, op: CalculatorButtonItem.Op, right: String)
    case result(String)
    case error
    
    @discardableResult
    func apply(item: CalculatorButtonItem) -> Logic {
        switch item {
        case .digit(let num):
            return apply(num: num)
        case .dot:
            return applyDot()
        case .op(let op):
            return apply(op: op)
        case .command(let command):
            return apply(command: command)
        }
    }

    var output: String {
        let result: String
        switch self {
        case .left(let left): result = left
        case .leftOp(let left, _): result = left
        case .leftOpRight(_, _, let right): result = right
        case .result(let res): result = res
        case .error: return "Error"
        }
        guard let value = Double(result) else {
            return "Error"
        }
        return formatter.string(from: value as NSNumber)!
    }

    private func apply(num: Int) -> Logic {
        switch self {
        case .left(let left):
            return .left(left.apply(num: num))
        case .leftOp(let left, let op):
            return .leftOpRight(left: left, op: op, right: "0".apply(num: num))
        case .leftOpRight(let left, let op, let right):
            return .leftOpRight(left: left, op: op, right: right.apply(num: num))
        case .result(_):
            return .left("0".apply(num: num))
        case .error:
            return .left("0".apply(num: num))
        }
    }

    private func applyDot() -> Logic {
        switch self {
        case .left(let left):
            return .left(left.applyDot())
        case .leftOp(let left, let op):
            return .leftOpRight(left: left, op: op, right: "0".applyDot())
        case .leftOpRight(let left, let op, let right):
            return .leftOpRight(left: left, op: op, right: right.applyDot())
        case .result(_):
            return .left("0".applyDot())
        case .error:
            return .left("0".applyDot())
        }
    }

    private func apply(op: CalculatorButtonItem.Op) -> Logic {
        switch self {
        case .left(let left):
            switch op {
            case .plus, .minus, .multiply, .divide:
                return .leftOp(left: left, op: op)
            case .equal:
                return .result(left)
            }
        case .leftOp(let left, let currentOp):
            switch op {
            case .plus, .minus, .multiply, .divide:
                return .leftOp(left: left, op: op)
            case .equal:
                if let result = currentOp.calculate(l: left, r: left) {
                    return .leftOp(left: result, op: currentOp)
                } else {
                    return .error
                }
            }
        case .leftOpRight(let left, let currentOp, let right):
            switch op {
            case .plus, .minus, .multiply, .divide:
                if let result = currentOp.calculate(l: left, r: right) {
                    return .leftOp(left: result, op: op)
                } else {
                    return .error
                }
            case .equal:
                if let result = currentOp.calculate(l: left, r: right) {
                    return .result(result)
                } else {
                    return .error
                }
            }
        case .result(let res):
            switch op {
            case .plus, .minus, .multiply, .divide:
                return .leftOp(left: res, op: op)
            case .equal:
                return self
            }
        
        case .error:
            return self
        }
    }

    private func apply(command: CalculatorButtonItem.Command) -> Logic {
        switch command {
        case .clear:
            return .left("0")
        case .flip:
            switch self {
            case .left(let left):
                return .left(left.flipped())
            case .leftOp(let left, let op):
                return .leftOpRight(left: left, op: op, right: "-0")
            case .leftOpRight(left: let left, let op, let right):
                return .leftOpRight(left: left, op: op, right: right.flipped())
            case .error:
                return .left("-0")
            case .result(let result):
                return .result(result.flipped())
            }
        case .percent:
            switch self {
            case .left(let left):
                return .left(left.percentaged())
            case .leftOp(let left, let currentOp):
                switch currentOp {
                case .plus,.minus:
                var result : Double
                let a = Double(String(left))
                result = a! * a!
                return .leftOp(left:(String(result).percentaged()) , op: currentOp)
            case .divide,.multiply:
                return .leftOp(left: left.percentaged(), op: currentOp)
            case .equal:
                return.result(left.percentaged())
                }
            case .leftOpRight(left: let left, let op, let right):
                return .leftOpRight(left: left, op: op, right: right.percentaged())
            case .error:
                return .left("-0")
            case .result(let result):
                return .result(result.percentaged())
            }
        }
    }
}

var formatter: NumberFormatter = {
    let f = NumberFormatter()
    f.minimumFractionDigits = 0
    f.maximumFractionDigits = 8
    f.numberStyle = .decimal
    return f
}()


extension String {
    var containsDot: Bool {
        return contains(".")
    }

    var startWithNegative: Bool {
        return starts(with: "-")
    }

    func apply(num: Int) -> String {
        return self == "0" ? "\(num)" : "\(self)\(num)"
    }

    func applyDot() -> String {
        return containsDot ? self : "\(self)."
    }

    func flipped() -> String {
        if startWithNegative {
            var s = self
            s.removeFirst()
            return s
        } else {
            return "-\(self)"
        }
    }

    func percentaged() -> String {
        return String(Double(self)! / 100)
    }
}

extension CalculatorButtonItem.Op {
    func calculate(l: String, r: String) -> String? {

        guard let left = Double(l), let right = Double(r) else {
            return nil
        }

        let result: Double?
        switch self {
        case .plus: result = left + right
        case .minus: result = left - right
        case .multiply: result = left * right
        case .divide: result = right == 0 ? nil : left / right
        case .equal: fatalError()
        }
        return result.map { String($0) }
    }
}
