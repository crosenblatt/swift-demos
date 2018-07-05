//
//  GameViewController.swift
//  FlappyBird
//
//  Created by Christopher Rosenblatt on 7/2/18.
//  Copyright © 2018 crosenblatt. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import os.log

class GameViewController: UIViewController {

    var player:Player!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = false
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
}

class Player: NSObject, NSCoding {
    var highScore:Int!
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("player")
    
    init(highScore: Int) {
        self.highScore = highScore
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(highScore, forKey: "highScore")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.highScore = aDecoder.decodeObject(forKey: "highScore") as? Int
        super.init()
    }
}
