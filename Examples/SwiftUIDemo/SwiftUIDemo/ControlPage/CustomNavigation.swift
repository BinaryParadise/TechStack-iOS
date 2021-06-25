//
//  CustomNavigation.swift
//  SwiftUIDemo
//
//  Created by Rake Yang on 2021/5/13.
//

import SwiftUI

struct NavBar: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        HStack() {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image("ic_nav_white_arrow")
            })
            .frame(width: 44, height: 44, alignment: .center)
            .padding(.leading, 6)
            Spacer()
        }
        .padding(.top, UIScreen.statusBarHeight)
    }
}

struct CustomNavigation: View {
    var body: some View {
        VStack() {
            NavBar()
                .background(Color.gray.opacity(0.6))
                .frame(width:UIScreen.main.bounds.width ,height: UIScreen.statusBarHeight + 44, alignment: .top)
            Text("你在干森莫")
                .font(.system(size: 28))
                .foregroundColor(.purple)
                .padding(8)
                .frame(minWidth:0, maxWidth: .infinity, alignment: .leading)
        }
        .background(Color.gray.opacity(0.2))
        .frame(maxHeight: .infinity)
        .navigationBarHidden(true)
    }
}

struct CustomNavigation_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigation()
    }
}
