//
//  GameScene.swift
//  Pachinko
//
//  Created by Ozan Mudul on 2.01.2023.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
	var scoreLabel: SKLabelNode!
	
	var score = 0 {
		didSet {
			scoreLabel.text = "Score: \(score)"
		}
	}
	
	var editLabel: SKLabelNode!
	
	var editingMode: Bool = false {
		didSet {
			if editingMode {
				editLabel.text = "Done"
			} else {
				editLabel.text = "Edit"
			}
		}
	}
	
	override func didMove(to view: SKView) {
		let background = SKSpriteNode(imageNamed: "background")
		background.position = CGPointMake(512, 384)
		background.blendMode = .replace
		background.zPosition = -1
		addChild(background)
		
		scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
		scoreLabel.text = "Score: 0"
		scoreLabel.horizontalAlignmentMode = .right
		scoreLabel.position = CGPointMake(980, 700)
		addChild(scoreLabel)
		
		editLabel = SKLabelNode(fontNamed: "Chalkduster")
		editLabel.text = "Edit"
		editLabel.position = CGPointMake(80, 700)
		addChild(editLabel)
		
		physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
		physicsWorld.contactDelegate = self
		
		makeSlot(at: CGPointMake(128, 0), isGood: true)
		makeSlot(at: CGPointMake(384, 0), isGood: false)
		makeSlot(at: CGPointMake(640, 0), isGood: true)
		makeSlot(at: CGPointMake(896, 0), isGood: false)
		
		makeBouncer(at: CGPointMake(0, 0))
		makeBouncer(at: CGPointMake(256, 0))
		makeBouncer(at: CGPointMake(512, 0))
		makeBouncer(at: CGPointMake(768, 0))
		makeBouncer(at: CGPointMake(1024, 0))
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let touch = touches.first else { return }
		let location = touch.location(in: self)
		let objects = nodes(at: location)
		
		if objects.contains(editLabel) {
			editingMode.toggle()
		} else {
			if editingMode {
				// create boxe
				let size = CGSize(width: Int.random(in: 16...128), height: 16)
				let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
				box.zRotation = CGFloat.random(in: 0...3)
				box.position = location
				
				box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
				box.physicsBody?.isDynamic = false
				addChild(box)
			} else {
				let ball = SKSpriteNode(imageNamed: "ballRed")
				ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
				ball.physicsBody?.restitution = 0.4
				ball.physicsBody?.contactTestBitMask = ball.physicsBody?.collisionBitMask ?? 0
				ball.position = location
				ball.name = "ball"
				addChild(ball)
			}
		}
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
			sloteBase.name = "good"
		} else {
			sloteBase = SKSpriteNode(imageNamed: "slotBaseBad")
			slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
			sloteBase.name = "bad"
		}
		
		sloteBase.position = position
		slotGlow.position = position
		
		sloteBase.physicsBody = SKPhysicsBody(rectangleOf: sloteBase.size)
		sloteBase.physicsBody?.isDynamic = false
		
		addChild(sloteBase)
		addChild(slotGlow)
		
		let spin = SKAction.rotate(byAngle: .pi, duration: 10)
		let spinForever = SKAction.repeatForever(spin)
		slotGlow.run(spinForever)
	}
	
	func collision(betwwen ball: SKNode, object: SKNode) {
		if object.name == "good" {
			destroy(ball: ball)
			score += 1
		} else if object.name == "bad"{
			destroy(ball: ball)
			score -= 1
		}
	}
	
	func destroy(ball: SKNode) {
		ball.removeFromParent()
	}
	
	func didBegin(_ contact: SKPhysicsContact) {
		guard let nodeA = contact.bodyA.node else { return }
		guard let nodeB = contact.bodyB.node else { return }
		
		if nodeA.name == "ball" {
			collision(betwwen: nodeA, object: nodeB)
		} else if nodeB.name == "ball" {
			collision(betwwen: nodeB, object: nodeA)
		}
	}
}
