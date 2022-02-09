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
        
        // Approach 2 block starts
        
        var appIdentifierPrefix = ""
        
        let queryLoad: [String: AnyObject] = [
                    kSecClass as String: kSecClassGenericPassword,
                    kSecAttrAccount as String: "bundleSeedID" as AnyObject,
                    kSecAttrService as String: "" as AnyObject,
                    kSecReturnAttributes as String: kCFBooleanTrue
                ]
        var result : AnyObject?
                var status = withUnsafeMutablePointer(to: &result) {
                    SecItemCopyMatching(queryLoad as CFDictionary, UnsafeMutablePointer($0))
                }

                if status == errSecItemNotFound {
                    status = withUnsafeMutablePointer(to: &result) {
                        SecItemAdd(queryLoad as CFDictionary, UnsafeMutablePointer($0))
                    }
                }
        
        if status == noErr {
                    if let resultDict = result as? [String: Any], let accessGroup = resultDict[kSecAttrAccessGroup as String] as? String {
                        let components = accessGroup.components(separatedBy: ".")
    //                    return components.first
                        appIdentifierPrefix = components.first!
                        print("kSecAttrAccessGroup components.first : \(components.first!)")
                    }else {
    //                    return nil
                        print("kSecAttrAccessGroup : Not found")
                    }
                } else {
                    print("Error getting bundleSeedID to Keychain")
    //                return nil
                    print("kSecAttrAccessGroup : Not found")
                }
        
        print("kSecAttrAccessGroup Done")
        
        // Approach 2 block ends
        
        
        // Approach 1 block starts
 
    
//    Problem
    //    keychain.accessGroup = "com.darshil.keychain-demo"
    //    Feb  8 20:26:02 securityd[114] <Notice>: TheiOSAppTemplat[1678]/1#4 LF=0 add Error Domain=NSOSStatusErrorDomain Code=-34018 "Client explicitly specifies access group com.darshil.keychain-demo but is only entitled for (
    //        "8XPT93F9Q7.com.darshil.keychain-demo",
    //        "8XPT93F9Q7.com.darshil.keychain-demo-main"
    //    )"
        
    //    Fix
//        let appIdentifierPrefix =
//            Bundle.main.infoDictionary!["AppIdentifierPrefix"] as! String
//
////        Local
////    keychain.accessGroup = "\(appIdentifierPrefix)com.darshil.keychain-demo"
//
//
////        Browserstack
//        keychain.accessGroup = "\(appIdentifierPrefix)*" // Approach 1
        
        // Approach 1 block ends
        
        keychain.accessGroup = "\(appIdentifierPrefix).*" // Approach 2
    
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

