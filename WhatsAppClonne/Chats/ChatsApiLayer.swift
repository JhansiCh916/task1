//
//  ChatsApiLayer.swift
//  WhatsAppClonne
//
//  Created by Jhansi Ch on 01/06/24.
//

import Foundation
import UIKit

class ChatsApi {
    static let shared = ChatsApi()
    
    var data: [Chat] = [
            Chat(name: "John", image: UIImage(named: "image1")),
            Chat(name: "David", image: UIImage(named: "image2")),
            Chat(name: "Mike", image: UIImage(named: "image3")),
            Chat(name: "Smith", image: UIImage(named: "image4")),
            Chat(name: "Josh", image: UIImage(named: "image5")),
            Chat(name: "Michhel", image: UIImage(named: "image6")),
            Chat(name: "Barac", image: UIImage(named: "image7")),
            Chat(name: "Donald", image: UIImage(named: "image8"))
        ]
    
//    func fetchChats() -> [Chat] {
//        return dataSourceArr
//    }
}
