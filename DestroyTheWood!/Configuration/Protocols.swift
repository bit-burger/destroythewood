//
//  Protocols.swift
//  DestroyTheWood!
//
//  Created by Tony Borchert on 02.05.20.
//  Copyright © 2020 Tony Borchert. All rights reserved.
//

import SpriteKit

//protocol from GameScene to GameViewController
protocol GameViewControllerDelegate {
    func fadeButton()
    func lostGame() //the player lost
    func giveScore(score:Int) //the score gets updated
    
}
//protocol from GameViewController to GameScene
protocol GameSceneDelegate {
    func makeInactive()//makes the GameScene inactive if PauseControlls are there
    func makeActive()//makes the gameScene active if the game is resumed
    func restartScene()//restartes the scene
}



//protocol from PauseViewController to GameViewController
protocol PauseControls {
    func restartGame()//playerwantsToRestart
    func endGame()//player wants to end Game and go to home screen
    func continueGame()//playerwantsTocontinue the game
}
//protocol from GameViewController to PauseViewController if the PauseViewController needs to appear
protocol ShowPauseViewController {
    func show(isPause: Bool)
    func cancel()
}

protocol GivePoint {
    func giveSinglePoint()
}
