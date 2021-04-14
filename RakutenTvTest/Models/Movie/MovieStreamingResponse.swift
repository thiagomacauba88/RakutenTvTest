//
//  MovieStreamingResponse.swift
//  RakutenTvTest
//
//  Created by Thiago Freitas on 25/02/21.
//

import UIKit

struct MovieStreamingResponse: Codable {

    var data: DataStreamingResponse?
}

struct DataStreamingResponse: Codable {
    
    var streamInfoListResponse: [StreamInfoResponse]?
    
    enum CodingKeys: String, CodingKey {
        case streamInfoListResponse = "stream_infos"
    }
}

struct StreamInfoResponse: Codable {
    
    var url: String?
}
