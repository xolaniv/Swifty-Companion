//
//  UserViewController.swift
//  swift_Companion
//
//  Created by Xolani VILAKAZI on 2019/10/25.
//  Copyright © 2019 Xolani VILAKAZI. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var correctionPoints: UILabel!
    @IBOutlet weak var campus: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var skillLevel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var Wallet: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var skillsTableView: UITableView!
    @IBOutlet weak var projectsTableView: UITableView!
    
    var json : JSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        skillsTableView.delegate = self
        skillsTableView.dataSource = self
        projectsTableView.dataSource = self
        projectsTableView.delegate = self
        viewInit()
        loadInfo()
        loadPhoto()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func viewInit(){
        userPhoto.layer.masksToBounds = true
        userPhoto.layer.cornerRadius = userPhoto.frame.width / 2
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 3)
        progressBar.layer.cornerRadius = progressBar.frame.height / 2
        progressBar.clipsToBounds = true
        progressBar.layer.sublayers![1].cornerRadius = progressBar.frame.height / 2
        progressBar.subviews[1].clipsToBounds = true
        skillsTableView.layer.cornerRadius = 5
        skillsTableView.clipsToBounds = true
        projectsTableView.layer.cornerRadius = 5
        projectsTableView.clipsToBounds = true
   

    }
    func loadPhoto() {
        let strUrl = json!["image_url"].string!
        if let url = URL(string: strUrl) {
            if let data = NSData(contentsOf: url){
                userPhoto.image = UIImage(data: data as Data)
            }else{
                userPhoto.image = #imageLiteral(resourceName: "wethinkcode-logo-blue")
            }
        }
    }
    
    func loadInfo() {
        if let value = json!["displayname"].string {
            fullNameLabel.text = value
        }
        
        if let value = json!["login"].string {
            userName.text = value
            
        }
        if let value = json!["wallet"].int {
           Wallet.text = "(Wallet: \(value))"
            
        }
        if let value = json!["phone"].string {
            phoneNumber.text = value
            
        }
        if let value = json!["correction_point"].int {
            correctionPoints.text = "Corrections: \(value)"
            
        }
        if let value = json!["email"].string {
            email.text = "Email: " + value
        }
        if let value = json!["cursus_users"][0]["level"].float {
            skillLevel.text = "Level: \(Int(value)) - \(Int(modf(value).1 * 100))%"
            progressBar.progress = modf(value).1
        }
        
        if let value = json!["campus"][0]["city"].string {
                campus.text = value
            }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == skillsTableView {
            return json!["cursus_users"][0]["skills"].count
        }
        else {
            return json!["projects_users"].count
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == skillsTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SkillsTableView", for: indexPath) as! UserSkillTableViewCell
            let skillName = json!["cursus_users"][0]["skills"][indexPath.row]["name"].string
            let skillLevel = json!["cursus_users"][0]["skills"][indexPath.row]["level"].float!
            
            cell.skillsLabel.text = skillName! + " - Level: " + String(skillLevel)
            cell.levelProgressBar.progress = modf(skillLevel).1
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectsTableView", for: indexPath) as! ProjectsSkillTableViewCell
            let projectName = json!["projects_users"][indexPath.row]["project"]["name"].string
            let projectMark = json!["projects_users"][indexPath.row]["final_mark"].float
            let projectStatus = json!["projects_users"][indexPath.row]["validated?"].bool
            
            switch projectStatus {
            case true:
                cell.projectOutcomeImage.image = #imageLiteral(resourceName: "passImage")
            case false:
                cell.projectOutcomeImage.image = #imageLiteral(resourceName: "failImage")
            default:
                cell.projectOutcomeImage.image = #imageLiteral(resourceName: "progressImage")
            }
            
            if (projectMark != nil) {
                cell.projectLabel.text = projectName! + " - " + String(projectName!) + "  " + "\(projectMark!)" + "%"
            }
            else {
                cell.projectLabel.text = projectName! + " - in progress"
            }
            return cell
        }
    }
    
    

}
