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
		
		makeBouncer(at: CGPointMake(0, 0))
		makeBouncer(at: CGPointMake(256, 0))
		makeBouncer(at: CGPointMake(512, 0))
		makeBouncer(at: CGPointMake(768, 0))
		makeBouncer(at: CGPointMake(1024, 0))
    }
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let touch = touches.first else { return }
		let location = touch.location(in: self)
		
		let ball = SKSpriteNode(imageNamed: "ballRed")
		ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
		ball.physicsBody?.restitution = 0.4
		ball.position = location
		addChild(ball)
	}
	
	func makeBouncer(at position: CGPoint) {
		let bouncer = SKSpriteNode(imageNamed: "bouncer")
		bouncer.position = position
		bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2)
		bouncer.physicsBody?.isDynamic = false
		addChild(bouncer)
	}
}
