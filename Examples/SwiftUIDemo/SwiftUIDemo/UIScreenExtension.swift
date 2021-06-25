//
//  UIScreenExtension.swift
//  SwiftUIDemo
//
//  Created by Rake Yang on 2021/5/13.
//

import UIKit

extension UIScreen {
    static var statusBarHeight: CGFloat {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return 20 }
        return windowScene.statusBarManager?.statusBarFrame.height ?? 20
    }
}
