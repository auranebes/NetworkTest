//
//  Model.swift
//  NetworkTest
//
//  Created by Arslan Abdullaev on 11.04.2022.
//
import Foundation
import FirebaseFirestoreSwift
import FirebaseDatabase

struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    var image_url: String
    var user_name: String
    
    enum CodingKeys: String, CodingKey {
        case image_url
        case user_name
    }
}
