//
//  GameScene.swift
//  butterflychase
//
//  Created by Vatsal Vora on 5/15/20.
//  Copyright © 2020 voraentertainment. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    private var spinnyNode : SKSpriteNode?
    private var background : SKSpriteNode?
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        // Create shape node to use during mouse interaction
//        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKSpriteNode(imageNamed: "butterfly.pdf")
        
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.zPosition=5
            let colorize = SKAction.colorize(with: .white, colorBlendFactor: 1, duration: 5)
            spinnyNode.run(colorize)
        }
    }
    
    override func didMove(to view: SKView) {
        self.background = SKSpriteNode(imageNamed: "sky.pdf")
        if let view = self.view {
            if let background = self.background {
                background.zPosition = 1
                background.size =  view.frame.size
                background.position = CGPoint(x: 0,
                                              y: 0)
                self.addChild(background)
            }
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKSpriteNode? {
            n.position = pos
            n.zPosition = 5
            let colorize = SKAction.colorize(with: .green, colorBlendFactor: 1, duration: 5)
            n.run(colorize)
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKSpriteNode? {
            n.position = pos
            n.zPosition = 5
            let colorize = SKAction.colorize(with: .blue, colorBlendFactor: 1, duration: 5)
            n.run(colorize)
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKSpriteNode? {
            n.position = pos
            n.zPosition = 5
            let colorize = SKAction.colorize(with: .red, colorBlendFactor: 1, duration: 5)
            n.run(colorize)
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}
