//
//  GameScene.swift
//  Pong
//
//  Created by Christopher Rosenblatt on 6/22/18.
//  Copyright © 2018 crosenblatt. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    var topLabel = SKLabelNode()
    var bottomLabel = SKLabelNode()
    
    var score = [Int]()
    
    override func didMove(to view: SKView) {
        startGame()
        
        topLabel = self.childNode(withName: "topLabel") as! SKLabelNode
        bottomLabel = self.childNode(withName: "bottomLabel") as! SKLabelNode
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        main = self.childNode(withName: "main") as! SKSpriteNode
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        self.physicsBody = border
    }
    
    func startGame() {
        score = [0, 0]
        topLabel.text = "\(score[1])"
        bottomLabel.text = "\(score[0])"
    }
    
    func addScore(player: SKSpriteNode) {
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        if player == main {
            score[0] += 1
            bottomLabel.text = "\(score[0])"
            ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        } else {
            score[1] += 1
            topLabel.text = "\(score[1])"
            ball.physicsBody?.applyImpulse(CGVector(dx: -20, dy: -20))
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            main.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            main.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1))
        
        if ball.position.y <= main.position.y - 70 {
            addScore(player: enemy)
        } else if ball.position.y >= enemy.position.y + 70 {
            addScore(player: main)
        }
    }
    
}
