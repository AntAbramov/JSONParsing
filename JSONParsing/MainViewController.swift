import UIKit

class MainViewController: UIViewController {
    
    let mainTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainTableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setTableViewConstraints()
    }
    
    func setTableViewConstraints() {
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        mainTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mainTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mainTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
    
}
