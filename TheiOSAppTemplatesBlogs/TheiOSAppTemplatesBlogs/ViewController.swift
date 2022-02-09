//
//  ViewController.swift
//  TheiOSAppTemplatesBlogs
//
//  Created by Duy Bui on 4/29/19.
//  Copyright © 2019 iOSTemplates. All rights reserved.
//

import UIKit
import KeychainSwift

class ViewController: UIViewController {

//  @IBOutlet weak var keychainLabel: UILabel!
    
    @IBOutlet weak var keychainLabel: UITextField!
    override func viewDidLoad() {
    super.viewDidLoad()
    
    let keychain = KeychainSwift()
 
    
//    Problem
    //    keychain.accessGroup = "com.darshil.keychain-demo"
    //    Feb  8 20:26:02 securityd[114] <Notice>: TheiOSAppTemplat[1678]/1#4 LF=0 add Error Domain=NSOSStatusErrorDomain Code=-34018 "Client explicitly specifies access group com.darshil.keychain-demo but is only entitled for (
    //        "8XPT93F9Q7.com.darshil.keychain-demo",
    //        "8XPT93F9Q7.com.darshil.keychain-demo-main"
    //    )"
        
    //    Fix
        let appIdentifierPrefix =
            Bundle.main.infoDictionary!["AppIdentifierPrefix"] as! String
    
//        Local
//    keychain.accessGroup = "\(appIdentifierPrefix)com.darshil.keychain-demo"
        
//        Browserstack
        keychain.accessGroup = "\(appIdentifierPrefix)*"
    
    print("accessGroup : \(keychain.accessGroup!)")

    if let userName = keychain.get("userName"),
      let password = keychain.get("password") {
        print("The username is \(userName) and the password is \(password)")
        keychainLabel.text = "The username is \(userName) and the password is \(password)"
        keychainLabel.sizeToFit()
    }
    print("Reached after")
  }


}

