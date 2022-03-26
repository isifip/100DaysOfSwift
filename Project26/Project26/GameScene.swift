//
//  GameScene.swift
//  Project26
//
//  Created by Irakli Sokhaneishvili on 25.03.22.
//

import CoreMotion
import SpriteKit

enum CollisionTypes: UInt32 {
    case player = 1
    case wall = 2
    case star = 4
    case vortex = 8
    case finish = 16
    case portal = 32
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player: SKSpriteNode!
    var lastTouchPosition: CGPoint?
    
    var motionManager: CMMotionManager?
    
    var isGameOver = false
    
    var scoreLabel: SKLabelNode!
    var portalActive = true
    
    var restartGameLabel: SKLabelNode!
    var restartLevelLabel: SKLabelNode!
    var nextLevelLabel: SKLabelNode!
    var finishNode: SKSpriteNode!
    
    var currentLevelLabel: SKLabelNode!
    
    var currentLevel = 1 {
        didSet {
            currentLevelLabel.text = "Level: \(currentLevel)"
        }
    }
    var maxLevel = 7
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.position = CGPoint(x: 16, y: 16)
        scoreLabel.zPosition = 2
        addChild(scoreLabel)
        
        currentLevelLabel = SKLabelNode(fontNamed: "Chalkduster")
        currentLevelLabel.text = "Level: \(currentLevel)"
        currentLevelLabel.horizontalAlignmentMode = .left
        currentLevelLabel.position = CGPoint(x: 16, y: 730)
        currentLevelLabel.zPosition = 2
        currentLevelLabel.name = "currentLevel"
        addChild(currentLevelLabel)
        
        prepareFinishLabels()
        
        loadLevel()
        createPlayer()
        
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
        
        motionManager = CMMotionManager()
        motionManager?.startAccelerometerUpdates()
    }
    
    
    func prepareFinishLabels() {
        finishNode = SKSpriteNode(imageNamed: "finish")
        finishNode.position = CGPoint(x: 512, y: 544)
        finishNode.zPosition = 2

        nextLevelLabel = SKLabelNode(fontNamed: "Chalkduster")
        nextLevelLabel.text = "Next Level"
        nextLevelLabel.fontSize = 48
        nextLevelLabel.name = "nextLevel"
        nextLevelLabel.horizontalAlignmentMode = .center
        nextLevelLabel.position = CGPoint(x: 512, y: 454)
        nextLevelLabel.zPosition = 2
        
        restartLevelLabel = SKLabelNode(fontNamed: "Chalkduster")
        restartLevelLabel.text = "Restart Level"
        restartLevelLabel.fontSize = 48
        restartLevelLabel.name = "restartLevel"
        restartLevelLabel.horizontalAlignmentMode = .center
        restartLevelLabel.position = CGPoint(x: 512, y: 384)
        restartLevelLabel.zPosition = 2
        
        restartGameLabel = SKLabelNode(fontNamed: "Chalkduster")
        restartGameLabel.text = "Restart Game"
        restartGameLabel.fontSize = 48
        restartGameLabel.name = "restartGame"
        restartGameLabel.horizontalAlignmentMode = .center
        restartGameLabel.position = CGPoint(x: 512, y: 314)
        restartGameLabel.zPosition = 2
    }
    
    func loadLevel() {
        
        guard let levelURL = Bundle.main.url(forResource: "level1", withExtension: "txt") else {
            fatalError("Could not find level1.txt in the app bundle")
        }
        guard let levelString = try? String(contentsOf: levelURL) else {
            fatalError("Could not find level1.txt in the app bundle")
        }
        
        let lines = levelString.components(separatedBy: "\n")
        
        for (row, line) in lines.reversed().enumerated() {
            for (column, letter) in line.enumerated() {
                let position = CGPoint(x: (64 * column) + 32, y: (64 * row) + 32)
                
                // Challenge 1
                addLevelElement(withId: letter, to: position)
            }
        }
    }
    
    // challenge 2
    func destroyLevel() {
        for node in children {
            if ["wall", "vortex", "star", "finish", "portal"].contains(node.name) {
                node.removeFromParent()
            }
        }
        player.removeFromParent()
    }
    
    //MARK: --> Challenge 1
    func addLevelElement(withId letter: Character, to position: CGPoint) {
        if letter == "x" {
            addWall(to: position)
        }
        else if letter == "v" {
            addVortex(to: position)
        }
        else if letter == "s" {
            addStar(to: position)
        }
        else if letter == "f" {
            addFinish(to: position)
        } else if letter == " " {
            // empty space, do nothing
        }
        else {
            fatalError("Unknown level letter: \(letter)")
        }
    }
    
    // challenge 1
    func addWall(to position: CGPoint) {
        let node = SKSpriteNode(imageNamed: "block")
        node.position = position
        node.name = "wall"
        
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.categoryBitMask = CollisionTypes.wall.rawValue
        node.physicsBody?.isDynamic = false
        
        addChild(node)
    }
    
    // challenge 1
    func addVortex(to position: CGPoint) {
        let node = SKSpriteNode(imageNamed: "vortex")
        node.name = "vortex"
        node.position = position
        
        node.run(SKAction.repeatForever(SKAction.rotate(byAngle: .pi, duration: 1)))
        
        node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = CollisionTypes.vortex.rawValue
        node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
        node.physicsBody?.collisionBitMask = 0
        
        addChild(node)
    }
    
    // challenge 1
    func addStar(to position: CGPoint) {
        let node = SKSpriteNode(imageNamed: "star")
        node.name = "star"
        node.position = position
        
        node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = CollisionTypes.star.rawValue
        node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
        node.physicsBody?.collisionBitMask = 0
        
        addChild(node)
    }
    
    // challenge 1
    func addFinish(to position: CGPoint) {
        let node = SKSpriteNode(imageNamed: "finish")
        node.name = "finish"
        node.position = position
        
        node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask = CollisionTypes.finish.rawValue
        node.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
        node.physicsBody?.collisionBitMask = 0
        
        addChild(node)
    }
    
    
    
    func createPlayer() {
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: 96, y: 672)
        player.zPosition = 1
        
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width / 2)
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.linearDamping = 0.5
        
        player.physicsBody?.categoryBitMask = CollisionTypes.player.rawValue
        player.physicsBody?.contactTestBitMask = CollisionTypes.star.rawValue | CollisionTypes.vortex.rawValue | CollisionTypes.finish.rawValue
        player.physicsBody?.collisionBitMask = CollisionTypes.wall.rawValue
        
        addChild(player)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        lastTouchPosition = location
        
        // challenge 2
        for node in nodes(at: location) {
            if node.name == "nextLevel" {
                currentLevel += 1
                if currentLevel > maxLevel {
                    currentLevel = 1
                }
                restart()
            }
            else if node.name == "restartLevel" {
                restart()
            }
            else if node.name == "restartGame" {
                score = 0
                currentLevel = 1
                restart()
            }
            else if node.name == "currentLevel" {
                player.removeAllActions()
                player.physicsBody?.isDynamic = false
                addChild(nextLevelLabel)
                addChild(restartLevelLabel)
                addChild(restartGameLabel)
            }
        }
    }
    
    // challenge 2
    func restart() {
        finishNode.removeFromParent()
        nextLevelLabel.removeFromParent()
        restartLevelLabel.removeFromParent()
        restartGameLabel.removeFromParent()
        destroyLevel()
        loadLevel()
        createPlayer()
        isGameOver = false
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchPosition = nil
    }
    
    override func update(_ currentTime: TimeInterval) {
        #if targetEnvironment(simulator)
        if let lastTouchPosition = lastTouchPosition {
            let diff = CGPoint(x: lastTouchPosition.x - player.position.x, y: lastTouchPosition.y - player.position.y)
            physicsWorld.gravity = CGVector(dx: diff.x / 100, dy: diff.y / 100)
        }
        #else
        if let accelerometerData = motionManager?.accelerometerData {
            physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.y * -50, dy: accelerometerData.acceleration.x * 50)
        }
        #endif
    }
}
