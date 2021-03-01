//
//  URLInfo.swift
//  Top Bank
//
//  Created by Thiago on 14/02/20.
//  Copyright © 2020 Valecard. All rights reserved.
//

import UIKit

class URLInfo {
    
     static func url(fromKey key: String) -> String {
     guard let path = Bundle.main.path(forResource: "URLs", ofType: "plist"),
     let dict = NSDictionary(contentsOfFile: path) as? [String: String] else { return ""}
     if let url = dict[key] {
        return (url)
     } else {
        return ""
     }
    }
}
