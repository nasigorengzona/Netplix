//
//  Trailer.swift
//  Netplix
//
//  Created by erlina ng on 27/12/22.
//

import Foundation

struct TrailerResponse: Codable {
    let items: [VideoElement]
}


struct VideoElement: Codable {
    let id: IdVideoElement
}


struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
