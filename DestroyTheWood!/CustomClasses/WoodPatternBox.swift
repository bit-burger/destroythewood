//
//  WoodPatternBox.swift
//  DestroyTheWood!
//
//  Created by Tony Borchert on 03.05.20.
//  Copyright © 2020 Tony Borchert. All rights reserved.
//

import SpriteKit

class WoodPatternBox: SKSpriteNode {
    var combination:[(Int,Int)]?
    var isActive = false
    var wasAsuccess = false
//    let backround = SKSpriteNode(texture: , color: UIColor.clear, size: CGSize(width:sizeOfWidth! * 2.5,height:sizeOfWidth! * 2.5))
    
    func changeCombination() {
//        if !wasAsuccess {
//            return
//        }
        if isActive {
            return
        }
        alpha = 1
        wasAsuccess = false
        combination = WoodPatterns.all.randomElement()!
//        combination = Bool.random() ? WoodPatterns.sticksGreaterThanThree.four :  WoodPatterns.sticksGreaterThanThree.two
        //combination = WoodPatterns.threeByThree.seven
        removeAllChildren()
        let spriteInside = buildASmallSprite(combination!)
        spriteInside.zPosition = ZPositions.woodTilesToDrag
        spriteInside.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        spriteInside.position = CGPoint(x: 0 - spriteInside.frame.maxX, y: 0  - spriteInside.frame.maxY)
        addChild(spriteInside)
    }
    func testActivate(with point:CGPoint) -> Bool {
        return self.contains(point)
        
    }
    func activate() -> SKSpriteNode? {
        if wasAsuccess {
            return nil
        }
        if isActive {
            print("activate function called wrong")
            return nil
        }
        let returnSprite = buildASprite(combination!)
        returnSprite.zPosition = ZPositions.woodTilesToDrag
        isActive = true
        alpha = 0.5
        return returnSprite
    }
    func end(isSuccess:Bool) {
        if !isActive {
            print("succes function called wrong")
            return
        }
        isActive = false
        alpha = 1
        if isSuccess {
            combination = nil
            wasAsuccess = true
            removeAllChildren()
            
        } else {
            isActive = false
            
        }
        
    }
    
    init(position:CGPoint) {
        super.init(texture: SKTexture(imageNamed: "empty_wooden_square"), color: UIColor.clear, size: CGSize(width:distanceOfLowerArea,height:distanceOfLowerArea))
//        self.xScale = 
//        self.yScale = 0.8
        //self.anchorPoint = CGPoint(x: 0, y: 0)
        //let woodBoxHalve:CGFloat = (CGFloat(widthOfWoodPatternBox) / 2.0)
        //let distanceOfLowerAreaHalve:CGFloat =
        print(distanceOfLowerArea,"distanceOfLowerArea")
        self.position = CGPoint(x: position.x, y:  CGFloat(distanceOfLowerArea) / 2 + (UIApplication.shared.keyWindow!.safeAreaInsets.bottom > 0 ? 10 : 0))
       
        changeCombination()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
