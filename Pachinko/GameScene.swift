//
//  GameScene.swift
//  Pachinko
//
//  Created by Ozan Mudul on 2.01.2023.
//

import SpriteKit

class GameScene: SKScene {
    
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
		background.position = CGPointMake(512, 384)
		background.blendMode = .replace
		background.zPosition = -1
		addChild(background)
		
		physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let touch = touches.first else { return }
		let location = touch.location(in: self)
		
		let box = SKSpriteNode(color: .red, size: CGSizeMake(64, 64))
		box.physicsBody = SKPhysicsBody(rectangleOf: CGSizeMake(64, 64))
		box.position = location
		addChild(box)
	}
}
