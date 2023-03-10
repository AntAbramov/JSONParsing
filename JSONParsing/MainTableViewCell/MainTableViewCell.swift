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
                self.skillsLabel.text?.append("\(skill), ")
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
