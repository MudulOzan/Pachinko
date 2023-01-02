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
	
		makeSlot(at: CGPointMake(128, 0), isGood: true)
		makeSlot(at: CGPointMake(384, 0), isGood: false)
		makeSlot(at: CGPointMake(640, 0), isGood: true)
		makeSlot(at: CGPointMake(896, 0), isGood: false)
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
	
	func makeSlot(at position: CGPoint, isGood: Bool) {
		var sloteBase: SKSpriteNode
		var slotGlow: SKSpriteNode
		
		if isGood {
			sloteBase = SKSpriteNode(imageNamed: "slotBaseGood")
			slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
		} else {
			sloteBase = SKSpriteNode(imageNamed: "slotBaseBad")
			slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
		}
		
		sloteBase.position = position
		slotGlow.position = position
		
		addChild(sloteBase)
		addChild(slotGlow)
		
		let spin = SKAction.rotate(byAngle: .pi, duration: 10)
		let spinForever = SKAction.repeatForever(spin)
		slotGlow.run(spinForever)
	}
}
