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
    private var butterfly : SKSpriteNode?
    private var bottle : SKSpriteNode?
    private var background : SKSpriteNode?
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        

        self.butterfly = SKSpriteNode(imageNamed: "butterfly")
        self.bottle = SKSpriteNode(imageNamed: "bottle")
        if let butterfly = self.butterfly {
            butterfly.zPosition=10
            let colorize = SKAction.colorize(with: .white, colorBlendFactor: 1, duration: 5)
            butterfly.run(colorize)
        }
        if let bottle = self.bottle {
            bottle.zPosition=5
            let colorize = SKAction.colorize(with: .white, colorBlendFactor: 1, duration: 5)
            bottle.run(colorize)
        }
    }
    
    override func didMove(to view: SKView) {
        self.background = SKSpriteNode(imageNamed: "sky")
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
        if let bottle = self.bottle?.copy() as! SKSpriteNode? {
            bottle.position = pos
            bottle.zPosition = 5
            let colorize = SKAction.colorize(with: .green, colorBlendFactor: 1, duration: 5)
            bottle.run(colorize)
            self.addChild(bottle)
        }
        if let butterfly = self.butterfly?.copy() as! SKSpriteNode? {
            let number = Int.random(in: 0 ..< 10)
            butterfly.position = CGPoint(x: butterfly.position.x+CGFloat(number), y: butterfly.position.y+CGFloat(number))
            butterfly.zPosition = 10
            let colorize = SKAction.colorize(with: .blue, colorBlendFactor: 1, duration: 5)
            butterfly.run(colorize)
            self.addChild(butterfly)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let bottle = self.bottle?.copy() as! SKSpriteNode? {
            bottle.position = pos
            bottle.zPosition = 5
            let colorize = SKAction.colorize(with: .blue, colorBlendFactor: 1, duration: 5)
            bottle.run(colorize)
            self.addChild(bottle)
        }
        if let butterfly = self.butterfly?.copy() as! SKSpriteNode? {
            let number = Int.random(in: 0 ..< 10)
            butterfly.position = CGPoint(x: butterfly.position.x+CGFloat(number), y: butterfly.position.y+CGFloat(number))
            butterfly.zPosition = 10
            let colorize = SKAction.colorize(with: .red, colorBlendFactor: 1, duration: 5)
            butterfly.run(colorize)
            self.addChild(butterfly)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let bottle = self.bottle?.copy() as! SKSpriteNode? {
            bottle.position = pos
            bottle.zPosition = 5
            let colorize = SKAction.colorize(with: .red, colorBlendFactor: 1, duration: 5)
            bottle.run(colorize)
            self.addChild(bottle)
        }
        if let butterfly = self.butterfly?.copy() as! SKSpriteNode? {
            let number = Int.random(in: 0 ..< 10)
            butterfly.position = CGPoint(x: butterfly.position.x+CGFloat(number), y: butterfly.position.y+CGFloat(number))
            butterfly.zPosition = 10
            let colorize = SKAction.colorize(with: .green, colorBlendFactor: 1, duration: 5)
            butterfly.run(colorize)
            self.addChild(butterfly)
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
