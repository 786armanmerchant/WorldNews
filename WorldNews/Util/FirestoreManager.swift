//
//  FirestoreManager.swift
//  WorldNews
//
//  Created by Arman Merchant on 05/12/21.
//

import Foundation
import FirebaseFirestore


class WNFirestore {
    
    static let manager = WNFirestore()
    static let db = Firestore.firestore()
}
