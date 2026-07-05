//
//  ContentView.swift
//  iPad Calc
//
//  Created by Jesse Yu on 2026/7/5.
//

import SwiftUI

struct ContentView: View {
    @State private var displayText: String = "0"
    @State private var previousNumber: Double = 0
    @State private var numCount: Double = 0

    @State private var currentOperator: String = ""
    @State private var decimalCheck: Bool = false

    struct ImageButtonStyle: ButtonStyle {
        let normalImage: String
        let pressedImage: String

        func makeBody(configuration: Configuration) -> some View {
            Image(configuration.isPressed ? pressedImage : normalImage)
                .resizable()
                .scaledToFit()
        }
    }

    var body: some View {
        ZStack {
            Image("background_ipad")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(edges: .all)
            VStack {
                ZStack {
                    Image("display_panel")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 420, height: 100)
                    Spacer()
                    Text(displayText)
                        .font(.system(size: 50))
                        .foregroundStyle(Color.white)
                }
                HStack {
                    Button(action: {
                        clear()
                    }) {
                    }.buttonStyle(ImageButtonStyle(normalImage: "btn_clear_normal", pressedImage: "btn_clear_pressed"))
                        .frame(width: 100, height: 100)
                    Button(action: {
                        sign()
                    }) {
                    }.buttonStyle(ImageButtonStyle(normalImage: "btn_negate_normal", pressedImage: "btn_negate_pressed"))
                        .frame(width: 100, height: 100)
                    Button(action: {
                        clearEntry(op: "%")
                    }) {
                    }.buttonStyle(ImageButtonStyle(normalImage: "btn_pct_normal", pressedImage: "btn_pct_pressed"))
                        .frame(width: 100, height: 100)
                    Button(action: {
                        clearEntry(op: "/")
                    }) {
                    }.buttonStyle(ImageButtonStyle(normalImage: "btn_div_normal", pressedImage: "btn_div_pressed"))
                        .frame(width: 100, height: 100)
                }
                HStack {
                    Button(action: {
                        getNumber(number: 7)
                    }) {
                    }.buttonStyle(ImageButtonStyle(normalImage: "btn_7_normal", pressedImage: "btn_7_pressed"))
                        .frame(width: 100, height: 100)
                    Button(action: {
                        getNumber(number: 8)
                    }) {
                    }.buttonStyle(ImageButtonStyle(normalImage: "btn_8_normal", pressedImage: "btn_8_pressed"))
                        .frame(width: 100, height: 100)
                    Button(action: {
                        getNumber(number: 9)
                    }) {
                    }.buttonStyle(ImageButtonStyle(normalImage: "btn_9_normal", pressedImage: "btn_9_pressed"))
                        .frame(width: 100, height: 100)
                    Button(action: {
                        clearEntry(op: "*")
                    }) {
                    }.buttonStyle(ImageButtonStyle(normalImage: "btn_mul_normal", pressedImage: "btn_mul_pressed"))
                        .frame(width: 100, height: 100)
                }
                HStack {
                    Button(action: {
                        getNumber(number: 4)
                    }) {
                    }.buttonStyle(ImageButtonStyle(normalImage: "btn_4_normal", pressedImage: "btn_4_pressed"))
                        .frame(width: 100, height: 100)
                    Button(action: {
                        getNumber(number: 5)
                    }) {
                    }.buttonStyle(ImageButtonStyle(normalImage: "btn_5_normal", pressedImage: "btn_5_pressed"))
                        .frame(width: 100, height: 100)
                    Button(action: {
                        getNumber(number: 6)
                    }) {
                    }.buttonStyle(ImageButtonStyle(normalImage: "btn_6_normal", pressedImage: "btn_6_pressed"))
                        .frame(width: 100, height: 100)
                    Button(action: {
                        clearEntry(op: "-")
                    }) {
                    }.buttonStyle(ImageButtonStyle(normalImage: "btn_minus_normal", pressedImage: "btn_minus_pressed"))
                        .frame(width: 100, height: 100)
                }
                HStack {
                    Button(action: {
                        getNumber(number: 1)
                    }) {
                    }.buttonStyle(ImageButtonStyle(normalImage: "btn_1_normal", pressedImage: "btn_1_pressed"))
                        .frame(width: 100, height: 100)
                    Button(action: {
                        getNumber(number: 2)
                    }) {
                    }.buttonStyle(ImageButtonStyle(normalImage: "btn_2_normal", pressedImage: "btn_2_pressed"))
                        .frame(width: 100, height: 100)
                    Button(action: {
                        getNumber(number: 3)
                    }) {
                    }.buttonStyle(ImageButtonStyle(normalImage: "btn_3_normal", pressedImage: "btn_3_pressed"))
                        .frame(width: 100, height: 100)
                    Button(action: {
                        clearEntry(op: "+")
                    }) {
                    }.buttonStyle(ImageButtonStyle(normalImage: "btn_plus_normal", pressedImage: "btn_plus_pressed"))
                        .frame(width: 100, height: 100)
                }
                HStack(spacing: 8.5) {
                    Button(action: {
                        getNumber(number: 0)
                    }) {
                    }.buttonStyle(ImageButtonStyle(normalImage: "btn_0_normal", pressedImage: "btn_0_pressed"))
                        .frame(width: 209, height: 100)
                    HStack {
                        Button(action: {
                            decimal()
                        }) {
                        }.buttonStyle(ImageButtonStyle(normalImage: "btn_dot_normal", pressedImage: "btn_dot_pressed"))
                            .frame(width: 100, height: 100)
                        Button(action: {
                            equal()
                        }) {
                        }.buttonStyle(ImageButtonStyle(normalImage: "btn_eq_normal", pressedImage: "btn_eq_pressed"))
                            .frame(width: 100, height: 100)
                    }
                }
            }
        }
    }

    func getNumber(number: Int) {
        if displayText == "0" {
            displayText = String(number)
        } else {
            displayText += String(number)
        }
        numCount += 1
    }

    func decimal() {
        guard !decimalCheck else { return }
        displayText += "."
        decimalCheck = true
    }

    func clearEntry(op: String) {
        currentOperator = op
        previousNumber = Double(displayText) ?? 0
        displayText = "0"
        decimalCheck = false
    }

    func operation(op: String) {
        let currentValue = Double(displayText) ?? 0
        var result: Double = 0

        switch op {
        case "+":
            result = previousNumber + currentValue
        case "-":
            result = previousNumber - currentValue
        case "*":
            result = previousNumber * currentValue
        case "/":
            if currentValue != 0 {
                result = previousNumber / currentValue
            } else {
                displayText = "Error"
                return
            }
        case "%":
            if currentValue != 0 {
                result = previousNumber.truncatingRemainder(dividingBy: currentValue)
            } else {
                displayText = "Error"
                return
            }
        default:
            return
        }

        displayText = format(result)
    }

    func format(_ value: Double) -> String {
        if value == value.rounded() && abs(value) < 1e15 {
            return String(Int(value))
        } else {
            return String(value)
        }
    }

    func clear() {
        displayText = "0"
        previousNumber = 0
        numCount = 0
        currentOperator = ""
        decimalCheck = false
    }

    func sign() {
        if let value = Double(displayText) {
            displayText = format(value * -1)
        }
    }

    func equal() {
        operation(op: currentOperator)
        decimalCheck = displayText.contains(".")
    }
}

#Preview {
    ContentView()
}
