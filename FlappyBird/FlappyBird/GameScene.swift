//
//  GameScene.swift
//  FlappyBird
//
//  Created by Christopher Rosenblatt on 7/2/18.
//  Copyright © 2018 crosenblatt. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var started:Bool!
    var bird:SKSpriteNode!
    var height:CGFloat!
    
    override func didMove(to view: SKView) {
        bird = self.childNode(withName: "bird") as! SKSpriteNode
        started = false
        height = UIScreen.main.bounds.height
        print(height)
        
        let border = SKPhysicsBody(edgeLoopFrom: (view.scene?.frame)!)
        border.friction = 0
        self.physicsBody = border
        
        self.physicsWorld.contactDelegate = self as? SKPhysicsContactDelegate
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !started {
            startGame()
        }
        
        bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        bird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 60))
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if bird.position.y <= -640 {
            endGame()
            return
        }
    }
    
    
    //Start and End Game
    func startGame() {
        started = true
        bird.physicsBody?.affectedByGravity = true
    }
    
    func endGame() {
        started = false
        bird.physicsBody?.affectedByGravity = false
        
        let gameOverLabel = SKLabelNode(text: "Game Over!")
        gameOverLabel.position = CGPoint(x: 0, y: 0)
    }
}
