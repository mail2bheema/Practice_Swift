//
//  ViewController.swift
//  Practice_Swift
//
//  Created by Admin on 19/04/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView : UITableView!
    private let reuseIdentifier = "myCell"
    var employeeResponse = [Employee]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "UserTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: reuseIdentifier)
        tableView.dataSource = self

        guard let url = URL(string: "https://dummy.restapiexample.com/api/v1/employees") else {
            return
        }
        
        EmployeeNetWorkManager.sharedNetworKManager.fetchNetworkData(from: url) { [weak self] result in
            switch result{
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(EmployeesResponse.self, from: data)
                    self?.employeeResponse = response.data
                    
                    DispatchQueue.main.async {
                        self?.tableView .reloadData();
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            case .failure(let error):
                print("Failed to fetch data:", error.localizedDescription)
            }
        }
    }


}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.employeeResponse.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? UserTableViewCell else {
            fatalError("Failed to load")
        }
        let empdataDetails = self.employeeResponse[indexPath.row]
        cell.nameLabel?.text = empdataDetails.employeeName
        cell.userDescription?.text = "\(empdataDetails.employeeAge)"

        return cell;
    }
    
    
}
