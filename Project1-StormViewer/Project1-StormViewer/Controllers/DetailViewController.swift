//
//  DetailViewController.swift
//  Project1-StormViewer
//
//  Created by Irakli Sokhaneishvili on 03.02.22.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?
    var detailImageTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = detailImageTitle
        navigationItem.largeTitleDisplayMode = .never
        // Do any additional setup after loading the view.
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
}
