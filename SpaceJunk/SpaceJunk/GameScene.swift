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
    
//    let backgroundNode = SKSpriteNode(imageNamed: "vectorstock_16606572")
    let spaceShip = SKSpriteNode(imageNamed: "playerShip2_red")
    let explosionSound = SKAction.playSoundFileNamed("Explosion", waitForCompletion: true)
    var shipX = 100
    var cameraNode: SKCameraNode!
    let cameraMovePointsPerSec: CGFloat = 0.6
    var playableRect: CGRect
    var cameraRect : CGRect {
      let x = cameraNode.position.x - size.width/2 + (size.width - playableRect.width)/2
      let y = cameraNode.position.y - size.height/2 + (size.height - playableRect.height)/2
      return CGRect(x: x, y: y, width: playableRect.width, height: playableRect.height)
    }
    
    override init(size: CGSize) {
        playableRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
//        backgroundNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
//        backgroundNode.size = CGSize(width: self.frame.width, height: self.frame.height)
//        backgroundNode.zPosition = -1
//        self.addChild(backgroundNode)
        createBackground()
        
        spaceShip.position = CGPoint(x: self.frame.midX , y: 50 )
        spaceShip.size = CGSize(width: 70, height: 50)
        self.addChild(spaceShip)
        
        // create camera
        cameraNode = SKCameraNode()
        addChild(cameraNode)
        camera = cameraNode
        cameraNode.position = CGPoint(x: size.width/2, y: size.height/2)

        
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
            bomb.position.y = self.cameraNode.position.y + 300
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
                meteorites.position.y = self.cameraNode.position.y + 300
                self.addChild(meteorites)
                let group = SKAction.group([fallAction, rotateAction])
                let sequence = SKAction.sequence([group, deleteAction])
                meteorites.run(sequence)
                
            } else {
                let spaceDebris = SKSpriteNode(imageNamed: "wingRed_2")
                spaceDebris.name = "item"

                let randomPositionX = CGFloat.random(in: 0..<self.size.width)
                spaceDebris.position.x = randomPositionX
                spaceDebris.position.y = self.cameraNode.position.y + 300
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
        moveCamera()

    }
    
    func createBackground() {
        for i in 0...1 {
          let background = backgroundNode()
          background.anchorPoint = CGPoint.zero
          background.position = CGPoint(x: 0, y: CGFloat(i)*background.size.height)
          background.name = "background"
          background.zPosition = -1
          addChild(background)
        }
    }
    
    func backgroundNode() -> SKSpriteNode {
        // 1
        let backgroundNode = SKSpriteNode()
        backgroundNode.anchorPoint = CGPoint.zero
        backgroundNode.name = "background"
        // 2
        let background1 = SKSpriteNode(imageNamed: "background")
        background1.anchorPoint = CGPoint.zero
        background1.position = CGPoint(x: 0, y: 0)
        background1.size = UIScreen.main.bounds.size
        backgroundNode.addChild(background1)
        // 3
        let background2 = SKSpriteNode(imageNamed: "background")
        background2.anchorPoint = CGPoint.zero
        background2.position = CGPoint(x: 0, y: background1.size.height)
        background2.size = UIScreen.main.bounds.size
        backgroundNode.addChild(background2)
        // 4
        backgroundNode.size = CGSize(width: background1.size.width , height: background1.size.height + background2.size.height)
        return backgroundNode
    }
    
    func moveCamera() {
        cameraNode.position.y += cameraMovePointsPerSec
        spaceShip.position.y = cameraNode.position.y - 300
        spaceShip.position.x = CGFloat(self.shipX)
        enumerateChildNodes(withName: "background") { node, _ in
          let background = node as! SKSpriteNode
          if background.position.y + background.size.height <
            self.cameraRect.origin.y {
            background.position = CGPoint(
            x: background.position.x,
            y: background.position.y + background.size.height*2) }
        }
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
