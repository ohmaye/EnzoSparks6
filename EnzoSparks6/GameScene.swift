//
//  GameScene.swift
//  EnzoSparks6
//
//  Created by Enio Ohmaye on 7/19/14.
//  Copyright (c) 2014 Enio Ohmaye. All rights reserved.
//

import SpriteKit

extension SKEmitterNode {
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        let action = SKAction.scaleBy(2.0, duration: 0.5)
        let action2 = SKAction.scaleBy(0.5, duration: 0.5)
        let action3 = SKAction.sequence([action, action2])
        self.runAction(action3)
    }
}

class GameScene: SKScene {
    
    var emitter : SKEmitterNode?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        backgroundColor = SKColor.blackColor()
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        let location = touches.anyObject().locationInNode(self)
        if !emitter {
            if let emit = loadNode("SparkParticle") as? SKEmitterNode {
                emitter = emit
                emit.position = location
                self.addChild(emit)
            }
        }
        if let emit = emitter? {
            println(emit.containsPoint(location))
            println(emit.calculateAccumulatedFrame())
            println(emit.frame)
            //
            emit.position = location

        }
        
    }
    
    /*
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            let sprite = SKSpriteNode(imageNamed:"Spaceship")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)
        }
    }
    */
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    /* Helper functions */
    
    func showEmitter( name : String, position : CGPoint) -> SKEmitterNode {
        let path = NSBundle.mainBundle().pathForResource(name, ofType: "sks")
        let emitter = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? SKEmitterNode
        emitter!.position = position
        self.addChild(emitter!)
        return emitter!
    }
    
    func loadNode<NodeClass> ( name : String) -> NodeClass?  {
        let path = NSBundle.mainBundle().pathForResource(name, ofType: "sks")
        let node = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? NodeClass
        return node
    }

}
