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
    @IBOutlet weak var aliasTextfield: UITextField!

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
                    print("member.firstAlias should be nil is this \(self.tkmember?.firstAlias)")
            },
            onError: { (error) -> Void in
                self.info(title:"Error",message:"\(error)")
                print("createMember Error:\(error)")
            }
        )
    
    }
    
    @IBAction func addAlias(_ sender : AnyObject) {
        tkmember?.addAlias(aliasTextfield.text,
                          onSucess: { (member) -> Void in
                            self.info(title:"Info",message:"Done")
           },
                          onError: { (error) -> Void in
                            self.info(title:"Error",message:"\(error)")
                            print("addAlias Error:\(error)")
        })
    }
    
    @IBAction func removeAlias(_ sender : AnyObject) {
        tkmember?.removeAlias(aliasTextfield.text,
                           onSucess: { () -> Void in
                            self.info(title:"Info",message:"Done")
            },
                           onError: { (error) -> Void in
                            self.info(title:"Error",message:"\(error)")
                            print("removeAlias Error:\(error)")
        })
    }
    
    
}

