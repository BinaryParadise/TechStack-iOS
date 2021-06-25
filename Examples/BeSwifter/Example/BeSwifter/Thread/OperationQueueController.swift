//
//  OperationQueueController.swift
//  BeSwifter_Example
//
//  Created by Rake Yang on 2021/6/25.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import Peregrine

class OperationQueueController: ContentViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "OperationQueue"
        
        let oq = OperationQueue()
        
        let o1 = BlockOperation(block: {
            print("1、doing \(Thread.current)")
        })
        
        let o2 = BlockOperation(block: {
            print("2、doing \(Thread.current)")
        })
        
        let o3 = BlockOperation(block: {
            print("3、doing \(Thread.current)")
        })
        
        let o4 = BlockOperation(block: {
            print("4、doing \(Thread.current)")
        })
        
        let o5 = BlockOperation {
            print("5、finished \(Thread.current)")
        }
        
        o5.addDependency(o1)
        o5.addDependency(o2)
        o5.addDependency(o3)
        o5.addDependency(o4)
        
        /*
         不使用OperationQueue
        
         o2.addDependency(o3)
        
         o1.start()
         o3.start()
         o2.start()
         o4.start()
         o5.start()
         
         */
        
        o2.addDependency(o3)
        
        oq.addOperation(o5)
        oq.addOperation(o2)
        oq.addOperation(o1)
        oq.addOperation(o4)
        oq.addOperation(o3)
        
        print("current \(Thread.current)")
    }
}


extension OperationQueueController {
    @available(*, renamed: "route", message: "swift://thread/OperationQueue")
    @objc static func operationDemo(context: RouteContext) -> Void {
        pushViewController(controller: OperationQueueController())
    }
}
