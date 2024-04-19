//
//  EmployeeModel.swift
//  Practice_Swift
//
//  Created by Admin on 19/04/24.
//

import Foundation

struct Employee: Codable {
    let id: Int
    let employeeName: String
    let employeeSalary: Int
    let employeeAge: Int
    let profileImage: String?

    enum CodingKeys: String, CodingKey {
        case id
        case employeeName = "employee_name"
        case employeeSalary = "employee_salary"
        case employeeAge = "employee_age"
        case profileImage = "profile_image"
    }
}

struct EmployeesResponse: Codable {
    let status: String
    let data: [Employee]
}
