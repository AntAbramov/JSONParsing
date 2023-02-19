import UIKit

class MainViewController: UIViewController {
    
    let mainTableView = UITableView()
    let networkService = NetworService()
    
    var employeesDataSource: [Employee] = [Employee]() {
        didSet {
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
            }
        }
    }
    var titleHeader = "" {
        didSet {
            mainTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainTableView)
        mainTableView.dataSource = self
        mainTableView.delegate = self
        fetchData()
        
        mainTableView.register(MainTableViewCell.nib(), forCellReuseIdentifier: MainTableViewCell.identifire)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setTableViewConstraints()
    }
    
    func fetchData() {
        networkService.obtainData(urlString: ApiUrl.givenLink) { result in
            switch result {
            case .success(let company):
                if let employees = company.company?.employees {
                    self.employeesDataSource = employees
                }
                
                if let companyName = company.company?.name {
                    DispatchQueue.main.async {
                        self.titleHeader = companyName
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setTableViewConstraints() {
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        mainTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mainTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        mainTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
    
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        employeesDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = mainTableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifire, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        cell.configure(with: employeesDataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        titleHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        20
    }
    
}
