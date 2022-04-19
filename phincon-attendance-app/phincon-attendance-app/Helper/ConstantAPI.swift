//
//  ConstantAPI.swift
//  phincon-attendance-app
//
//  Created by Ade on 4/2/22.
//

import Foundation

struct ConstantAPI {
    
    struct Server {
        static let baseURL = "http://167.172.74.133:5000"
        static let apiKey = "fad62f49c504ddc9f0698c2ee4d5b9ef6f4baf2cb562559a152bc8533ec63635c392c6bf234a2bdee429f8892faea420fe93675cf8dfec79842ba252b6292932"
    }
    
    struct Parameters {
        static let username = "username"
        static let password = "password"
        static let fullname = "fullname"
        static let idcardnumber = "idcardnumber"
        static let location = "location"
        static let log = "log"
    }
       
    enum HttpHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
        case apikey = "apikey"
    }
    
    enum ContentType: String {
        case json = "application/json"
    }
}
