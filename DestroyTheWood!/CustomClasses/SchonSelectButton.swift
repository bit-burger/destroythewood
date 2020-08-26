//
//  SelectButton.swift
//  DestroyTheWood!
//
//  Created by Tony Borchert on 06.05.20.
//  Copyright © 2020 Tony Borchert. All rights reserved.
//
//import AVFoundation
import UIKit
import AVFoundation
class SchonSelectButton: UIButton {
    var audioPlayer : AVAudioPlayer!
    override init(frame: CGRect) {
        
        
        super.init(frame:frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: AudioIdentifiers.button, ofType: "wav")!))
        } catch {
            fatalError("failed")
        }
        audioPlayer.prepareToPlay()
        //fatalError("init(coder:) has not been implemented")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        selectionFeedbackGenerator.selectionChanged()
       
            
             audioPlayer.play()
       
       
//        let pathToSound = Bundle.main.path(forResource: AudioIdentifiers.button, ofType: "wav")
//         let url =
//         var localAudioPlayer = AVAudioPlayer()
//         do {
//             localAudioPlayer = try AVAudioPlayer(contentsOf: url)
//             localAudioPlayer.play()
//
//         } catch {
//             print("hat nicht den Sound gespielt")
//         }
//        playSound(is: AudioIdentifiers.button)
        self.transform = self.transform.scaledBy(x: 1.1, y: 1.1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.transform = self.transform.scaledBy(x: 0.9090909090909090909090909090909090909090, y: 0.9090909090909090909090909090909090909090)
        }
       
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
