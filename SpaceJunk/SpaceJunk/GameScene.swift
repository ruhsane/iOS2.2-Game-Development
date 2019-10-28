//
//  GameScene.swift
//  SpaceJunk
//
//  Created by Ruhsane Sawut on 10/28/19.
//  Copyright © 2019 ruhsane. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let backgroundNode = SKSpriteNode(imageNamed: "vectorstock_16606572")
    let meteorites = SKSpriteNode(imageNamed: "meteorGrey_med1")
    let spaceDebris = SKSpriteNode(imageNamed: "wingRed_2")
    let spaceShip = SKSpriteNode(imageNamed: "playerShip2_red")
    
    override func didMove(to view: SKView) {
        
        backgroundNode.position = CGPoint(x: scene!.frame.midX, y: scene!.frame.midY)
        backgroundNode.size = CGSize(width: scene!.frame.width, height: scene!.frame.height)
        backgroundNode.zPosition = -1
        scene?.addChild(backgroundNode)
        
        meteorites.position = CGPoint(x: scene!.frame.midX + 50 , y: scene!.frame.minY + 150)
        scene?.addChild(meteorites)
        
        spaceDebris.position = CGPoint(x: scene!.frame.minX + 150 , y: scene!.frame.maxY - 300)
        scene?.addChild(spaceDebris)
        
        spaceShip.position = CGPoint(x: scene!.frame.midX , y: scene!.frame.minY + 50 )
        spaceShip.size = CGSize(width: 70, height: 50)
        scene?.addChild(spaceShip)
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
