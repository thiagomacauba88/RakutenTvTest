//
//  ServiceError.swift
//  Top Bank
//
//  Created by Thiago on 14/02/20.
//  Copyright © 2020 Valecard. All rights reserved.
//

import Foundation

struct ServiceError: Codable, Error {
  
  // MARK: - Properties
  var code: String?
  var title: String?
  var detail: String?
  var statusCode: Int?
  var error: String?
  var message: String?
}
