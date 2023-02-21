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
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setTableViewConstraints()
    }
    
    private func fetchData() {
        networkService.obtainData(urlString: ApiUrl.givenLink) { result in
            switch result {
            case .success(let company):
                if var employees = company.company?.employees {
                    employees.sort { emp1, emp2 in
                        if let char1 = emp1.name?.first {
                            if let char2 = emp2.name?.first {
                                return char1 < char2
                            }
                        }
                        return false
                    }
                    DispatchQueue.main.async {
                        self.employeesDataSource = employees
                    }
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
    
    private func configureTableView() {
        view.addSubview(mainTableView)
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.register(MainTableViewCell.nib(), forCellReuseIdentifier: MainTableViewCell.identifire)
    }
    
   private func setTableViewConstraints() {
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
        if !titleHeader.isEmpty {
            return titleHeader
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        20
    }
    
}
