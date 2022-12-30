//
//  YoutubeResponse.swift
//  Netflix
//
//  Created by Rohit Sharma on 29/12/22.
//

import Foundation


struct YoutubeResponse : Codable{
    let items : [VideoResponse]
}

struct VideoResponse : Codable{
    let id : VideoIdModel
}

struct VideoIdModel : Codable{
    let kind : String
    let videoId : String
}
