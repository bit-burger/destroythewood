//
//  SelectSegmentedControl.swift
//  DestroyTheWood!
//
//  Created by Tony Borchert on 26.05.20.
//  Copyright © 2020 Tony Borchert. All rights reserved.
//

import UIKit

class SelectSegmentedControl: UISegmentedControl {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        selectionFeedbackGenerator.selectionChanged()
        super.touchesBegan(touches, with: event)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
