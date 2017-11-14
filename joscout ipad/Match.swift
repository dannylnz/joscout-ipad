//
//  Match.swift
//  joscout ipad
//
//  Created by Daniele Lanzetta on 09.11.17.
//  Copyright © 2017 Daniele Lanzetta. All rights reserved.
//

import Foundation


class Match: NSObject {

    var scoreA:Int?
    var scoreB:Int?
    var teamA: String?
    var teamB: String?

    
    init(teamA: String?, teamB: String? ,scoreA:Int?, scoreB:Int?) {
    
    self.teamA = teamA
    self.teamB = teamB
    self.scoreA = scoreA
    self.scoreB = scoreB
    
}

}
