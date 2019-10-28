//
//  GameScene.swift
//  SpaceJunk
//
//  Created by Ruhsane Sawut on 10/28/19.
//  Copyright © 2019 ruhsane. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

class GameScene: SKScene {
    
    let backgroundNode = SKSpriteNode(imageNamed: "vectorstock_16606572")
    let spaceShip = SKSpriteNode(imageNamed: "playerShip2_red")
    
    override func didMove(to view: SKView) {
        
        backgroundNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        backgroundNode.size = CGSize(width: self.frame.width, height: self.frame.height)
        backgroundNode.zPosition = -1
        self.addChild(backgroundNode)
        
        spaceShip.position = CGPoint(x: self.frame.midX , y: self.frame.minY + 50 )
        spaceShip.size = CGSize(width: 70, height: 50)
        self.addChild(spaceShip)
        
        
        endlessFall()
        
    }
    
    func endlessFall() {
        
        let waitAction = SKAction.wait(forDuration: 2)
        let fallAction = SKAction.moveTo(y: -50, duration: 5)
        let rotateAction = SKAction.rotate(byAngle: 90, duration: 5)
        
        let createMoveRotate = SKAction.run {
            if Bool.random() {
                let meteorites = SKSpriteNode(imageNamed: "meteorGrey_med1")

                let randomPositionX = CGFloat.random(in: 0..<self.size.width)
                meteorites.position.x = randomPositionX
                meteorites.position.y = self.view!.bounds.height
                self.addChild(meteorites)
                let group = SKAction.group([fallAction, rotateAction])
                meteorites.run(group)
                
            } else {
                let spaceDebris = SKSpriteNode(imageNamed: "wingRed_2")

                let randomPositionX = CGFloat.random(in: 0..<self.size.width)
                spaceDebris.position.x = randomPositionX
                spaceDebris.position.y = self.view!.bounds.height
                self.addChild(spaceDebris)
                let group = SKAction.group([fallAction, rotateAction])
                spaceDebris.run(group)
            }
        }

        let sequence = SKAction.sequence([waitAction, createMoveRotate])
        let endlessAction = SKAction.repeatForever(sequence)
        self.run(endlessAction)
        
    }
    

//
//    func touchDown(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.green
//            self.addChild(n)
//        }
//    }
//
//    func touchMoved(toPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.blue
//            self.addChild(n)
//        }
//    }
//
//    func touchUp(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.red
//            self.addChild(n)
//        }
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let label = self.label {
//            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }
//
//        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
//
//    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
//    }
//
//
//    override func update(_ currentTime: TimeInterval) {
//        // Called before each frame is rendered
//    }
}
