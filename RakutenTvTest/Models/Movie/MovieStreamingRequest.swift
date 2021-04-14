//
//  MovieStreamingRequest.swift
//  RakutenTvTest
//
//  Created by Thiago Freitas on 25/02/21.
//

import UIKit

class MovieStreamingRequest: Codable {

    var audioLanguage: String?
    var audioQuality: String?
    var contentId: String?
    var contentType: String?
    var deviceSerial: String?
    var deviceStreamVideoQuality: String?
    var player: String?
    var subtitleLanguage: String?
    var videoType: String?
    
    enum CodingKeys: String, CodingKey {
        case audioLanguage = "audio_language"
        case audioQuality = "audio_quality"
        case contentId = "content_id"
        case contentType = "content_type"
        case deviceSerial = "device_serial"
        case deviceStreamVideoQuality = "device_stream_video_quality"
        case player
        case subtitleLanguage = "subtitle_language"
        case videoType = "video_type"
    }
}
