//
//  APICall.swift
//  Rabee
//
//  Created by Wahid Hidayat on 19/07/23.
//

import Foundation

struct API {
    fileprivate static let baseUrl = "https://api.unsplash.com/"
    fileprivate static var clientId: String {
        guard let filePath = Bundle.main.path(forResource: "API-Info", ofType: "plist") else {
            fatalError("Couldn't find file 'API-Info.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "CLIENT_ID") as? String else {
            fatalError("Couldn't find key 'CLIENT_ID' in 'API-Info.plist'.")
        }
        return value
    }
    
    static func searchParameters(query: String, color: ColorFilter, page: Int) -> [String: Any] {
        return [
            "client_id": API.clientId,
            "page": page,
            "query": query,
            "color": color.rawValue
        ]
    }
}

enum Endpoints {
    case search
    
    var url: String {
        switch self {
        case .search:
            return API.baseUrl + "search/photos"
        }
    }
}
