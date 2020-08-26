//
//  Functions_and_globalVariables.swift
//  DestroyTheWood!
//
//  Created by Tony Borchert on 03.05.20.
//  Copyright © 2020 Tony Borchert. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation




//var audioPlayer:AVAudioPlayer?
var secondAudioPlayer:AVAudioPlayer?
//var pointOfPointsLabel:CGPoint?
//var aktuelleGameScene:GameScene?

var points = 0

var touchDistance = 500
var selectionOn = true

var distanceOfLowerArea = 0

var widthOfWoodPatternBox = 0
//var areaUnderTiles = 0
//braucht man um zu wissen wie breit die view ist
var sizeOfWidth:CGFloat?

//braucht man um auf die userdefaults zuzugreifen
var userDefaults = UserDefaults.standard

var selectionFeedbackGenerator = SFG()

var impactFeedbackGenerator = IFG(style: .heavy)

var notificationFeedbackGenerator = NFG()

var isANewScore = true
// braucht man um zu wisseen ob ein key in der Userdefaults enthalten ist
func isKeyPresentInUserDefaults(key: String) -> Bool {
    return userDefaults.object(forKey: key) != nil
}

func buildASmallSprite(_ coordinates:[(Int,Int)]) -> SKSpriteNode {
    let texture = SKTexture(imageNamed: "wooden_square_toplace")
    let nodeToReturn = SKSpriteNode(texture: nil)
    nodeToReturn.anchorPoint = CGPoint(x: 0, y: 0)
    var heighestWidth:CGFloat = 0
    var heighestHeight:CGFloat = 0
    for coordinate in coordinates {
        let widthOfSquare = CGFloat(widthOfWoodPatternBox) / 7.5
        let spriteNode = SKSpriteNode(texture: texture, color: UIColor.clear, size: CGSize(width: widthOfSquare, height: widthOfSquare))
        spriteNode.position = CGPoint(x: CGFloat(coordinate.0) * widthOfSquare, y: CGFloat(coordinate.1) * widthOfSquare)
        if CGFloat(coordinate.0) * widthOfSquare > heighestWidth {
            heighestWidth = CGFloat(coordinate.0) * widthOfSquare
        }
        if CGFloat(coordinate.1) * widthOfSquare > CGFloat(heighestHeight) {
            heighestHeight = CGFloat(coordinate.1) * widthOfSquare
            
        }
        
        
        nodeToReturn.addChild(spriteNode)
    }
    nodeToReturn.size = CGSize(width:heighestWidth , height: heighestHeight)
    return nodeToReturn
    
}
func buildASprite(_ coordinates:[(Int,Int)]) -> SKSpriteNode {
    let texture = SKTexture(imageNamed: "wooden_square_toplace")
    let nodeToReturn = SKSpriteNode(texture: nil)
    nodeToReturn.anchorPoint = CGPoint(x: 0, y: 0)
    for coordinate in coordinates {
        let spriteNode = SKSpriteNode(texture: texture, color: UIColor.clear, size: CGSize(width: sizeOfWidth!, height: sizeOfWidth!))
        spriteNode.position = CGPoint(x: CGFloat(coordinate.0) * sizeOfWidth!, y: CGFloat(coordinate.1) * sizeOfWidth!)
        nodeToReturn.addChild(spriteNode)
    }
    return nodeToReturn
    
}
func resetDefaults() {
    
    
    let dictionary = userDefaults.dictionaryRepresentation()
    dictionary.keys.forEach { key in
        userDefaults.removeObject(forKey: key)
    }
}
func getTabelle() -> [EigeneCell]? {
    let data = userDefaults.object(forKey: KeysForUserDefaults.tabellenAccess)
    let decoder = JSONDecoder()
    if let arrayOfCellData = try? decoder.decode([EigeneCell].self, from: data as! Data) {
        return arrayOfCellData
    }
    return nil
    
}
func _addToTabelle(_ cellData:EigeneCell) {
    
    var arrayToAddOn = getTabelle()!
    // print("arrayGot",arrayToAddOn)
    arrayToAddOn.append(cellData)
    //print("arrayafterAppending",arrayToAddOn)
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(arrayToAddOn) {
            userDefaults.set(encoded, forKey: KeysForUserDefaults.tabellenAccess)
            print("encoding succeeded")
        } else {
            print("encoding failed")
        }
      
}

func saveAScore(_ cellData:EigeneCell) {
    if isANewScore {
        _addToTabelle(cellData)
//        if cellData.score > userDefaults.integer(forKey: KeysForUserDefaults.highscore) {
//            userDefaults.set(cellData.score, forKey: KeysForUserDefaults.highscore)
//        }
    }
    isANewScore = false
}
func newGame() {
    isANewScore = true
}
var isPlaying = false

//func playSound(called string: String) {
//    let pathToSound = Bundle.main.path(forResource: string, ofType: "wav")
//    let url = URL(fileURLWithPath: pathToSound!)
//    var localAudioPlayer = AVAudioPlayer()
//    do {
//        localAudioPlayer = try AVAudioPlayer(contentsOf: url)
//        localAudioPlayer.play()
//
//    } catch {
//        print("hat nicht den Sound gespielt")
//    }
//}
func playSound(called string:String) {
    let pathToSound = Bundle.main.path(forResource: string, ofType: "wav")
    let url = URL(fileURLWithPath: pathToSound!)

    do{
        secondAudioPlayer = try AVAudioPlayer(contentsOf: url)
        secondAudioPlayer?.play()

    } catch {
        print("hat nicht den Sound gespielt")
    }
}
