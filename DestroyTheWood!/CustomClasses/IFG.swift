//
//  IFG.swift
//  DestroyTheWood!
//
//  Created by Tony Borchert on 03.05.20.
//  Copyright © 2020 Tony Borchert. All rights reserved.
//

import UIKit

class IFG: UIImpactFeedbackGenerator {
    override func impactOccurred() {
        guard selectionOn else {
            return
        }
        super.impactOccurred()
        self.prepare()
        print("impact occured")
        
    }
    func singleImpact() {
        guard selectionOn else {
            return
        }
        super.impactOccurred()
        self.prepare()
        print("single impact occured")
    }

}
