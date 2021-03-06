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
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
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
    }
}
