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
    let explosionSound = SKAction.playSoundFileNamed("Explosion", waitForCompletion: true)

    var shipX = 100
    
    override func didMove(to view: SKView) {
        
        backgroundNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        backgroundNode.size = CGSize(width: self.frame.width, height: self.frame.height)
        backgroundNode.zPosition = -1
        self.addChild(backgroundNode)
        
        spaceShip.position = CGPoint(x: self.frame.midX , y: 50 )
        spaceShip.size = CGSize(width: 70, height: 50)
        self.addChild(spaceShip)
        
        endlessFall()
        dropBomb()
        
    }
    
    func dropBomb() {
        let waitAction = SKAction.wait(forDuration: 5, withRange: 5)
        let fallAction = SKAction.moveTo(y: -50, duration: 5)
        let rotateAction = SKAction.rotate(byAngle: 90, duration: 5)
        let deleteAction = SKAction.removeFromParent()
        
        let createMoveRotate = SKAction.run {
            let bomb = SKSpriteNode(imageNamed: "bomb")
            bomb.name = "bomb"

            let randomPositionX = CGFloat.random(in: 0..<self.size.width)
            bomb.position.x = randomPositionX
            bomb.position.y = self.view!.bounds.height
            bomb.size = CGSize(width: 100, height: 60)

            self.addChild(bomb)
            let group = SKAction.group([fallAction, rotateAction])
            let sequence = SKAction.sequence([group, deleteAction])
            bomb.run(sequence)
        }

        let sequence = SKAction.sequence([waitAction, createMoveRotate])
        let endlessAction = SKAction.repeatForever(sequence)
        self.run(endlessAction)
        
    }
    
    func endlessFall() {
        
        let waitAction = SKAction.wait(forDuration: 2)
        let fallAction = SKAction.moveTo(y: -50, duration: 5)
        let rotateAction = SKAction.rotate(byAngle: 90, duration: 5)
        let deleteAction = SKAction.removeFromParent()
        
        let createMoveRotate = SKAction.run {
            if Bool.random() {
                let meteorites = SKSpriteNode(imageNamed: "meteorGrey_med1")
                meteorites.name = "item"

                let randomPositionX = CGFloat.random(in: 0..<self.size.width)
                meteorites.position.x = randomPositionX
                meteorites.position.y = self.view!.bounds.height
                self.addChild(meteorites)
                let group = SKAction.group([fallAction, rotateAction])
                let sequence = SKAction.sequence([group, deleteAction])
                meteorites.run(sequence)
                
            } else {
                let spaceDebris = SKSpriteNode(imageNamed: "wingRed_2")
                spaceDebris.name = "item"

                let randomPositionX = CGFloat.random(in: 0..<self.size.width)
                spaceDebris.position.x = randomPositionX
                spaceDebris.position.y = self.view!.bounds.height
                self.addChild(spaceDebris)
                let group = SKAction.group([fallAction, rotateAction])
                let sequence = SKAction.sequence([group, deleteAction])
                spaceDebris.run(sequence)
            }
        }

        let sequence = SKAction.sequence([waitAction, createMoveRotate])
        let endlessAction = SKAction.repeatForever(sequence)
        self.run(endlessAction)
        
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            shipX = Int(location.x)
        }
    }

    
    override func update(_ currentTime: TimeInterval) {
        checkForCollision()
        spaceShip.position = CGPoint(x: self.shipX , y: 50 )

    }


    func collision(with node: SKSpriteNode) {
        print("collided")
        node.removeAllActions()
        node.removeFromParent()
    }
    
    func checkForCollision() {
        var hits: [SKSpriteNode] = []
        self.enumerateChildNodes(withName: "item") { node, _ in
            let node = node as! SKSpriteNode
            if node.frame.intersects(self.spaceShip.frame) {
                hits.append(node)
            }
        }
                
        self.enumerateChildNodes(withName: "bomb") { node, _ in
            let bomb = node as! SKSpriteNode
            if bomb.frame.intersects(self.spaceShip.frame) {
                print("game over")
                
                let explosions = SKAction.run {
                    let explosionFire = SKEmitterNode(fileNamed: "explosion")!
                    explosionFire.position = CGPoint(x: bomb.position.x, y: bomb.position.y)
                    explosionFire.zPosition = 1
                    self.addChild(explosionFire)
                    
                    self.run(self.explosionSound)
                }
                
                let wait = SKAction.wait(forDuration: 1)
                
                let finalActions = SKAction.run {
                    bomb.removeFromParent()
                    self.isPaused = true
                    self.removeAllActions()
                }
                
                let sequence = SKAction.sequence([explosions, wait, finalActions])
                self.run(sequence)
            }
        }
        
        for node in hits {
            collision(with: node)
        }
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
