//
//  GameScene.swift
//  butterflychase
//
//  Created by Vatsal Vora on 6/7/20.
//  Copyright © 2020 Vatsal Vora. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var background : SKSpriteNode?
    private var music : SKAudioNode?
    private var butterfly : SKSpriteNode?
    private var chaser : SKSpriteNode?
    private var countLabel : SKLabelNode?
    private var timeLabel : SKLabelNode?
    private var count : Int?
    private var startTime : Date?
    
    override func didMove(to view: SKView) {
        self.background = SKSpriteNode(imageNamed: "sky")
        if let view = self.view {
            if let background = self.background {
                background.zPosition = 1
                background.size = view.frame.size
                self.addChild(background)
            }
        }
        let music = SKAudioNode(fileNamed: "music.caf")
        music.autoplayLooped = true
        music.isPositional = false
        let play = SKAction.play()
        music.run(play)
        self.addChild(music)
        
        self.butterfly = SKSpriteNode(imageNamed: "butterfly")
        
        if let butterfly = self.butterfly{
            butterfly.zPosition = 5
            self.addChild(butterfly)
        }
        
        self.chaser = SKSpriteNode(imageNamed: "chaser")
       
        if let chaser = self.chaser{
            chaser.zPosition = 10
            self.addChild(chaser)
        }
        self.count = 0
        
        self.countLabel = SKLabelNode()
        if let countLabel = self.countLabel{
            countLabel.alpha = 1
            countLabel.text = "Caught: "
            countLabel.fontColor = SKColor.white
            countLabel.zPosition = 5
            countLabel.position = CGPoint(x: self.frame.minX + 100,
                                          y: self.frame.maxY - 100)
            self.addChild(countLabel)
        }

        self.startTime = Date()
        self.timeLabel = SKLabelNode()
        if let timeLabel = self.timeLabel{
            timeLabel.alpha = 1
            timeLabel.text = "Time: "
            timeLabel.fontColor = SKColor.white
            timeLabel.zPosition = 5
            timeLabel.position = CGPoint(x: self.frame.midX + 100,
                                         y: self.frame.maxY - 100)
            self.addChild(timeLabel)
        }
        

    }
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let chaser = self.chaser {
            chaser.position = pos
            if let butterfly = self.butterfly {
                let randX = Int.random(in: -300 ..< 300)
                let randY = Int.random(in: -300 ..< 300)
                let xNewPos = (randX + Int(butterfly.position.x))%(Int(self.frame.width)/2)
                let yNewPos = (randY + Int(butterfly.position.y))%(Int(self.frame.height)/2)
                butterfly.position = CGPoint(x:CGFloat(xNewPos),y:CGFloat(yNewPos))
                let dist = (butterfly.position.x - chaser.position.x) *
                    (butterfly.position.x - chaser.position.x) +
                    (butterfly.position.y - chaser.position.y) *
                    (butterfly.position.y - chaser.position.y)
                if dist < 100 { //Buttefly is Caught!!
                    if let countLabel = self.countLabel {
                        if let count = self.count {
                            countLabel.text = "Caught: " + String(count+1)
                            self.count = count+1
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
        if let startTime = self.startTime{
            let duration = Int(-1*round(startTime.timeIntervalSinceNow))
            if let timeLabel = self.timeLabel {
                timeLabel.text = "Time: " + String(duration) + "s"
            }
        }
    }
}
