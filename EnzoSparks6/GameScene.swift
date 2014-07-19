//
//  GameScene.swift
//  EnzoSparks6
//
//  Created by Enio Ohmaye on 7/19/14.
//  Copyright (c) 2014 Enio Ohmaye. All rights reserved.
//

import SpriteKit

extension SKEmitterNode {
    func grow() {
        self.removeAllActions()
        let action1 = SKAction.scaleBy(2.0, duration: 0.5)
        let action2 = SKAction.scaleBy(0.5, duration: 0.5)
        let action3 = SKAction.waitForDuration(2.0)
        let action4 = SKAction.removeFromParent()
        let actions = SKAction.sequence([action1, action2, action3, action4])
        self.runAction(actions)
    }
}

class GameScene: SKScene {
    
    var emitter : SKEmitterNode?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        backgroundColor = SKColor.blackColor()
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        
        for touch: AnyObject in touches! {
            let location = touch.locationInNode(self)
            if let node = nodeAtPoint(location) as? SKEmitterNode {
                // If an emitter was touched, then grow it.
                node.grow()
            } else {
                // If not, then create one.
                addEmitter(location)
            }
        }
    }
    
    

    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    /* Helper functions */
    
    func loadNode<NodeClass> ( name : String) -> NodeClass?  {
        let path = NSBundle.mainBundle().pathForResource(name, ofType: "sks")
        let node = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? NodeClass
        return node
    }
    
    func addEmitter(location: CGPoint) {
        if let emit = loadNode("SparkParticle") as? SKEmitterNode {
            emit.position = location
            let action1 = SKAction.waitForDuration(2.0)
            let action2 = SKAction.removeFromParent()
            let actions = SKAction.sequence([action1, action2])
            emit.runAction(actions)
            self.addChild(emit)
        }
    }

}
