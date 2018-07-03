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
    var scoreLabel:SKLabelNode!
    var height:CGFloat!
    var score:Int!
    var obsTimer = Timer()
    var scoreTimer = Timer()
    
    override func didMove(to view: SKView) {
        bird = self.childNode(withName: "bird") as! SKSpriteNode
        scoreLabel = self.childNode(withName: "score") as! SKLabelNode
        
        started = false
        score = 0
        
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
        if bird.position.y <= -640 + bird.size.height {
            endGame()
            return
        }
    }
    
    @objc func spawnObstacle() {
        print("spawn")
        let bottom = SKSpriteNode()
        bottom.position = CGPoint(x: 350, y: -540)
        let height = arc4random_uniform(250) + 251
        bottom.size = CGSize(width: 50, height: Int(height))
        bottom.texture = SKTexture(imageNamed: "Pillar")
        
        let pb = createPB(h: Int(height))
        bottom.physicsBody = pb
        
        self.addChild(bottom)
    }
    
    @objc func updateScore() {
        score! += 1
        scoreLabel.text = "Score: \(score!)"
    }
    
    func createPB(h: Int) -> SKPhysicsBody {
        let pb = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: h))
        pb.friction = 0
        pb.collisionBitMask = 1
        pb.categoryBitMask = 2
        pb.isDynamic = true
        pb.allowsRotation = false
        pb.pinned = false
        pb.affectedByGravity = false
        pb.friction = 0
        pb.restitution = 0
        pb.linearDamping = 0
        pb.angularDamping = 0
        pb.velocity = CGVector(dx: -80, dy: 0)
        
        return pb
    }
    
    
    //Start and End Game
    func startGame() {
        started = true
        score = 0
        bird.physicsBody?.affectedByGravity = true
        obsTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(spawnObstacle), userInfo: nil, repeats: true)
        scoreTimer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(updateScore), userInfo: nil, repeats: true)
    }
    
    func endGame() {
        started = false
        obsTimer.invalidate()
        scoreTimer.invalidate()
        bird.physicsBody?.affectedByGravity = false
        bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        bird.position = CGPoint(x: 0, y: 70)
        
        let gameOverLabel = SKLabelNode(text: "Game Over!")
        gameOverLabel.position = CGPoint(x: 0, y: 0)
        
        self.addChild(gameOverLabel)
    }
}
