//
//  ViewController.swift
//  TopicExtractor
//
//  Created by rakeyang on 03/08/2020.
//  Copyright (c) 2020 rakeyang. All rights reserved.
//

import Cocoa
import Alamofire
import CocoaLumberjack

class ViewController: NSViewController {

    override func viewDidLoad() {
    super.viewDidLoad()    
    // Do any additional setup after loading the view.
    

    }
    
    @IBAction func loginCMR(_ sender: NSButton) {
        let login = NSWindow.init(contentViewController: LoginViewController.init())
        login.center()
        login.orderFront(nil)
    }
    
    @IBAction func fetchTopic(_ sender: Any) {
        Alamofire.request("/student/acourse/HomeworkCenter/InstantRnd.asp?CourseID=bk134a&CID=05190001").responseData { (response) in
            DDLogDebug("\(response)")
        }
        var mrequest = URLRequest.init(url: URL.init(string: "https://y.neverland.life/api")!) as? NSMutableURLRequest
        mrequest?.httpMethod = "POST"
        mrequest?.httpBody = "fjlaifajeligjsleijgslejg".data(using: String.Encoding.utf8)
        var dataTask = URLSession.shared.dataTask(with: mrequest as! URLRequest)
        dataTask.resume()
    }
    
  override var representedObject: Any? {
    didSet {
    // Update the view, if already loaded.
    }
  }


}

