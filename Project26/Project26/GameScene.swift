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
  
    override func didMove(to view: SKView) {
  
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
                } else if letter == "f" {
                    // load finish point
                } else {
                    fatalError("Unknown level letter: \(letter)")
                }
            }
        }
    }
}
