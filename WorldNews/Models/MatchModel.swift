//
//  MatchModel.swift
//  WorldNews
//
//  Created by Arman Merchant on 05/12/21.
//

import Foundation
import FirebaseFirestoreSwift

class Match: NSObject, Codable, Identifiable{
    @DocumentID var id: String?
    var name:String?
    var score:String?
    var type: Int?
}
