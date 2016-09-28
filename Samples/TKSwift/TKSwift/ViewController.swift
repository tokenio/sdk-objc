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
        createMember()
    }
    
    
    func createMember() {
        let builder = TokenIOBuilder()!
        print("builder is this \(builder)")
        
        builder.host = "dev.api.token.io";
        builder.port = 90;
        
        tokenIOAsync = builder.buildAsync()
        print("tokenIOAsync is this \(tokenIOAsync)")
        
        tokenIOAsync?.createMember("GREG982314",
                  onSucess: { (member) -> Void in
                    print("member is this \(member)")
                    print("member.firstAlias is this \(member?.firstAlias)")
            },
            onError: { (error) -> Void in
                print("createMember Error:\(error)")
            }
        )
    
    }
    
    
    
    // dev.api.token.io 91 bank
    
    //let bank = TKBankClient.bankClientWithHost("dev.api.token.io",port:91)
    

}

