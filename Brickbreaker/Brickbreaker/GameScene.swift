//
//  GameScene.swift
//  Brickbreaker
//
//  Created by Christopher Rosenblatt on 6/26/18.
//  Copyright © 2018 crosenblatt. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var ball:SKSpriteNode!
    var paddle:SKSpriteNode!
    var scoreLabel:SKLabelNode!
    var score:Int?
    
    override func didMove(to view: SKView) {
        ball = self.childNode(withName: "Ball") as! SKSpriteNode
        paddle = self.childNode(withName: "Paddle") as! SKSpriteNode
        scoreLabel = self.childNode(withName: "ScoreLabel") as! SKLabelNode
        
        score = 0
        updateLabel()
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 50))
        
        let border = SKPhysicsBody(edgeLoopFrom: (view.scene?.frame)!)
        border.friction = 0
        self.physicsBody = border
        
        self.physicsWorld.contactDelegate = self
    }
    
    func updateLabel() {
       scoreLabel.text = "\(score!)"
    }
    
    func checkForWin() {
        if score == 9 {
            ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            let alert = UIAlertController(title: "Congratulations!", message: "You Won", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            if let vc = self.scene?.view?.window?.rootViewController {
                vc.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            paddle.position.x = location.x
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            paddle.position.x = location.x
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if ball.position.y <= paddle.position.y - 50 {
            ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            ball.position = CGPoint(x: 0, y: 0)
            let alert = UIAlertController(title: "Uh Oh!", message: "You Lost", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            if let vc = self.scene?.view?.window?.rootViewController {
                vc.present(alert, animated: true, completion: nil)
            }
            
            NotificationCenter.default.post(NSNotification(name: NSNotification.Name(rawValue: "loseSegue"), object: nil, userInfo: nil) as Notification)
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyAName = contact.bodyA.node?.name
        let bodyBName = contact.bodyB.node?.name
        
        if (bodyAName == "Ball" && bodyBName == "Brick") || (bodyAName == "Brick" && bodyBName == "Ball") {
            if bodyAName == "Brick" {
                contact.bodyA.node?.removeFromParent()
                score! += 1
                checkForWin()
            } else if bodyBName == "Brick" {
                contact.bodyB.node?.removeFromParent()
                score! += 1
                checkForWin()
            }
        }
        updateLabel()
    }
}
