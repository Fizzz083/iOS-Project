//
//  post.swift
//  napp
//
//  Created by kuet on 27/10/21.
//  Copyright © 2021 kuet. All rights reserved.
//

import Foundation


struct Post: Decodable {
    var status : String
    var result : [ContestListEntry]
}

struct ContestListEntry: Decodable {
    
    var id: Int
    var name: String
    var type: String
    var phase: String
    var frozen: Bool
    var durationSeconds: Int
    var startTimeSeconds: Int
    var relativeTimeSeconds: Int
    
}
