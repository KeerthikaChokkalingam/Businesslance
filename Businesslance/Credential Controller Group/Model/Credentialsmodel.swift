//
//  Credentialsmodel.swift
//  Businesslance
//
//  Created by Keerthika Chokkalingam on 15/09/23.
//

import Foundation
struct CredentialResponse: Codable {
    var message: MessageStrcut?
}
struct MessageStrcut: Codable {
    var success: String?
    var message: String?
    var data: DataStruct?
}
struct DataStruct: Codable {
    var environment: String?
    var authoriseNetClientName: String?
    var authoriseNetClientKey: String?
    var business: [BusinessStruct]?
    var paymentDetails: PaymentDetailsStruct?
    enum CodingKeys: String, CodingKey {
        case environment = "Environment"
        case authoriseNetClientName = "AuthoriseNetClientName"
        case authoriseNetClientKey = "AuthoriseNetClientKey"
        case business = "Business"
        case paymentDetails = "PaymentDetails"
    }
    
}
struct PaymentDetailsStruct: Codable {
    var details:[briefPayment]?
    enum CodingKeys: String, CodingKey {
        case details = "Details"
    }
}
struct briefPayment: Codable {
    var method: String?
    enum CodingKeys: String, CodingKey {
        case method = "PaymentMethod"
    }
}
struct BusinessStruct: Codable {
    var businessName: String?
    var businessAddress: String?
    var phone: String?
    var logo: String?
    var providedServices: [ProvidedServicesStruct]?
    var bayNode: [BayNodeStruct]
    var promotions: PromotionsStruct?
    var rewards: [RewardsStruct]?
    enum CodingKeys: String, CodingKey {
        case businessName = "BusinessName"
        case businessAddress = "BusinessAddress"
        case phone = "Phone"
        case logo = "Logo"
        case providedServices = "ProvidedServices"
        case bayNode = "BayNode"
        case promotions = "Promotions"
        case rewards = "Rewards"
    }
}
struct RewardsStruct: Codable {
    var availablePoint: Int?
    enum CodingKeys: String, CodingKey {
        case availablePoint = "AvailablePoints"
    }
}

struct PromotionsStruct: Codable {
    var promotionDesc: String?
    enum CodingKeys: String, CodingKey {
        case promotionDesc = "PromotionDescription"
    }
}
struct ProvidedServicesStruct: Codable {
    var serviceId: Int?
    var serviceName: String?
    enum CodingKeys: String, CodingKey {
        case serviceId = "ServiceId"
        case serviceName = "ServiceName"
    }

}
struct BayNodeStruct: Codable {
    var bayId: Int?
    var bayName: String?
    var bayServices: [bayServices]?
    enum CodingKeys: String, CodingKey {
        case bayId = "BayId"
        case bayName = "BayName"
        case bayServices = "BayServices"
    }
}
struct bayServices: Codable {
    var serviceId: Int?
    var servicename: String?
    var isPackage: Bool?
    var cost: Int?
    enum CodingKeys: String, CodingKey {
        case serviceId = "ServiceId"
        case servicename = "Service_Name"
        case isPackage = "Ispackage"
        case cost = "Cost"
    }
}
