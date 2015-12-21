//
//  ViewController.swift
//  FacebookLoginUsingSwift
//
//  Created by Hardik Trivedi on 18/12/2015.
//  Copyright © 2015 TheiHartBit. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate
{

    @IBOutlet var btnFacebook: FBSDKLoginButton!
    @IBOutlet var ivUserProfileImage: UIImageView!
    @IBOutlet var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    //    MARK: ViewLifeCycle Methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        ivUserProfileImage.image = nil
        lblName.text = ""
        lblEmail.text = ""
        
        configureFacebook()
    }
    
    //    MARK: FBSDKLoginButtonDelegate Methods
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!)
    {
        FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields":"first_name, last_name, picture.type(large), email"]).startWithCompletionHandler { (connection, result, error) -> Void in
            
            let strFirstName: String = (result.objectForKey("first_name") as? String)!
            let strLastName: String = (result.objectForKey("last_name") as? String)!
            let strPictureURL: String = (result.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as? String)!
            let strEmail: String = (result.objectForKey("email") as? String)!

            self.lblName.text = "Welcome, \(strFirstName) \(strLastName)"
            self.ivUserProfileImage.image = UIImage(data: NSData(contentsOfURL: NSURL(string: strPictureURL)!)!)
            self.lblEmail.text = "Email : \(strEmail)"
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!)
    {
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logOut()
        
        ivUserProfileImage.image = nil
        lblName.text = ""
        lblEmail.text = ""
    }
    
    //    MARK: Other Methods
    
    func configureFacebook()
    {
        btnFacebook.readPermissions = ["public_profile", "email", "user_friends"];
        btnFacebook.delegate = self
    }


}

