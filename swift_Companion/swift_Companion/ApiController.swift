//
//  ApiController.swift
//  swift_Companion
//
//  Created by Xolani VILAKAZI on 2019/10/24.
//  Copyright © 2019 Xolani VILAKAZI. All rights reserved.
//


import Foundation
import Alamofire
import SwiftyJSON


struct globals {
    static var token: String!
    static var jsonResponse: JSON!
}


public class ApiController : NSObject
{
    /*//  MARK: - API TOKEN and Validation
    
    // create a token
    var token = String()
    
    //API set up
    let url = "https://api.intra.42.fr/oauth/token"
    let config = [
           "grant_type" : "client_credentials",
           "client_id": "43454d0a0e13347f7ab7e72ab9c14eec1d6285a8d9699e60f6ae7b79c332b3e2",
           "client_secret": "b2fe5d44ff3148a6a876a696b13291b854f974600d3862d1d53b01c2310ea793"]
    
    
    
    //  MARK: - Retrieve Tokens
    func getToken(){
        /*Function to get user token from the api*/
        
        
        
        let verif = UserDefaults.standard.object(forKey: "token")
        if verif == nil {
            Alamofire.request(url, method: .post , parameters: config).validate().responseJSON {
            response in
                
            switch response.result {
            case .success(_):
                if let value = response.result.value {
                    let json = JSON(value)
                    self.token = json["access_token"].stringValue
                    UserDefaults.standard.set(json["access_token"].stringValue, forKey: "token")
                    print("Token created ", self.token)
                    self.checkToken()
                    
                }
            case .failure(let error):
                print(error)
                }
            }
        } else {
            self.token = verif as! String
            print("SAME token:", self.token)
            //verifyToken()
            
        }
    }
    
    private func checkToken() {
        let url = URL(string: "https://api.intra.42.fr/oauth/token/info")
        let bearer = "Bearer " + self.token
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue(bearer, forHTTPHeaderField: "Authorization")
        Alamofire.request(request as URLRequestConvertible).validate().responseJSON {
            response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("The token will expire in:", json["expires_in_seconds"], "seconds.")
                }
            case .failure:
                print("Error: Trying to get a new token...")
                UserDefaults.standard.removeObject(forKey: "token")
                self.getToken()
            }
        }
    }
    /*private func verifyToken() {
        let checkUrl = URL(string: "https://api.intra.42.fr/oauth/token/info")
        let bearer = "Bearer" + self.token
        let request = NSMutableURLRequest(url: checkUrl!)
        request.httpMethod = "GET"
        request.setValue(bearer, forHTTPHeaderField: "Authorization")
        Alamofire.request(request as! URLRequestConvertible).validate().responseJSON {
            response in
            
            switch response.result {
                
            case .success(_):
                if let value = response.result.value {
                   let json = JSON(value)
                    print("Access token expires in", json["expires_in_seconds"], "seonds")
                }
            case .failure(_):
                print("Error in getting token")
                UserDefaults.standard.removeObject(forKey: "token")
                self.getToken()
            }
        }
        
    }*/
      //  MARK: - Retrieve UserJson data
    
    func verifyUsers(_ user: String, completion: @escaping (JSON) -> Void) {
        
        let user = URL(string: "https://api.intra.42.fr/v2/users/" + user)
        let bearer = "Bearer" + self.token
        var request = URLRequest(url: user!)
        request.httpMethod = "GET"
        request.setValue(bearer, forHTTPHeaderField: "Authorization")
        
        Alamofire.request(request as URLRequestConvertible).validate().responseJSON {
            response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(json)
                    completion(json)
                }
            case .failure:
                print("Error this login does not eixst")
            }
        }
  
    }*/
    var token = String()
    let url = "https://api.intra.42.fr/oauth/token"
    let config = [
        "grant_type": "client_credentials",
        "client_id": "43454d0a0e13347f7ab7e72ab9c14eec1d6285a8d9699e60f6ae7b79c332b3e2",
        "client_secret": "b2fe5d44ff3148a6a876a696b13291b854f974600d3862d1d53b01c2310ea793"]

    func getToken() {
        let verify = UserDefaults.standard.object(forKey: "token")
        if verify == nil {
            Alamofire.request(url, method: .post, parameters: config).validate().responseJSON {
                response in
                switch response.result {
                case .success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        self.token = json["access_token"].stringValue
                        UserDefaults.standard.set(json["access_token"].stringValue, forKey: "token")
                        print("NEW token:", self.token)
                        globals.token = self.token as String?
                        self.checkToken()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            self.token = verify as! String
            print("SAME token:", self.token)
            checkToken()
        }
    }
    
     func checkToken() {
        let url = URL(string: "https://api.intra.42.fr/oauth/token/info")
        let bearer = "Bearer " + self.token
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue(bearer, forHTTPHeaderField: "Authorization")
        Alamofire.request(request as URLRequestConvertible).validate().responseJSON {
            response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print("The token will expire in:", json["expires_in_seconds"], "seconds.")
                }
            case .failure:
                print("Error: Trying to get a new token...")
                UserDefaults.standard.removeObject(forKey: "token")
                self.getToken()
            }
        }
    }
    
    func checkUser(_ user: String, completion: @escaping (JSON?) -> Void) {
        getToken()
        let userUrl = URL(string: "https://api.intra.42.fr/v2/users/" + user)
        let bearer = "Bearer " + self.token
        var request  = URLRequest(url: userUrl!)
        request.httpMethod = "GET"
        request.setValue(bearer, forHTTPHeaderField: "Authorization")
        
        print(self.token + "<<<")
        Alamofire.request(request as URLRequestConvertible).validate().responseJSON {
            
            response in
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(json.stringValue)
                    completion(json)
                }
    
            case .failure:
                print(response.result)
                completion(nil)
                print("Error: This login doesn't exists")
            }
        }
    }
}
