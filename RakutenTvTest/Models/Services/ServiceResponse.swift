//
//  ServiceResponse.swift
//  Top Bank
//
//  Created by Thiago on 14/02/20.
//  Copyright © 2020 Valecard. All rights reserved.
//

import UIKit
import Foundation

struct ServiceResponse {
    
    // MARK: - Properties
    var data: Data?
    var rawResponse: String?
    var response: HTTPURLResponse?
    var request: URLRequest?
    var serviceError: ServiceError?
}
