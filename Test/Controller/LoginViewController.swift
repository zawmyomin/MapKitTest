//
//  LoginViewController.swift
//  Test
//
//  Created by Justin Zaw on 23/04/2020.
//  Copyright © 2020 Justin Zaw. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController,GIDSignInDelegate {
    
    let defaults = UserDefaults.standard
    
    let imgLogo: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .white
        img.image = UIImage(named: "loginLogo")
        img.contentMode = .scaleToFill
        
        return img
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setupLogin()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        
    }
 
    
    func setupLogin(){
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        let googleButton = GIDSignInButton(frame: CGRect(x: 0,y: 0,width: 100,height: 50))
        googleButton.center = view.center
        view.addSubview(googleButton)
        
        GIDSignIn.sharedInstance()?.delegate = self
        
        view.backgroundColor = .white
        view.addSubview(imgLogo)
        imgLogo.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: googleButton.topAnchor , right: view.rightAnchor, paddingTop: 100, paddingLeft: 20, paddingBottom: 10, paddingRight: 20, width: 0, height: 0)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if (error == nil) {
            
            self.defaults.set(true,forKey: "loginStatus")
            self.dismiss(animated: false, completion: nil)
            
            let userName:String = user.profile.name
            let userImage = user.profile.imageURL(withDimension: 100)

            defaults.set(userName, forKey: "userName")
            defaults.set(userImage, forKey: "userImage")
          
            
  
        } else {
          print("\(error.localizedDescription)")
        }
    }
    

    
   
}
