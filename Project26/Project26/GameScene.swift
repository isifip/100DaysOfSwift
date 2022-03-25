//
//  GameScene.swift
//  Project26
//
//  Created by Irakli Sokhaneishvili on 25.03.22.
//

import SpriteKit

enum CollisinTypes: UInt32 {
    case player = 1
    case wall = 2
    case star = 4
    case vortex = 8
    case finish = 16
}

class GameScene: SKScene {
    
    var player: SKSpriteNode!
  
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        loadLevel()
        createPlayer()
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
                
                if letter == "x" {
                    // load wall
                    let node = SKSpriteNode(imageNamed: "block")
                    node.position = position
                    
                    node .physicsBody = SKPhysicsBody(rectangleOf: node.size)
                    node.physicsBody?.categoryBitMask = CollisinTypes.wall.rawValue
                    node.physicsBody?.isDynamic = false
                    
                    addChild(node)
                    
                } else if letter == "v" {
                    // load vortex
                    let node = SKSpriteNode(imageNamed: "vortex")
                    node.name = "vortex"
                    node.position = position
                    
                    node.run(SKAction.repeatForever(SKAction.rotate(byAngle: .pi, duration: 1)))
                    
                    node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
                    node.physicsBody?.isDynamic = false
                    node.physicsBody?.categoryBitMask = CollisinTypes.vortex.rawValue
                    node.physicsBody?.contactTestBitMask = CollisinTypes.player.rawValue
                    node.physicsBody?.collisionBitMask = 0
                    
                    addChild(node)
                    
                } else if letter == "s" {
                    // load star
                    let node = SKSpriteNode(imageNamed: "star")
                    
                    node.name = "star"
                    node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
                    node.physicsBody?.isDynamic = false
                    node.physicsBody?.categoryBitMask = CollisinTypes.star.rawValue
                    node.physicsBody?.contactTestBitMask = CollisinTypes.player.rawValue
                    node.physicsBody?.collisionBitMask = 0
                    
                    node.position = position
                    
                    addChild(node)
                    
                } else if letter == "f" {
                    // load finish point
                    
                    let node = SKSpriteNode(imageNamed: "finish")
                    
                    node.name = "finish"
                    node.physicsBody = SKPhysicsBody(circleOfRadius: node.size.width / 2)
                    node.physicsBody?.isDynamic = false
                    node.physicsBody?.categoryBitMask = CollisinTypes.finish.rawValue
                    node.physicsBody?.contactTestBitMask = CollisinTypes.player.rawValue
                    node.physicsBody?.collisionBitMask = 0
                    
                    node.position = position
                    
                    addChild(node)
                } else if letter == " " {
                    // Empty space - do nothing
                } else {
                    fatalError("Unknown level letter: \(letter)")
                }
            }
        }
    }
    
    func createPlayer() {
        player = SKSpriteNode(imageNamed: "player")
        player.position = CGPoint(x: 96, y: 672)
        
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width / 2)
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.linearDamping = 0.5
        
        player.physicsBody?.categoryBitMask = CollisinTypes.player.rawValue
        player.physicsBody?.contactTestBitMask = CollisinTypes.star.rawValue | CollisinTypes.vortex.rawValue | CollisinTypes.finish.rawValue
        player.physicsBody?.collisionBitMask = CollisinTypes.wall.rawValue
        
        addChild(player)
    }
}
