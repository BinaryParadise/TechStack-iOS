//
//  TextFieldPage.swift
//  SwiftUIDemo
//
//  Created by Rake Yang on 2021/5/12.
//

import SwiftUI

struct TextFieldPage: View {
    @State var name: String = ""
    var body: some View {
        HStack(spacing: 15) {
            Text("账号：").foregroundColor(.secondary)
            TextField("", text: $name)
        }
        .padding(10)
        .frame(height: 50)
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

struct TextFieldPage_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldPage()
    }
}
