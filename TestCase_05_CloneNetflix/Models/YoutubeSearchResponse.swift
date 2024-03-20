//
//  YoutubeSearchResponse.swift
//  TestCase_05_CloneNetflix
//
//  Created by Tsai Ming Chen on 2024/3/20.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
