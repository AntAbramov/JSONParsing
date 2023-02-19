//
//  MainTableViewCell.swift
//  JSONParsing
//
//  Created by Anton Abramov on 19.02.2023.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameNumLabel: UILabel!
    @IBOutlet weak var skillsLabel: UILabel!
    
    func configure(with employee: Employee) {
        if let name = employee.name, let phoneNumber = employee.phoneNumber {
            nameNumLabel.text = "\(name) · \(phoneNumber)"
        }
        
        skillsLabel.text = ""
        employee.skills?.forEach { skill in
            if skill != employee.skills?.last {
                self.skillsLabel.text?.append(skill)
                self.skillsLabel.text?.append(", ")
            } else {
                self.skillsLabel.text?.append(skill)
            }
        }
        
    }
    
    static let identifire = "MainTableViewCell"
    
    static func nib() -> UINib? {
        return UINib(nibName: "MainTableViewCell", bundle: nil)
    }
    
}
