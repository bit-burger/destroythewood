//
//  GameScene.swift
//  DestroyTheWood!
//
//  Created by Tony Borchert on 02.05.20.
//  Copyright © 2020 Tony Borchert. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation
//enum GameStadium {
//    case nothing
//    case holding
//    case animating
//}



class GameScene: SKScene {
    
//    var firstSprite:WoodPatternBox?
//    var secondSprite:WoodPatternBox?
//    var thirdSprite:WoodPatternBox?
//    var gameStadium:GameStadium = .nothing
    
    
    var holdingOnTo : SKSpriteNode?
    var holdingOnToIndex:Int?
    //MARK: - woodTiles
//    var actuelleCombinationen : ((Int?,Int?),(Int?,Int?),(Int?,Int?)) = (nil,nil,nil)
    var cgpoint10x10 = [[WoodTile]]()
    var cgpointX = [[WoodTile]]()
    var woodPatternBoxes = [WoodPatternBox]()
    //MARK: -
    var touchesNotBlocked:Bool = true //wenn animation oder scene inaktiv
    
    var singleTouch = true // damit nur ein touch gleichzeitig passiert
    
    var background = SKSpriteNode(imageNamed: "wood_backround")
    
    var gameHasEnded = false
    //MARK: - delegate orders To the gameview controller
    
    var gameViewControllerDelegate:GameViewControllerDelegate?
    
    var coinSoundEffect:AVAudioPlayer?
    //MARK: - didMove()
    override func didMove(to view: SKView) {
        isPlaying = true
        //aktuelleGameScene = self
        //notificationFeedbackGenerator
        //print("what the fuck")
        self.size = view.frame.size
        sizeOfWidth = self.frame.maxX / 10
        
        setUpBackround()
        
        let realRest:CGFloat = (self.size.height - 160 - self.size.width)
        widthOfWoodPatternBox = Int(min(realRest,  self.size.width / 3) )
        
        let rest:CGFloat = ((self.size.height  - 160) / 2) - (self.size.width / 2) + CGFloat(widthOfWoodPatternBox) / 2
        
        
        //print(rest,"rest")
        //let whereToPlaceTile:CGFloat = (rest / 2) - self.size.width
        
        //distanceOfLowerArea = Int(widthOfWoodPatternBox)
        
        //widthOfWoodPatternBox = Int(min(rest,  self.size.width / 3))
        
        distanceOfLowerArea = Int(rest)
        //print(rest,self.size.width,"whereToPlaceTile")
            //(Int(rest / 2) + widthOfWoodPatternBox / 2)
        setUpArrays()
        //giveSpritesSkins()
        for index in 1...3 {
            let woodPatternBoxToAppend = WoodPatternBox(position: CGPoint(x: (frame.size.width / 3) * CGFloat(index ) - (frame.size.width / 6), y: CGFloat(Double.nan)))
            
            woodPatternBoxToAppend.size = CGSize(width: CGFloat(widthOfWoodPatternBox) - 20, height: CGFloat(widthOfWoodPatternBox) - 20 )
            woodPatternBoxes.append(woodPatternBoxToAppend)
            
            self.addChild(woodPatternBoxes[index - 1])
        }
        
        
        
         
//        let i = buildASprite(WoodPatterns.threeByThree.two)
//        for child in i.children {
//            print(child as! SKSpriteNode)
//        }
//        addChild(i)
//        i.position = coordinatesOfButtons![0]
//        i.zPosition = ZPositions.woodTilesToDrag
//
        
        
//        checkPositionReal(WoodPatterns.threeByThree.seven, x: 0, y: 5)
//        checkPositionReal(WoodPatterns.twoByTwo.eight, x: 0, y: 8)
//        checkPositionReal(WoodPatterns.threeByThree.seven, x: 0, y: 0)
//        checkPositionReal(WoodPatterns.twoByTwo.eight, x: 0, y: 3)
//        checkForCombinations()
////        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
////            self.gameViewControllerDelegate?.lostGame()
////        }
//        givePoint()
//        givePoint()
        
        
        
    }
    //MARK: - Deinitialisierer
    
    deinit {
        
        //aktuelleGameScene = nil
        isPlaying = false
    }

    
    
    //MARK: - Touches Methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //print("touches Began")
        if gameHasEnded {
            selectionFeedbackGenerator.selectionChanged()
            gameViewControllerDelegate?.lostGame()
        }
        guard touchesNotBlocked else {
            return
        }
        if singleTouch == false {
            //print("what")
            return
        }
        singleTouch = false
        selectionFeedbackGenerator.selectionChanged()
        var counter = -1
        for woodPatternBox in woodPatternBoxes {
            counter += 1
            if woodPatternBox.testActivate(with: touches.first!.location(in: self)) {
                //print("it activated")
                if let woodPatterBox = woodPatternBoxes[counter].activate() {
                   holdingOnTo = woodPatterBox
                    holdingOnTo?.position = CGPoint(x: woodPatternBoxes[counter].position.x, y: woodPatternBoxes[counter].position.y + CGFloat(touchDistance))
                    holdingOnToIndex = counter
                    addChild(holdingOnTo!)
                    //print("it activated with success")
                    return
                }
                
                
            }
        }
        
//        print(touches.first!.location(in: self),"location")
//        //let positionToPlace = givePosition(x: Int(touches.first!.location(in: self).x), y: Int(touches.first!.location(in: self).y))
//        if let woodPatterBox = woodPatternBoxes[0].activate() {
//           holdingOnTo = woodPatterBox
//            holdingOnToIndex = 0
//            addChild(holdingOnTo!)
//            print("success")
//        }
//
////        checkPositionReal(woodPatternBoxes.randomElement()!.combination!, x: positionToPlace.0, y: positionToPlace.1)
//        checkForCombinations()
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touchesNotBlocked else {
            return
        }
        if holdingOnTo != nil {
            holdingOnTo?.position = CGPoint(x:touches.first!.location(in: self).x,y: touches.first!.location(in: self).y + CGFloat(touchDistance))
            //holdingOnTo?.zPosition = ZPositions.woodTilesToDrag
            //print(touches.first!.location(in: self))
        }
        
        
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touchesNotBlocked else {
            return
        }
        //selectionFeedbackGenerator
        singleTouch = true
        
        if holdingOnTo != nil {
            let positionInArray = givePosition(x: Int(touches.first!.location(in: self).x), y: Int(touches.first!.location(in: self).y) + touchDistance)
            
            let isSuccess = checkPositionReal(woodPatternBoxes[holdingOnToIndex!].combination!, x: positionInArray.0, y: positionInArray.1)
            
            //print(isSuccess)
            if !isSuccess {
               
                holdingOnTo?.anchorPoint = CGPoint(x: 0, y: 0)
                //print("verkackt")
                self.touchesNotBlocked = false
                let ySquared = ((holdingOnTo?.position.y)! - woodPatternBoxes[holdingOnToIndex!].position.y )*((holdingOnTo?.position.y)! - woodPatternBoxes[holdingOnToIndex!].position.y )
                let xSquared = ((holdingOnTo?.position.x)! - woodPatternBoxes[holdingOnToIndex!].position.x)*((holdingOnTo?.position.x)! - woodPatternBoxes[holdingOnToIndex!].position.x )
                let realDuration = sqrt(Double(xSquared + ySquared))
                var impactIntesity = CGFloat()
                if realDuration < 100 {
                    impactIntesity = 0
                } else {
                    impactIntesity = 0.4
                }
                 impactFeedbackGenerator.impactOccurred(intensity: impactIntesity)
                let duration = sqrt(Double(xSquared + ySquared)) / 5000
                let scale = (woodPatternBoxes[holdingOnToIndex!].children[0].children[0] as! SKSpriteNode).size.width / (holdingOnTo!.children[0] as! SKSpriteNode).size.width
                //print(duration)
                //print(scale)
                holdingOnTo?.run(SKAction.group([SKAction.move(to: CGPoint(x: woodPatternBoxes[holdingOnToIndex!].position.x, y: woodPatternBoxes[holdingOnToIndex!].position.y), duration: TimeInterval(duration)),SKAction.scale(to: scale, duration: TimeInterval(duration))])) {
                    //selectionFeedbackGenerator.selectionChanged()
                    
                    self.holdingOnTo?.removeAllActions()
                    self.woodPatternBoxes[self.holdingOnToIndex!].end(isSuccess: isSuccess)
                                                           self.holdingOnTo?.removeFromParent()
                                                           self.holdingOnTo = nil
                                                           //self.checkForCombinations()
                                                           self.touchesNotBlocked = true
                }

                
                
               
            } else {
//                for _ in 0...3 {
//                    print("*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=")
//                }
                playSound(called: AudioIdentifiers.placeDown)
                impactFeedbackGenerator.impactOccurred()
                holdingOnTo?.removeFromParent()
                holdingOnTo = nil
                
                woodPatternBoxes[holdingOnToIndex!].end(isSuccess: isSuccess)
                checkForCombinations()
            }
            
            
        }
        //checkIfGameEnds() // nicht nötig
        
        var combinations = [[(Int,Int)]]()
        
        for woodPatternBox in woodPatternBoxes {
            if let patternBox = woodPatternBox.combination  {
                combinations.append(patternBox)
            }
        }
        if combinations.isEmpty {
            for woodPatternBox in woodPatternBoxes {
                woodPatternBox.changeCombination()
            }
            
            checkIfGameEnds()
            return
        }

        
        
        
    }
    //MARK: - didFinishUpdate()
    override func didFinishUpdate() {
        //print(areTouchesActive,"areTouchesActive")
    }
   
}
//MARK: - extension - all Methods for WoodTiles
extension GameScene {
    
    func checkIfGameEnds() {
        //print("checkIfGameEnds")
        var combinations = [[(Int,Int)]]()
        
        for woodPatternBox in woodPatternBoxes {
            if let patternBox = woodPatternBox.combination  {
                combinations.append(patternBox)
            }
        }
        if combinations.isEmpty {
            for woodPatternBox in woodPatternBoxes {
                woodPatternBox.changeCombination()
            }
            checkIfGameEnds()
            return
        }
        for combination in combinations {
            if checkIfPossibleToFit(combination) {
                //print(combination)
                //print("returned")
                return
            }
        }
        gameHasEnded = true
        touchesNotBlocked = false
        gameViewControllerDelegate?.fadeButton()
        self.run(SKAction.fadeAlpha(to: CGFloat(alphaValue), duration: 1))
        
        
        
//        for _ in 0...9 {
//            print("lost game")
//        }
    }
    
    func setUpBackround() {
        background.size = self.size
         background.zPosition = -1
         
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        addChild(background)
    }
    
    func setUpArrays() {
//        arrayOfSprites.append(firstSprite)
//        arrayOfSprites.append(secondSprite)
//        arrayOfSprites.append(thirdSprite)
//        var counter = -1
//        for sprite in arrayOfSprites {
//            counter += 1
//            sprite.position = CGPoint(x: frame.midX, y: frame.midY + 10) //coordinatesOfButtons![counter]
//            sprite.anchorPoint = CGPoint(x: 0, y: 0)
//            sprite.zPosition = -567
//        }
        for y in 0...9 {
            cgpoint10x10.append([WoodTile]())
            for x in 0...9 {
                let woodTile = WoodTile(position: CGPoint(x: CGFloat(x) * CGFloat(self.frame.maxX / 10), y: CGFloat(y) * CGFloat(self.frame.maxX / 10) + CGFloat(distanceOfLowerArea)) )
                woodTile.pointDelegate = self
                    
                    
                cgpoint10x10[cgpoint10x10.count - 1].append(woodTile)
                self.addChild(woodTile)
            }
        }
        for Yrow in 0...9 {
            cgpointX.append([WoodTile]())
            for Xrow in 0...9 {
                cgpointX[cgpointX.count - 1].append(cgpoint10x10[Xrow][Yrow])
            }
        }
    }
    
    func checkPosition(x:Int,y:Int) {
        if x > 9 || x < 0 || y < 0 || y > 9 {
            return
        }
        if !cgpoint10x10[y][x].isPicked {
            cgpoint10x10[y][x].isPicked = true
        }
    }
    
    func givePoint() {
        points += 1
        gameViewControllerDelegate?.giveScore(score: points)
    }
    
    func giveScore(howMany score:Int) {
        points += score
        gameViewControllerDelegate?.giveScore(score: points)
    }
    
    func givePosition(x:Int,y:Int) -> (Int,Int) {
        //        if x > (sizeOfWidth! * 9) - 1 || y > (sizeOfWidth! * 10) - 1 || x < 0 || y < 0 {
        //            return (-1,-1)
        //        }
        if y < distanceOfLowerArea {
            return (-30,-30)
        }
        let realX = x
        let realY = y - distanceOfLowerArea
        let sizeOfTiles = Int(sizeOfWidth!)

        let xValueRemainder = realX % sizeOfTiles
        let yValueRemainder = realY
            % sizeOfTiles
        
        //print("this is the point:",((realX - xValueRemainder) / sizeOfTiles,(realY - yValueRemainder) / sizeOfTiles))
        return ((realX - xValueRemainder) / sizeOfTiles,(realY - yValueRemainder) / sizeOfTiles)
       
    }
    
    func deletePositions(_ points:[(Int,Int)] ) {
        for point in points {
            cgpoint10x10[point.1][point.0].animate()
        }
        
    }
    
    func checkPositionReal(_ checkableCoordinates: [(Int,Int)],x:Int,y:Int) -> Bool {
        if x > 9 || x < 0 || y < 0 || y > 9 {
            //print("return 1")
            return false
        }
        for checkableCoordinate in checkableCoordinates {
            if checkableCoordinate.0 + x > 9 || checkableCoordinate.1 + y > 9 {
                //print("return 2")
                return false
            }
            if cgpoint10x10[checkableCoordinate.1 + y][checkableCoordinate.0 + x].isPicked {
                //print("return 3")
                return false
            }
         
        }
        var pointsToAdd = 0
        for checkableCoordinate in checkableCoordinates {
            pointsToAdd += 1
            cgpoint10x10[checkableCoordinate.1 + y][checkableCoordinate.0 + x].isPicked = true
        }
        giveScore(howMany: pointsToAdd)
        return true
        
    }
    
    func checkForCombinations() {
        //var returnValue = [(Int,Int)]()
        var allTiles = [WoodTile]()
        //var index = (-1,-1)
        
        
        firstFor:for row in cgpoint10x10 {
            
            for column in row {
                if !column.isPicked {
                    continue firstFor
                }
            }
            for column in row {
                //givePoint()
                allTiles.append(column)
            //index.0 += a
                //returnValue.append(index)
            }
        }
        
        firstFor:for row in cgpointX {
            
            for column in row {
                if !column.isPicked {
                    continue firstFor
                }
            }
            for column in row {
                //givePoint()
                allTiles.append(column)
                //column.animate()
                //returnValue.append(index)
                //column.isPicked = false
            }
        }
//        if allTiles.isEmpty {
//            return
//        }
        if allTiles.isEmpty {
            checkIfGameEnds()
            return
        }
        var checkedTiles = [WoodTile]()
        allTilesForIn:for tile in allTiles {
            
            checkedTilesForIn:for checkedTile in checkedTiles {
                if checkedTile == tile {
                    continue allTilesForIn
                }
            }
            checkedTiles.append(tile)
        }
        for checkedTile in checkedTiles {
            checkedTile.isPicked = false
            checkedTile.isAnimation = true
        }
        func animateTiles() {
            if checkedTiles.isEmpty {
                checkIfGameEnds()
                for checkedTile in checkedTiles {
                    
                    checkedTile.isAnimation = false
                }
                return
            }
            //allTiles.first?
            checkedTiles.removeFirst().animate()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.06) { // 0.075
                animateTiles()
            }
        }
        animateTiles()
//        for tile in allTiles {
//            tile.animate()
//        }
//        let timer = Timer(timeInterval: 0.2, repeats: true) { (timer) in
//            print(allTiles.count,"count of allTiles")
////            if allTiles.isEmpty {
////                timer.invalidate()
////                return
////            }
//            allTiles.first?.animate()
//            allTiles.removeFirst()
//        }
//        timer.fire()
        //deletePositions(returnValue)
        
    }
    
    func checkIfPossibleToFit(_ checkableCoordinates: [(Int,Int)]) -> Bool {
        
        for Yindex in 0...9 {
            XForIn:for Xindex in 0...9 {
                for checkableCoordinate in checkableCoordinates {
                    if checkableCoordinate.0 < 0 || checkableCoordinate.1 < 0 || checkableCoordinate.0 > 9 || checkableCoordinate.1 > 9 {
                        //print("return 1")
                        return false
                    }
                    if checkableCoordinate.0 + Xindex > 9 || checkableCoordinate.1 + Yindex > 9 {
                        //print("return 2")
                        continue XForIn
                    }
                    if cgpoint10x10[checkableCoordinate.1 + Yindex][checkableCoordinate.0 + Xindex].isPicked {
                        //print("return 3")
                        continue XForIn
                    }
                }
                return true
                
                
            }
        }
        return false
    }
}
//MARK: - protocol orders from GameViewController
extension GameScene:GameSceneDelegate {
    
    func makeInactive() {
        //print("makeInactive")
        self.alpha = 0.4
        self.touchesNotBlocked = false
        
    }
    
    func makeActive() {
        //print("makeActive")
        self.touchesNotBlocked = true
        self.alpha = 1
        //aktuelleGameScene = self.self
    }
    func restartScene() {
        for yrow in cgpoint10x10 {
            for xcolumn in yrow {
                xcolumn.restart()
            }
        }
        for woodPatternbox in woodPatternBoxes {
            woodPatternbox.changeCombination()
        }
        
        gameHasEnded = false
        points = 0
        gameViewControllerDelegate?.giveScore(score: 0)
        //aktuelleGameScene = self.self
    }
    //aktuelleGameScene = self
}

extension GameScene:GivePoint {
    func giveSinglePoint() {
        givePoint()
    }
    
    
}
