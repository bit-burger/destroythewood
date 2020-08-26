//
//  GameViewController.swift
//  DestroyTheWood!
//
//  Created by Tony Borchert on 02.05.20.
//  Copyright © 2020 Tony Borchert. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation


class GameViewController: UIViewController {
   let main_musik_url = URL(fileURLWithPath: Bundle.main.path(forResource: AudioIdentifiers.main_musik, ofType: "wav")!)
    //MARK: - delegate orders to PauseViewControllers
    var controllAlphaOfPauseViewController:ShowPauseViewController?
    //MARK: - delegare orders to gameScene
    var gameSceneDelegate:GameSceneDelegate?
    var globalAudioPlayer:AVAudioPlayer?
    var gameWasEnded = false
    //MARK: - oulets
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
//    @IBOutlet var buttons: [UIButton]!
    
    
    //MARK: - variables
    var pauseIsActive = false
    //MARK: - viewDidLoad()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.globalAudioPlayer = try? AVAudioPlayer(contentsOf: main_musik_url)
        self.globalAudioPlayer?.numberOfLoops = 2048
        self.globalAudioPlayer?.volume = 0.75
        self.globalAudioPlayer?.play()
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        overrideUserInterfaceStyle = .light
//        buttons.sort { (one, two) -> Bool in
//            if one.tag < two.tag {
//                return true
//            }
//            return false
//        }
//        coordinatesOfButtons = [CGPoint]()
//        for button in buttons {
//            coordinatesOfButtons?.append(CGPoint(x:  button.frame.minX, y:button.frame.minY))
//            button.alpha = 0
//        }
        
        highscoreLabel.text = "Highscore: " + String(userDefaults.integer(forKey: "highscore"))
        scoreLabel.text = "Score: "  + String(0)
        
        
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let scene =  GameScene() 
                // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            scene.gameViewControllerDelegate = self
            gameSceneDelegate = scene
                // Present the scene
            view.presentScene(scene)
            
            
            view.ignoresSiblingOrder = true
            
            //view.showsFPS = true
            //view.showsNodeCount = true
            //view.bringSubviewToFront(h)
        }
    }
    //MARK: - pauseGameButton_tapped
    
    @IBAction func pauseGame(_ sender: Any) {
        if gameWasEnded {
            return
        }
           if pauseIsActive {
               pauseIsActive = false
               controllAlphaOfPauseViewController?.cancel()
               gameSceneDelegate?.makeActive()
               pauseButton.setImage(UIImage(named: "wood_pause_button"), for: .normal)
              
               
           } else {
               
                pauseButton.setImage(UIImage(named: "wood_button"), for: .normal)
               pauseIsActive = true
               controllAlphaOfPauseViewController?.show(isPause: true)
               gameSceneDelegate?.makeInactive()
           }
           
       }
    
    //MARK: - overriding variables
    override var shouldAutorotate: Bool {
        return true
        
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: - prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pauseGameViewController = segue.destination as? PauseGameViewController {
            pauseGameViewController.pauseControlls = self
            self.controllAlphaOfPauseViewController = pauseGameViewController
        } else if segue.destination is StartingViewController {
            
                print("deinit")
            
            //aktuelleGameScene = nil
            isPlaying = false
        }
        
    }
   
    
}
//MARK: - protocol vom GameScene
extension GameViewController:GameViewControllerDelegate {
    func fadeButton() {
        print("button faded")
        self.gameWasEnded = true
        UIView.animate(withDuration: 1) {
            self.pauseButton.alpha = CGFloat(alphaValue)
        }
        
    }
    func lostGame() {
        //aktuelleGameScene = nil
        print("lostGame")
        gameWasEnded = true
        controllAlphaOfPauseViewController?.show(isPause: false)
        //gameSceneDelegate?.makeInactive()
    }
    
    func giveScore(score:Int) {
        scoreLabel.text = "Score: "  + String(score)
        //UIView.animate(withDuration: 0.1, animations:


        UIView.animate(withDuration: 0.075, animations: {
            self.scoreLabel.transform = self.scoreLabel.transform.scaledBy(x: 1.1, y: 1.1)
        }) { (_) in
            self.scoreLabel.transform = self.scoreLabel.transform.scaledBy(x: 0.90909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090, y: 0.90909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090)
            //selectionFeedbackGenerator.selectionChanged()
        }
        if score > userDefaults.integer(forKey: KeysForUserDefaults.highscore) {
            userDefaults.set(score, forKey: KeysForUserDefaults.highscore)
            highscoreLabel.text = "Highscore: "  + String(score)
        }
    }
}
//MARK: - protocol vom PauseViewController
extension GameViewController:PauseControls {
    func restartGame() {
        saveAScore(EigeneCell(date: Date(), score: points))
        newGame()
        //addToTabelle(EigeneCell(date: Date(), score: points))
        self.pauseButton.alpha = 1
        gameWasEnded = false
        gameSceneDelegate?.makeActive()
        gameSceneDelegate?.restartScene()
        pauseIsActive = false
        pauseButton.setImage(UIImage(named: "wood_pause_button"), for: .normal)
        //newGame()
        print("restartGame")
    }
    
    func endGame() {
        saveAScore(EigeneCell(date: Date(), score: points))
        newGame()
        isPlaying = false
        //addToTabelle(EigeneCell(date: Date(), score: points))
        gameWasEnded = false
        points = 0
        //newGame()
        self.dismiss(animated: true, completion: nil)
        self.globalAudioPlayer?.pause()
        self.globalAudioPlayer = nil
        isPlaying = false
        print("endGame")
    }
    
    func continueGame() {
        gameSceneDelegate?.makeActive()
        print("continueGame")
        pauseIsActive = false
        pauseButton.setImage(UIImage(named: "wood_pause_button"), for: .normal)
        //scoreLabel.text = "Score: 0"
    }
}
