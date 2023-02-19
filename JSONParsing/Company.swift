struct Company: Decodable {
    let company: CompanyElement?
}

struct CompanyElement: Decodable {
    let name: String?
    let employees: [Employee]?
}

struct Employee: Decodable {
    let name, phoneNumber: String?
    let skills: [String]?

    enum CodingKeys: String, CodingKey {
        case name
        case phoneNumber = "phone_number"
        case skills
    }
}
