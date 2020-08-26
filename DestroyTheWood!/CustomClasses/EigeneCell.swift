//
//  EigeneCell.swift
//  DestroyTheWood!
//
//  Created by Tony Borchert on 07.05.20.
//  Copyright © 2020 Tony Borchert. All rights reserved.
//

import Foundation


struct EigeneCell:Codable {
    let date:Date
    let score:Int
    var dateInString:String {
        get {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .medium
            formatter.locale = Locale(identifier: "de_DE")
            let formattedString = formatter.string(for: date)
            return formattedString!
//            return date.description(with: Locale(identifier: "de_DE"))
        }
    }
}
