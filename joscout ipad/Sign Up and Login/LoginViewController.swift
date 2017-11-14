//
//  LoginViewController.swift
//  joscout ipad
//
//  Created by Daniele Lanzetta on 10.11.17.
//  Copyright © 2017 Daniele Lanzetta. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {


    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var pwField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        
        guard emailField.text != "", pwField.text != "" else { return }
        
        Auth.auth().signIn(withEmail: emailField.text! , password: pwField.text!, completion: { (user, error) in
            if let error = error {
                print(error.localizedDescription)
                
            }
            if let user = user {
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "initialView")
                self.present(vc, animated: true, completion: nil)
                
            }
            
            
            
        })
        
    }

}
