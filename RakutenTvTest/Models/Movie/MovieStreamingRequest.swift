//
//  MovieStreamingRequest.swift
//  RakutenTvTest
//
//  Created by Thiago Freitas on 25/02/21.
//

import UIKit

class MovieStreamingRequest: Codable {

    var audio_language: String?
    var audio_quality: String?
    var content_id: String?
    var content_type: String?
    var device_serial: String?
    var device_stream_video_quality: String?
    var player: String?
    var subtitle_language: String?
    var video_type: String?
}
