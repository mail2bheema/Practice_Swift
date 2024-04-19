//
//  EmployeeNetworkCall.swift
//  Practice_Swift
//
//  Created by Admin on 19/04/24.
//

import Foundation

class EmployeeNetWorkManager {
    static let sharedNetworKManager = EmployeeNetWorkManager()
    private init(){
        
    }
    func fetchNetworkData(from url:URL,completion:@escaping(Result<Data,Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("\(error.localizedDescription)")
                completion(.failure(error.localizedDescription as! Error))
            }
            guard let data = data else{
                print("\(error!.localizedDescription)")
                return
            }
            completion(.success(data))
        }
    }
}
