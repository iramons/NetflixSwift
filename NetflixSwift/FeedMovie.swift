//
//  FeedMovie.swift
//  NetflixSwift
//
//  Created by Ramon Marbet on 30/03/21.
//

import Foundation

struct Movie {
    var id: Int
    var imgUrl: String
    var title: String?
    var description: String?
}

class FeedMovie {
    
    // nosso objeto Destaque
    let highlight = Movie(id: 1, imgUrl: "", title: nil, description: nil)
    
    // dictionary de filmes
    let movie: [String : [Movie]] = [
        "continue" : [
            Movie(id: 1, imgUrl: "", title: "text1", description: "desc1"),
            Movie(id: 2, imgUrl: "", title: "text2", description: "desc2")
        ],
        "recent" : [
            Movie(id: 3, imgUrl: "", title: "text3", description: "desc3"),
            Movie(id: 4, imgUrl: "", title: "text4", description: "desc4")
        ]
    ]
}
