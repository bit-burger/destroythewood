//
//  StartingViewController.swift
//  DestroyTheWood!
//
//  Created by Tony Borchert on 02.05.20.
//  Copyright © 2020 Tony Borchert. All rights reserved.
//

import UIKit
import AVFoundation
var globalAudioPlayer:AVAudioPlayer?
class StartingViewController: UIViewController {
    //MARK: - outlets
    @IBOutlet weak var highscore: UILabel!
    
   var globalAudioPlayer:AVAudioPlayer?
   let lobby_musik_url = URL(fileURLWithPath: Bundle.main.path(forResource: AudioIdentifiers.lobby_musik, ofType: "wav")!)
    
    var isInGameViewController = false
    //MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        globalAudioPlayer = try? AVAudioPlayer(contentsOf: lobby_musik_url)
//        globalAudioPlayer?.numberOfLoops = 2048
        globalAudioPlayer?.play()
        globalAudioPlayer?.volume = 0.75
        print(globalAudioPlayer)
        
        isInGameViewController = false
        //userDefaults.removeObject(forKey: KeysForUserDefaults.highscore)
        overrideUserInterfaceStyle = .light
        
               
    }
    
//    override var overrideUserInterfaceStyle: UIUserInterfaceStyle {
//        return .light
//    }
    
    //MARK: - viewWillApear()
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is GameViewController {
            isInGameViewController = true
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        //super.viewWillAppear(animated)
        if isInGameViewController {
            globalAudioPlayer = try? AVAudioPlayer(contentsOf: lobby_musik_url)
            globalAudioPlayer?.numberOfLoops = 2048
            globalAudioPlayer?.play()
            globalAudioPlayer?.volume = 0.75
            
            isInGameViewController = false
        }
        
         highscore.text = "Highscore: " + String(userDefaults.integer(forKey: "highscore"))
//        var path: [AnyObject] = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true) as [AnyObject]
//        let folder: String = path[0] as! String
//        NSLog("Your NSUserDefaults are stored in this folder: %@/Preferences", folder)
       
        if !isKeyPresentInUserDefaults(key: KeysForUserDefaults.highscore ){
            userDefaults.set(0, forKey: KeysForUserDefaults.highscore)
            print("no key for \"highscore\"")
        }
        //highscore.text = String(userDefaults.integer(forKey: KeysForUserDefaults.selectionOn))
        
        if !isKeyPresentInUserDefaults(key: KeysForUserDefaults.selectionOn){
            userDefaults.set(true, forKey: KeysForUserDefaults.selectionOn)
            print("no key for \"selectionOn\"")
        }
        selectionOn = userDefaults.bool(forKey: KeysForUserDefaults.selectionOn)
        
        
        
        
        
        if !isKeyPresentInUserDefaults(key: KeysForUserDefaults.touchDistance) {
            userDefaults.set(100, forKey: KeysForUserDefaults.touchDistance)
        }
        
        touchDistance = userDefaults.integer(forKey: KeysForUserDefaults.touchDistance)
        //touchDistance = 500
        if !isKeyPresentInUserDefaults(key: KeysForUserDefaults.tabellenAccess ){
            let arrayOfDatesEmpty = [EigeneCell]()
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(arrayOfDatesEmpty) {
                userDefaults.set(encoded, forKey: KeysForUserDefaults.tabellenAccess)
                print("encoding succeeded")
            } else {
                print("encoding failed")
            }
            //let encoder = JSONEncoder
           
            //print("no key for \"highscore\"")
        }
        
        
        
    }
    //MARK: - IBActions
    @IBAction func startButton_tapped(_ sender: Any) {
        performSegue(withIdentifier: SegueIdentifiers.segueToGameViewController, sender: nil)
        globalAudioPlayer?.pause()
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
           return .all
       }
    
    
}
