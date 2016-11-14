//
//  ViewController.swift
//  Sample Login
//
//  Created by phong on 11/14/16.
//  Copyright © 2016 tpalwayscreative. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
class ViewController: UIViewController, LoginButtonDelegate {

    @IBOutlet weak var btnAction: UIButton!
    @IBOutlet weak var uiStackView: UIStackView!
    @IBOutlet weak var lbShow: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let loginButton = LoginButton(readPermissions: [ .publicProfile, .email, .userFriends ])
        loginButton.center = view.center
        loginButton.delegate = self
        uiStackView.insertArrangedSubview(loginButton, at: 0)
        
        if AccessToken.current != nil {
            
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name,last_name, picture.type(large),email,updated_time"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    
                    if let userDict = result as? NSDictionary {
                        
                        let first_Name = userDict["first_name"] as! String
                        let last_Name = userDict["last_name"] as! String
                        let id = userDict["id"] as! String
                        let email = userDict["email"] as! String
                        print(first_Name)
                        print(last_Name)
                        print(id)
                        print(email)
                        print(userDict)
                        self.lbShow.text = "Hi " + first_Name
                        self.show(active : true,name:first_Name)
                    }
                }
            })
        }
        else{
            self.show(active : false,name :"Login By Facebook")
        }
    }
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
       
        
        switch result {
        case .failed(let error):
            print(error)
        case .cancelled:
            print("User cancelled login.")
        case .success(let grantedPermissions, let declinedPermissions, let accessToken):
            print("Logged in!")
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name,last_name, picture.type(large),email,updated_time"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    
                    if let userDict = result as? NSDictionary {
                        let first_Name = userDict["first_name"] as! String
                        let last_Name = userDict["last_name"] as! String
                        let id = userDict["id"] as! String
                        let email = userDict["email"] as! String
                        print(first_Name)
                        print(last_Name)
                        print(id)
                        print(email)
                        print(userDict)
                        self.lbShow.text = "Hi " + first_Name
                        self.show(active : true,name:first_Name)
                    }
                }
            })
        }
        

    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        
        show(active : false,name : "Login by Facebook")
        print("User Logged Out")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /* Custom UI login */

    @IBAction func btnAction(_ sender: UIButton) {
        
        let loginManager = LoginManager()
        if AccessToken.current == nil {
            
            loginManager.logIn([ .publicProfile,.email,.userFriends ], viewController: self) { loginResult in
                switch loginResult {
                case .failed(let error):
                    print(error)
                case .cancelled:
                    print("User cancelled login.")
                case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                    print("Logged in!")
                    
                    FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name,last_name, picture.type(large),email,updated_time"]).start(completionHandler: { (connection, result, error) -> Void in
                        if (error == nil){
                            
                            if let userDict = result as? NSDictionary {
                                
                                let first_Name = userDict["first_name"] as! String
                                let last_Name = userDict["last_name"] as! String
                                let id = userDict["id"] as! String
                                let email = userDict["email"] as! String
                                print(first_Name)
                                print(last_Name)
                                print(id)
                                print(email)
                                
                                print(userDict)
                                self.lbShow.text = "Hi " + first_Name
                                self.show(active : true,name:first_Name)
                                
                            }
                        }
                    })
                }
            }
        }else{
            
            loginManager.logOut()
            show(active : false,name:"Login by Facebook")
        }
        
        
    }
    
    func show(active : Bool,name : String){
        
        if active{
            
            self.btnAction.setTitle("Log Out", for: .normal)
            self.lbShow.text = "Hi " + name
        }
        else{
            
            self.btnAction.setTitle("Custom Login", for: .normal)
            self.lbShow.text = name
        }
        
    }
    

}

