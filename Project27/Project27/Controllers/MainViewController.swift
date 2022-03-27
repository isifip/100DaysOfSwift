//
//  MainViewController.swift
//  Project27
//
//  Created by Irakli Sokhaneishvili on 26.03.22.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var currentDrawType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawRectangle()
    }
    
    @IBAction func redrawTapped(_ sender: Any) {
        currentDrawType += 1
        
        // Challenge 1
        if currentDrawType > 7 {
            currentDrawType = 0
        }
        
        switch currentDrawType {
        case 0:
            drawRectangle()
        case 1:
            drawCircle()
        case 2:
            drawCheckerboard()
        case 3:
            drawRotatedSquares()
        case 4:
            drawLines()
        case 5:
            drawImagesAndText()
        case 6:
            drawSurprisedEmoji()
        case 7:
            drawStarEmoji()
        default:
            break
        }
    }
    
    func drawRectangle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { context in
            // Drawing code
            let rectange = CGRect(x: 0, y: 0, width: 512, height: 512)
            
            context.cgContext.setFillColor(UIColor.red.cgColor)
            context.cgContext.setStrokeColor(UIColor.black.cgColor)
            context.cgContext.setLineWidth(10)
            
            context.cgContext.addRect(rectange)
            context.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = image
    }
    
    func drawCircle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { context in
            // Drawing code
            let rectange = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)
            
            context.cgContext.setFillColor(UIColor.red.cgColor)
            context.cgContext.setStrokeColor(UIColor.black.cgColor)
            context.cgContext.setLineWidth(10)
            
            context.cgContext.addEllipse(in: rectange)
            context.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = image
    }
    
    func drawCheckerboard() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { context in
            // Drawing code
            context.cgContext.setFillColor(UIColor.black.cgColor)
            
            for row in 0..<8 {
                for col in 0..<8 {
                    if (row + col) % 2 == 0 {
                        context.cgContext.fill(CGRect(x: col * 64, y: row * 64, width: 64, height: 64))
                    }
                }
            }
        }
        
        imageView.image = image
    }
    
    
    func drawRotatedSquares() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { context in
            // Drawing code
            context.cgContext.translateBy(x: 256, y: 256)
            
            let rotations = 16
            let amount = Double.pi / Double(rotations)
            
            for _ in 0..<rotations {
                context.cgContext.rotate(by: CGFloat(amount))
                context.cgContext.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))
            }
            
            context.cgContext.setStrokeColor(UIColor.black.cgColor)
            context.cgContext.strokePath()
        }
        
        imageView.image = image
    }
    
    func drawLines() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { context in
            // Drawing code
            context.cgContext.translateBy(x: 256, y: 256)
            
            var first = true
            var length: CGFloat = 256
            
            for _ in 0..<256 {
                context.cgContext.rotate(by: .pi / 2)
                
                if first {
                    context.cgContext.move(to: CGPoint(x: length, y: 50))
                    first = false
                } else {
                    context.cgContext.addLine(to: CGPoint(x: length, y: 50))
                }
                
                length *= 0.99
            }
            
            context.cgContext.setStrokeColor(UIColor.blue.cgColor)
            context.cgContext.strokePath()
        }
        
        imageView.image = image
    }
    
    func drawImagesAndText() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { context in
            // Drawing code
            let parahraphStyle = NSMutableParagraphStyle()
            parahraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 36),
                .paragraphStyle: parahraphStyle
            ]
            let string = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
            let attributedString = NSAttributedString(string: string, attributes: attrs)
            
            attributedString.draw(with: CGRect(x: 32, y: 32, width: 448, height: 448), options: .usesLineFragmentOrigin, context: nil)
            
            let mouse = UIImage(named: "mouse")
            mouse?.draw(at: CGPoint(x: 300, y: 150))
        }
        
        imageView.image = image
    }
    
    
    //MARK: --> Challenge 1
    func drawSurprisedEmoji() {
        let imgWidth = 512
        let imgHeight = 512
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: imgWidth, height: imgHeight))
        
        let image = renderer.image { ctx in
            
            let faceWidth = imgWidth
            let faceHeight = imgWidth
            let faceInsets: CGFloat = 20
            
            drawFace(ctx: ctx.cgContext, width: faceWidth, height: faceHeight, insets: faceInsets, startX: 0, startY: 0, fillColor: UIColor.yellow.cgColor, strokeColor: UIColor.orange.cgColor)
            
            let eyeHorizontalMargin: CGFloat = 130
            let eyeTopMargin: CGFloat = 150
            let eyeWidth = 60
            let eyeHeight = 70
            
            let leftEyeStartX = eyeHorizontalMargin
            let leftEyeStartY = eyeTopMargin
            drawEye(ctx: ctx.cgContext, width: eyeWidth, height: eyeHeight, startX: leftEyeStartX, startY: leftEyeStartY, color: UIColor.orange.cgColor)
            
            let rightEyeStartX = CGFloat(imgWidth) - CGFloat(eyeWidth) - eyeHorizontalMargin
            let rightEyrStartY = eyeTopMargin
            drawEye(ctx: ctx.cgContext, width: eyeWidth, height: eyeHeight, startX: rightEyeStartX, startY: rightEyrStartY, color: UIColor.orange.cgColor)
            
            let mouthWidth = 100
            let mouthHeight = 110
            let mouthStartx = CGFloat((imgWidth - mouthWidth) / 2)
            let mouthStarty = CGFloat(300)
            
            drawMouth(ctx: ctx.cgContext, width: mouthWidth, height: mouthHeight, startX: mouthStartx, startY: mouthStarty, color: UIColor.orange.cgColor)
        }
        
        imageView.image = image
    }
    
    
    func drawFace(ctx: CGContext, width: Int, height: Int, insets: CGFloat, startX: CGFloat, startY: CGFloat, fillColor: CGColor, strokeColor: CGColor) {
        let face = CGRect(x: 0, y: 0, width: width, height: height).insetBy(dx: insets, dy: insets)
        
        ctx.setFillColor(UIColor.yellow.cgColor)
        ctx.setStrokeColor(UIColor.orange.cgColor)
        ctx.setLineWidth(5)
        
        ctx.translateBy(x: startX, y: startY)
        ctx.addEllipse(in: face)
        ctx.drawPath(using: .fillStroke)
        ctx.translateBy(x: -startX, y: -startY)
    }
    
    
    func drawEye(ctx: CGContext, width: Int, height: Int, startX: CGFloat, startY: CGFloat, color: CGColor) {
        let eye = CGRect(x: 0, y: 0, width: width, height: height)

        ctx.setFillColor(color)

        ctx.translateBy(x: startX, y: startY)
        ctx.addEllipse(in: eye)
        ctx.drawPath(using: .fill)
        ctx.translateBy(x: -startX, y: -startY)
    }
    
    
    func drawMouth(ctx: CGContext, width: Int, height: Int, startX: CGFloat, startY: CGFloat, color: CGColor) {
        let mouth = CGRect(x: 0, y: 0, width: width, height: height)
        
        ctx.setFillColor(color)

        ctx.translateBy(x: startX, y: startY)
        ctx.addEllipse(in: mouth)
        ctx.drawPath(using: .fill)
        ctx.translateBy(x: -startX, y: -startY)

    }
    
    
}
