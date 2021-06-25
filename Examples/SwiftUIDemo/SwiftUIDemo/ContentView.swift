//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by Rake Yang on 2021/5/12.
//

import SwiftUI

struct ContentView: View {
    @State var toggle: Bool = false
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("基础控件")) {
                    NavigationLink(
                        destination: Text("只读的多行文本").lineLimit(2),
                        label: {
                            OptionSetRow(title: "Text", subtitle: "展示一行或多行只读文本")
                        })
                    NavigationLink(
                        destination: TextFieldPage(),
                        label: {
                            OptionSetRow(title: "TextField", subtitle: "展示可编辑的文本输入控件")
                        })
                    NavigationLink(
                        destination: Image("yuqi1"),
                        label: {
                            OptionSetRow(title: "Image", subtitle: "展示本地图片")
                        }
                    )
                    NavigationLink(
                        destination: WebImagePage(),
                        label: {
                            OptionSetRow(title: "WebImage", subtitle: "展示网络图片")
                        }
                    )
                    NavigationLink(
                        destination: Button("点一下试试", action: {
                            print("按钮点击了")
                        }),
                        label: {
                            OptionSetRow(title: "Button", subtitle: "按钮")
                        }
                    )
                    NavigationLink(
                        destination: Toggle("开关状态", isOn: $toggle),
                        label: {
                            OptionSetRow(title: "Toggle", subtitle: "开关状态切换")
                        })
                }
                Section(header: Text("自定义控件")) {
                    NavigationLink(
                        destination: Calculator()
                            .environmentObject(CalculatorModel()),
                        label: {
                            OptionSetRow(title: "CalculatorView", subtitle: "自定义简易计算器")
                        }
                    )
                    NavigationLink(
                        destination: CustomNavigation(),
                        label: {
                            OptionSetRow(title: "CustomNavigation", subtitle: "自定义导航栏控件")
                        })
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("SwiftUI Demo")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}
