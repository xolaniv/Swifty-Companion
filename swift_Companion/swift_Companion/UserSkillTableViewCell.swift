//
//  UserSkillTableViewCell.swift
//  swift_Companion
//
//  Created by Xolani VILAKAZI on 2019/11/12.
//  Copyright © 2019 Xolani VILAKAZI. All rights reserved.
//

import UIKit

class UserSkillTableViewCell: UITableViewCell {
     
    @IBOutlet weak var levelProgressBar: UIProgressView!
    @IBOutlet weak var skillsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        levelProgressBar.transform = levelProgressBar.transform.scaledBy(x: 1, y: 2)
        levelProgressBar.layer.cornerRadius = levelProgressBar.frame.height / 2
        levelProgressBar.clipsToBounds = true
        levelProgressBar.layer.sublayers![1].cornerRadius = levelProgressBar.frame.height / 2
        levelProgressBar.subviews[1].clipsToBounds = true
    }


}

class ProjectsSkillTableViewCell: UITableViewCell {

    @IBOutlet weak var projectLabel: UILabel!
    @IBOutlet weak var projectOutcomeImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}

