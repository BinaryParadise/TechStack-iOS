//
//  Calculator.swift
//  SwiftUIDemo
//
//  Created by Rake Yang on 2021/5/12.
//

import SwiftUI

struct Calculator: View {
    @EnvironmentObject var model: CalculatorModel
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            Text(self.model.logic.output)
                .font(.system(size: 76))
                .minimumScaleFactor(0.5)
                .padding(.horizontal, 24.ratio)
                .lineLimit(1)
                .frame(minWidth: 0,
                       maxWidth: .infinity,
                       alignment: .trailing)
            CalculatorPad()
                .padding(.bottom)
        }
        .navigationTitle("计算器")
    }
}

extension CGFloat {
    var ratio: CGFloat {
        return self * UIScreen.main.bounds.width / 375.0
    }
}

extension Double {
    var ratio: CGFloat {
        return CGFloat(self).ratio
    }
}

enum CalculatorButtonItem: Hashable {
    enum Op: String {
        case plus = "+"
        case minus = "-"
        case divide = "÷"
        case multiply = "x"
        case equal = "="
    }
    
    enum Command: String {
        case clear = "AC"
        case flip = "+/-"
        case percent = "%"
    }
    
    case digit(Int)
    case dot
    case op(Op)
    case command(Command)
}

extension CalculatorButtonItem {
    var title: String {
        switch self {
        case .digit(let value):
            return String(value)
        case .dot:
            return "."
        case .op(let op):
            return op.rawValue
        case .command(let cmd):
            return cmd.rawValue
        }
    }
    var size: CGSize {
        if case .digit(let value) = self, value == 0 {
            return CGSize(width: 80 * 2 + 8, height: 80)
        }
        return CGSize(width: 80, height: 80)
    }
    
    var backgroundColor: Color {
        switch self {
        case .digit, .dot:
            return Color("digitBackground")
        case .op:
            return Color("operatorBackground")
        case .command(_):
            return Color("commandBackground")
        }
    }

    var foregroundColor: Color {
        switch self {
        case .command(_):
            return Color("commandForeground")
        default:
            return .white
        }
    }
}

struct CalculatorPad: View {
    let pad: [[CalculatorButtonItem]] = [
        [.command(.clear), .command(.flip), .command(.percent), .op(.divide)],
        [.digit(7), .digit(8), .digit(9), .op(.multiply)],
        [.digit(4), .digit(5), .digit(6), .op(.minus)],
        [.digit(1), .digit(2), .digit(3), .op(.plus)],
        [.digit(0), .dot, .op(.equal)]
    ]
    var body: some View {
        VStack(spacing: 8) {
            ForEach(pad, id: \.self) { row in
                ButtonRow(row: row)
            }
        }
    }
}

struct CalculatorButton: View {
    let fontSize: CGFloat = 38
    let item: CalculatorButtonItem
    let action: () -> Void
    var body: some View {
        Button(action: action, label: {
            Text(item.title)
                .font(.system(size: fontSize.ratio))
                .frame(width: item.size.width.ratio, height: item.size.height.ratio)
                .background(item.backgroundColor)
                .foregroundColor(item.foregroundColor)
                .cornerRadius(item.size.width.ratio / 2)
        })
    }
}

struct ButtonRow: View {
    let row: [CalculatorButtonItem]
    @EnvironmentObject var model: CalculatorModel
    var body: some View {
        HStack {
            ForEach(row, id: \.self) { item in
                CalculatorButton(item: item) {
                    self.model.apply(item)
                }
            }
        }
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        Calculator().environmentObject(CalculatorModel())
    }
}
