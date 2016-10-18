//
//  ViewController.swift
//  TKSwift
//
//  Created by Greg Cockroft on 9/27/16.
//  Copyright © 2016 Token Inc. All rights reserved.
//

import UIKit
import TokenSdk

class ViewController: UIViewController {
    var tokenIOAsync:TokenIOAsync?
    var tkmember:TKMemberAsync?
    var client:TKClient?
    var memberId:String?
    var key:TKSecretKey?
    let gatewayhost = "dev.api.token.io"
    let gatewayport:Int32 = 90
    //
    @IBOutlet weak var memberLabel:UILabel!
    @IBOutlet weak var usernameTextfield: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    func info(title:String, message:String) {
        let myAlert = UIAlertController(title: "Info", message: message, preferredStyle: UIAlertControllerStyle.alert)
        myAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { _ in
        })
        self.present(myAlert, animated: true, completion: nil)
    }
    
    @IBAction func createMember(_ sender : AnyObject) {
        let builder = TokenIOBuilder()!
        print("builder is this \(builder)")
        
        builder.host = gatewayhost
        builder.port = gatewayport
        
        tokenIOAsync = builder.buildAsync()
        print("tokenIOAsync is this \(tokenIOAsync)")
        
        tokenIOAsync?.createMember(nil,
                  onSucess: { (member) -> Void in
                    self.tkmember = member
                    self.memberId = member?.id
                    self.memberLabel.text = "Id: \(self.memberId)"
                    print("member is this \(self.tkmember)")
                    print("member.firstUsername should be nil is this \(self.tkmember?.firstUsername)")
            },
            onError: { (error) -> Void in
                self.info(title:"Error",message:"\(error)")
                print("createMember Error:\(error)")
            }
        )
    
    }
    
    @IBAction func addUsername(_ sender : AnyObject) {
        tkmember?.addUsername(usernameTextfield.text,
                          onSucess: { (member) -> Void in
                            self.info(title:"Info",message:"Done")
           },
                          onError: { (error) -> Void in
                            self.info(title:"Error",message:"\(error)")
                            print("addUsername Error:\(error)")
        })
    }
    
    @IBAction func removeUsername(_ sender : AnyObject) {
        tkmember?.removeUsername(usernameTextfield.text,
                           onSucess: { () -> Void in
                            self.info(title:"Info",message:"Done")
            },
                           onError: { (error) -> Void in
                            self.info(title:"Error",message:"\(error)")
                            print("removeUsername Error:\(error)")
        })
    }
    
    
}

