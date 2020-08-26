//
//  EinstellungenViewController.swift
//  DestroyTheWood!
//
//  Created by Tony Borchert on 06.05.20.
//  Copyright © 2020 Tony Borchert. All rights reserved.
//

import UIKit

class EinstellungenViewController: UIViewController {
    
    
    @IBOutlet weak var BobBobLabel: UILabel!
    
    @IBOutlet weak var bopBopSwitch: UISwitch!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var touchDistanceLabel: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        
        bopBopSwitch.backgroundColor = UIColor(red: 0.8588, green: 0.3294, blue: 0, alpha: 1.0)
        bopBopSwitch.layer.cornerRadius = 16
        
                slider.value = Float(userDefaults.integer(forKey: KeysForUserDefaults.touchDistance))
                changeTouchDistanceLabel(string:  String(userDefaults.integer(forKey: KeysForUserDefaults.touchDistance)))
                bopBopSwitch.isOn = userDefaults.bool(forKey: KeysForUserDefaults.selectionOn)
        changeBobBobSwitch(isOn: userDefaults.bool(forKey: KeysForUserDefaults.selectionOn))

        
    }
//    deinit {
//        print("deinitialised Einstellun")
//    }
    
    
    @IBAction func backButton_tapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func slider_valueChanged(_ sender: UISlider) {
        userDefaults.set(Int(slider.value), forKey: KeysForUserDefaults.touchDistance)
        
        changeTouchDistanceLabel(string:String( userDefaults.integer(forKey: KeysForUserDefaults.touchDistance)))
        touchDistance = Int(slider.value)
    }
    @IBAction func bobbob_valueChanged(_ sender: UISwitch) {
        playSound(called: "_switch2")
        userDefaults.set(sender.isOn, forKey: KeysForUserDefaults.selectionOn)
        selectionOn = sender.isOn
        selectionFeedbackGenerator.selectionChanged()
        changeBobBobSwitch(isOn: userDefaults.bool(forKey: KeysForUserDefaults.selectionOn))
    }
    @IBAction func zurücksetzen(_ sender: UIView) {
        let alertController = UIAlertController(title: "Achtung", message: "Zurücksetzten ist unwiederruflich", preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "Abbrechen", style: .default) { (_) in
            selectionFeedbackGenerator.selectionChanged()
        }
        let alertActionToDo = UIAlertAction(title: "Ok", style: .destructive) { (_) in
            selectionFeedbackGenerator.selectionChanged()
            if sender.tag == 0 {
                var dictionary = userDefaults.dictionaryRepresentation()
                dictionary.removeValue(forKey: KeysForUserDefaults.highscore)
                dictionary.keys.forEach { key in
                    userDefaults.removeObject(forKey: key)
                }
            } else {
                resetDefaults()
            }
            
            
        }
        alertController.addAction(alertAction)
        alertController.addAction(alertActionToDo)
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    func changeTouchDistanceLabel(string: String) {
        touchDistanceLabel.text = "Touch distance: " + string
    }
    func changeBobBobSwitch(isOn:Bool) {
        BobBobLabel.text = "BopBop: " + (isOn ? "on" : "off")
    }
    
    
}
