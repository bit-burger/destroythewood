//
//  SFG.swift
//  DestroyTheWood!
//
//  Created by Tony Borchert on 03.05.20.
//  Copyright © 2020 Tony Borchert. All rights reserved.
//

import UIKit

class SFG: UISelectionFeedbackGenerator {
    override func selectionChanged() {
        guard selectionOn else {
            return
        }
        super.selectionChanged()
        self.prepare()
        print("selection Changed")
    }
    func singleSelection() {
        guard selectionOn else {
            return
        }
        super.selectionChanged()
        print("single selection changed")
        
    }
}

