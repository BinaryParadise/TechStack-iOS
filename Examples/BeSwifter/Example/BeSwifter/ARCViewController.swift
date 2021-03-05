//
//  ARCViewController.swift
//  BeSwifter_Example
//
//  Created by Rake Yang on 2021/2/19.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class ARCViewController: ContentViewController {
    @IBOutlet var label1: UILabel?
    @IBOutlet var label2: UILabel?
    @IBOutlet var cycleSwitch: UISwitch?
    var knife: Knife?
    weak var picker: UIImagePickerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        knife = Knife()
        knife?.name = "AK-47"
        knife?.painting = "火蛇"
        knife?.wear = 0.2155689879
        
        knife?.matchRifle = Rifle()
        knife?.matchRifle?.name = "运动手套"
        knife?.matchRifle?.painting = "迈阿密风云"
        knife?.matchRifle?.wear = 0.15965768766
        
        // 造成循环引用
        knife?.matchRifle?.matchKnife = knife
        
        label1?.text = knife?.description
        label2?.text = knife?.matchRifle?.description
        
        let picker = UIImagePickerController()
        picker.delegate = self
        navigationController?.present(picker, animated: true, completion: nil)
        self.picker = picker
        
    }
    
    deinit {
        picker?.delegate = nil
        if cycleSwitch?.isOn ?? false {            
            knife?.matchRifle = nil
        }
    }
}

extension ARCViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
}
