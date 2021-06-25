//
//  UIStackViewController.swift
//  BeSwifter_Example
//
//  Created by Rake Yang on 2021/6/8.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import Peregrine

class UIStackViewController: ContentViewController {
    
    @available(*, renamed: "route", message: "swift://UIKit/UIStackView")
    @objc static func stackView(context: RouteContext) -> Void {
        let vc = UIStoryboard(name: "UIKit", bundle: Bundle.main).instantiateViewController(withIdentifier: "UIStackViewController")
        pushViewController(controller: vc)
    }
}
