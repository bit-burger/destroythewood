//
//  WoodPatterns.swift
//  DestroyTheWood!
//
//  Created by Tony Borchert on 02.05.20.
//  Copyright © 2020 Tony Borchert. All rights reserved.
//

import Foundation
import CoreGraphics
struct WoodPatterns {
    struct twoByTwo {
        static let one = [
                         
                        (0,0)
                        ]
        static let two = [
                         (0,1)
                        ,(0,0)
                        ]
        static let three = [
                         
                        (0,0),(1,0)
                        ]
        static let four = [
                         (0,1)
                        ,(0,0),(1,0)
                        ]
        static let five = [
                         (0,1),(1,1)
                        ,(0,0)
                        ]
        static let six = [
                         (0,1),(1,1)
                              ,(1,0)
                        ]
        static let seven = [
                               (1,1)
                        ,(0,0),(1,0)
                        ]
        static let eight = [
                         (0,1),(1,1)
                        ,(0,0),(1,0)
                        ]
        static let all:[[(Int,Int)]] = [one,two,three,four,five,six,seven,eight]
        

    }
    struct threeByThree {
        static let one = [
                             (0,2)
                            ,(0,1)
                            ,(0,0),(1,0),(2,0)
                        ]
        static let two = [
             (0,2),(1,2),(2,2)
            ,(0,1)
            ,(0,0)
        ]
        static let three = [
             (0,2),(1,2),(2,2)
                        ,(2,1)
                        ,(2,0)
        ]
        static let four = [
                        (2,2)
                        ,(2,1)
            ,(0,0),(1,0),(2,0)
        ]
        static let five = [
             (0,2)
            ,(0,1)
            ,(0,0)
        ]
        static let six = [
             
            (0,0),(1,0),(2,0)
        ]
        static let seven = [
             (0,2),(1,2),(2,2)
            ,(0,1),(1,1),(2,1)
            ,(0,0),(1,0),(2,0)
        ]
        static let all:[[(Int,Int)]] = [one,two,three,four,five,six,seven]
    }
    struct sticksGreaterThanThree {
        static let one = [
            (0,3)
            ,(0,2)
            ,(0,1)
            ,(0,0)
        ]
        static let two = [
             (0,4)
            ,(0,3)
            ,(0,2)
            ,(0,1)
            ,(0,0)
        ]
        static let three = [
            (0,0),(1,0),(2,0),(3,0)
        ]
        static let four = [
            (0,0),(1,0),(2,0),(3,0),(4,0)
        ]
        static let all:[[(Int,Int)]] = [one,two,three,four]
    }
    static let all = sticksGreaterThanThree.all + twoByTwo.all + threeByThree.all
}
struct SegueIdentifiers {
    static let segueToGameViewController = "segueToGameViewController"
    static let segueToInGameViewController = "segueToInGameViewController"
}
struct KeysForUserDefaults {
    static let touchDistance = "touchdistance"
    static let tabellenAccess = "tableView"
    static let highscore = "highscore"
    static let selectionOn = "selectOn"
    static let lastSegmentedControlValue = "lastSegmentedControl"
    static let lastSegmentedControlValueForWithoutZero = "lastSegmentedControlWithoutZero"
    
}
struct AudioIdentifiers {
    static let coin = "sound1"
    static let placeDown = "sound2"
//    static let button1 = "sound3"
//    static let button2 = "sound4"
    static let button = "_switch1"
    static let `switch` = "_switch2"
    
    static let lobby_musik = "LobbyMusik"
    static let main_musik = "MainMusik"
    
}
struct ZPositions {
    static let backround:CGFloat = -1
    static let woodTiles:CGFloat = 0
    static let woodTilesToDrag:CGFloat = 1
}
var alphaValue:Double = 0.5
//var distanceOfLowerAreaForBox :Int {
//    get {
//        return distanceOfLowerArea / 3
//    }
//}
