//
//  OptionSetRow.swift
//  SwiftUIDemo
//
//  Created by Rake Yang on 2021/5/12.
//

import SwiftUI

struct OptionSetRow: View {
    private let title: String
    private let subtitle: String?
    init(title: String, subtitle: String? = nil) {
        self.title = title
        self.subtitle = subtitle
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6, content: {
            Text(title).foregroundColor(.blue)
            if let subtitle = subtitle {
                Text(subtitle).font(.subheadline).opacity(0.5).lineLimit(1)
            }
        })
    }
}

struct OptionSetRow_Previews: PreviewProvider {
    static var previews: some View {
        OptionSetRow(title: "AK-47 | 野荷（崭新出厂）", subtitle: "绿色的枪身上手绘着红色的荷花。 要么没有，要么全部。圣马克镇收藏品")
    }
}
