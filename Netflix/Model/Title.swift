//
//  Title.swift
//  Netflix
//
//  Created by Rohit Sharma on 26/12/22.
//

import Foundation

struct TrendingResponse : Codable{
    let results : [Title]
}

struct Title : Codable{
    let id : Int
    let media_type : String?
   // let original_language : String?
    let original_title : String?
    let overview : String?
 //   let popularity : String?
    let poster_path : String?
    let release_date : String?
    let title : String?
    let vote_average : Double
    let vote_count : Int
    
}

/*
 id = 995133;
 "media_type" = movie;
 "original_language" = en;
 "original_title" = "The Boy, the Mole, the Fox and the Horse";
 overview = "The unlikely friendship of a boy, a mole, a fox and a horse traveling together in the boy\U2019s search for home.";
 popularity = "7.601";
 "poster_path" = "/oQRgyQCzcyZvE6w5heM9ktVY0LT.jpg";
 "release_date" = "2022-12-02";
 title = "The Boy, the Mole, the Fox and the Horse";
 video = 0;
 "vote_average" = "8.300000000000001";
 "vote_count" = 7;
 */
