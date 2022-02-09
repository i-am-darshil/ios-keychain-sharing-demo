//
//  ViewController.swift
//  TheiOSAppTemplates
//
//  Created by Duy Bui on 4/29/19.
//  Copyright © 2019 iOSTemplates. All rights reserved.
//

import UIKit
import KeychainSwift

class ViewController: UIViewController {
  @IBOutlet weak var userNameTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }

  @IBAction func didTapOnLoginButton(_ sender: Any) {
    guard let userName = self.userNameTextField.text,
      let password = self.passwordTextField.text else { return }
    
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
    
    keychain.set(userName, forKey: "userName")
    keychain.set(password, forKey: "password")
    
    // This flow is navigation. Basically, it pushes to ReadBlogsViewController
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    if let readBlogsViewController = storyboard.instantiateViewController(withIdentifier: "ReadBlogsViewController") as? ReadBlogsViewController {
      self.navigationController?.pushViewController(readBlogsViewController, animated: true)
    }
  }
}

