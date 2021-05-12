//
//  WebImagePage.swift
//  SwiftUIDemo
//
//  Created by Rake Yang on 2021/5/12.
//

import SwiftUI
import SDWebImageSwiftUI

struct WebImagePage: View {
    var body: some View {
        WebImage(url: URL(string: "https://c-ssl.duitang.com/uploads/item/201808/18/20180818104948_mykoh.png"))
        .placeholder(Image("yuqi3"))
        .frame(width: 300, height: 300)
        .aspectRatio(contentMode: .fit)
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        .clipped()
        .foregroundColor(.gray)
    }
}
