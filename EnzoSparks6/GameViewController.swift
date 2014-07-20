//
//  GameViewController.swift
//  EnzoSparks6
//
//  Created by Enio Ohmaye on 7/19/14.
//  Copyright (c) 2014 Enio Ohmaye. All rights reserved.
//

import UIKit
import SpriteKit

extension SKNode {
    class func unarchiveFromFile(file : NSString) -> SKNode? {
        
        let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks")
        
        var sceneData = NSData.dataWithContentsOfFile(path, options: .DataReadingMappedIfSafe, error: nil)
        var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
        
        archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
        let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as GameScene
        archiver.finishDecoding()
        return scene
    }
}

class GameViewController: UIViewController {
    
    var skView : SKView!
    var skScene : GameScene!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            // Configure the view.
            skView = self.view as SKView
            skScene = scene
            
            // DEBUG
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            // TST
            addView(CGPoint(x: 50, y: 50))
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill

            skView.presentScene(scene)
        }
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        
        for touch: AnyObject in touches! {
            let location = touch.locationInNode(skScene)
            if let node = skScene.nodeAtPoint(location) as? SKShapeNode {
                // If an emitter was touched, then grow it.
                node.grow()
                //moveEmitter( location )
            } else {
                // If not, then create one.
                addView(touch.locationInView(skView))
                skScene.addEmitter(location)
            }
        }
    }
    
    // Add a view that will control an emitter in the SKScene.
    func addView( location: CGPoint) {
        let kWidth : CGFloat = 50.0
        let kHeight : CGFloat = 50.0
        let x = location.x - kWidth / 2
        let y = location.y - kHeight / 2
        
        let view = UIView(frame: CGRect(x: x, y: y, width: kWidth, height: kHeight))
        view.backgroundColor = UIColor.blueColor()
        self.view.addSubview(view)
        
        // Add gesture recognizer to handle drag
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: handlePanGesture)
    }
    
    
    @IBAction func handlePanGesture( gestureRecognizer : UIGestureRecognizer ) {
        let location = gestureRecognizer.locationInView(self.view)
        ((self.view as SKView).scene as GameScene).moveEmitter( location )
    }
    

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.toRaw())
        } else {
            return Int(UIInterfaceOrientationMask.All.toRaw())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
