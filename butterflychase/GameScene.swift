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
    private var chaser : SKSpriteNode?
    private var background : SKSpriteNode?
    private var caught : Int?
    
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
        self.caught = 1
        
        // Get label node from scene and store it for use later
        self.label = SKLabelNode(text: "Butterfly Chase")
        if let label = self.label {
            label.alpha = 1
            label.zPosition = 5
            label.position = CGPoint(x: -100,
            y: 300)
            self.addChild(label)
        }

        self.butterfly = SKSpriteNode(imageNamed: "butterfly")
        self.chaser = SKSpriteNode(imageNamed: "chaser")
        if let butterfly = self.butterfly {
            butterfly.zPosition=10
            butterfly.position = CGPoint(x: 0,
            y: 0)
            self.addChild(butterfly)
        }
        if let chaser = self.chaser {
            chaser.zPosition=5
            self.addChild(chaser)
        }
    }
    
    override func didMove(to view: SKView) {
        self.background = SKSpriteNode(imageNamed: "sky")
        if let view = self.view {
            if let background = self.background {
                background.zPosition = 1
                background.size =  view.frame.size
                self.addChild(background)
            }
        }
        let music = SKAudioNode(fileNamed: "music.caf")
        music.isPositional = false
        music.autoplayLooped = true
        let play = SKAction.play()
        music.run(play)
        self.addChild(music)
        
    }
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let chaser = self.chaser {
            let move = SKAction.move(to: pos, duration: 0.1)
            chaser.run(move)
            chaser.position = pos
            if let butterfly = self.butterfly {
                let xNumber = Int.random(in: -300 ..< 300)
                let yNumber = Int.random(in: -300 ..< 300)
                let xNewPos = (xNumber + Int(butterfly.position.x))%(Int(self.frame.width)/2)
                let yNewPos = (yNumber + Int(butterfly.position.y))%(Int(self.frame.height)/2)
                let newPos = CGPoint(x: CGFloat(xNewPos), y: CGFloat(yNewPos))
                butterfly.position = newPos
                let dist = (butterfly.position.x - chaser.position.x) * (butterfly.position.x - chaser.position.x) + (butterfly.position.y - chaser.position.y) * (butterfly.position.y - chaser.position.y)
                if dist < 100 {
                    print("Caught!!")
                    if let label = self.label {
                        if let caught = self.caught {
                            label.alpha = 1
                            label.zPosition = 5
                            let fade = SKAction.fadeIn(withDuration: 1)
                            label.text = "Caught: " + String(caught)
                            self.caught = caught + 1
                            label.run(fade)
                        }
                    }
                }
            }
        }
    }
        
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
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
