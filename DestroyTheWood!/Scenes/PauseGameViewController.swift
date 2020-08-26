//
//  InGameViewController.swift
//  DestroyTheWood!
//
//  Created by Tony Borchert on 02.05.20.
//  Copyright © 2020 Tony Borchert. All rights reserved.
//

import UIKit

class PauseGameViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var pauseLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    //MARK: - variables
    var pauseIsActive = false
    var pauseControlls:PauseControls?
    //MARK: - viewWillAppear()
    override func viewWillAppear(_ animated: Bool) {
        self.view.alpha = 0
       // self.view.isHidden = true
        self.view.isUserInteractionEnabled = false

    }
    //MARK: - viewDidLoad()
    override func viewDidLoad() {
//
        pauseLabel.font =  UIFont.boldSystemFont(ofSize: view.frame.size.width / 5)
        
       
        
        
        self.view.layer.borderColor = UIColor(red: 0.4392, green: 0.1725, blue: 0.0353, alpha: 1.0).cgColor
        self.view.layer.borderWidth = 5
        self.view.layer.backgroundColor = UIColor(red: 0.9098, green: 0.7255, blue: 0.5255, alpha: 1.0).cgColor
        self.view.layer.cornerRadius = 20
        
    }
    //MARK: - button @IBActions
    @IBAction func continueButton_tapped(sender: UIButton) {
        print("continueGame_button")
        
        cancel()
        pauseControlls?.continueGame()
    }
    @IBAction func restartButton_tapped(sender: UIButton) {
        print("restartGame_button")
        
        cancel()
        pauseControlls?.restartGame()
    }
    @IBAction func homeButton_tapped(sender: UIButton) {
        print("endGame_button")
        pauseControlls?.endGame()
    }
    
    
    
}
//MARK: - protocol from GameViewController
extension PauseGameViewController:ShowPauseViewController {
    func cancel() {
        self.view.alpha = 0
        // self.view.isHidden = true
         self.view.isUserInteractionEnabled = false
//        view.backgroundColor = UIColor.clear
//        view.layer.borderColor = UIColor.clear.cgColor
//        for view in view.subviews {
//            view.isHidden = true
//            view.isUserInteractionEnabled = false
//        }
//        print("cancel")
//        self.view.isUserInteractionEnabled = false
        
    }
    func show(isPause: Bool) {
        if isPause {
            self.view.alpha = 1
        } else {
            UIView.animate(withDuration: 2) {
                self.view.alpha = 1
            }
        }
        continueButton.isHidden = !isPause
        continueButton.isEnabled = isPause
        print("show, isPause:", isPause)
//        for view in view.subviews {
//            view.isHidden = false
//            view.isUserInteractionEnabled = true
//        }
        self.view.layer.borderColor = UIColor(red: 0.4392, green: 0.1725, blue: 0.0353, alpha: 1.0).cgColor
        self.view.layer.backgroundColor = UIColor(red: 0.9098, green: 0.7255, blue: 0.5255, alpha: 1.0).cgColor
        
        
        
//        
       
        self.view.isUserInteractionEnabled = true
        //self.view.isHidden = false
        if isPause {
            pauseLabel.text = "Paused"
//            buttons[0].isHidden = true
//            buttons[0].isEnabled = false
        } else {
             pauseLabel.text = "You Lost"
//            buttons[0].isHidden = false
//            buttons[0].isEnabled = true
        }
    }
}
