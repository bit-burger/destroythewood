//
//  NFG.swift
//  DestroyTheWood!
//
//  Created by Tony Borchert on 06.05.20.
//  Copyright © 2020 Tony Borchert. All rights reserved.
//

import UIKit
class NFG: UINotificationFeedbackGenerator {
    
    
    override func notificationOccurred(_ notificationType: UINotificationFeedbackGenerator.FeedbackType) {
        guard selectionOn else {
            return
        }
        super.notificationOccurred(notificationType)
        self.prepare()
        print(notificationType,"occured")
    }
        
        
    
    func singleNotification(_ notificationType: UINotificationFeedbackGenerator.FeedbackType) {
        guard selectionOn else {
            return
        }
        super.notificationOccurred(notificationType)
        print("single",notificationType,"occured")
    }

}
