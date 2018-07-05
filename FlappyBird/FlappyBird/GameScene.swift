//
//  GameScene.swift
//  FlappyBird
//
//  Created by Christopher Rosenblatt on 7/2/18.
//  Copyright © 2018 crosenblatt. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var started:Bool!
    var finished:Bool!
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
        finished = false
        score = 0
        
        let border = SKPhysicsBody(edgeLoopFrom: (view.scene?.frame)!)
        border.friction = 0
        
        self.physicsBody = border
        
        self.physicsWorld.contactDelegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !started && !finished {
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
        let top = SKSpriteNode()
        
        bottom.position = CGPoint(x: 350, y: -540)
        top.position = CGPoint(x: 350, y: 540)
        
        let height1 = arc4random_uniform(320) + 321
        let height2 = 1280 - 125 - height1
        
        bottom.size = CGSize(width: 50, height: Int(height1))
        top.size = CGSize(width: 50, height: Int(height2))
        
        bottom.texture = SKTexture(imageNamed: "Pillar")
        top.texture = SKTexture(imageNamed: "Pillar")
        
        var pb = createPB(h: Int(height1))
        bottom.physicsBody = pb
        
        pb = createPB(h: Int(height2))
        top.physicsBody = pb
        top.zRotation = CGFloat(Double.pi)
        
        bottom.name = "obstacle"
        top.name = "obstacle"
        
        self.addChild(bottom)
        self.addChild(top)
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
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyAName = contact.bodyA.node?.name
        let bodyBName = contact.bodyB.node?.name
        
        if (bodyAName == "obstacle" && bodyBName == "bird") || (bodyAName == "bird" && bodyBName == "obstacle") {
            endGame()
        }
    }
    
    
    //Start and End Game
    func startGame() {
        started = true
        score = 0
        bird.physicsBody?.affectedByGravity = true
        obsTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(spawnObstacle), userInfo: nil, repeats: true)
        scoreTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateScore), userInfo: nil, repeats: true)
    }
    
    func endGame() {
        started = false
        finished = true
        obsTimer.invalidate()
        scoreTimer.invalidate()
        bird.physicsBody?.affectedByGravity = false
        bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        bird.position = CGPoint(x: 0, y: 70)
        
        let gameOverLabel = SKLabelNode(text: "Game Over!")
        gameOverLabel.position = CGPoint(x: 0, y: 0)
        
        let finalScoreLabel = SKLabelNode(text: "Score: \(score!)")
        finalScoreLabel.position = CGPoint(x: 0, y: -30)
        
        self.addChild(gameOverLabel)
        self.addChild(finalScoreLabel)
        
        self.physicsWorld.speed = 0
    }
}
