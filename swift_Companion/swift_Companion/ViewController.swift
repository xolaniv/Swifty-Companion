//
//  ViewController.swift
//  swift_Companion
//
//  Created by Xolani VILAKAZI on 2019/10/22.
//  Copyright © 2019 Xolani VILAKAZI. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
   
    @IBOutlet weak var searchBox: UITextField!
    var jsonData : JSON?
    var auth = ApiController()
    @IBOutlet weak var searchButton: UIButton!
    
    let apiController = ApiController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        apiController.getToken()
    }
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func getApi(_ sender: Any) {
        if let text = searchBox.text, !text.isEmpty {
            auth.checkUser(text.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)){
                completion in
                if completion != nil {
                    self.jsonData = completion
                    DispatchQueue.main.async {
                        //print(self.jsonData as Any)
                        //print(completion as Any)
                        self.performSegue(withIdentifier: "Profile", sender: nil)
                        
                    }
                }
                else{
                    self.errorPopUp()
                    
                }
                
            }
            
        }
        else {
            self.errorPopUp()
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func searchUsersButton(_ sender: Any) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Profile" {
            let new = segue.destination as! UserViewController
            new.json = jsonData
        }
        
    }
    
    func errorPopUp()
      {
          var alert = UIAlertController()
        
          let message = "The username:  " + self.searchBox.text! + " was not found. Please try again..."
          if self.searchBox.text?.isEmpty ?? true
          {
              alert = UIAlertController(title: "No Username", message: "Username text field can't be empty!", preferredStyle: .alert)
          }
          else
          {
              alert = UIAlertController(title: "Username Error", message: message, preferredStyle: .alert)
          }
          alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
          self.present(alert, animated: true)
      }
    
}
    

 

