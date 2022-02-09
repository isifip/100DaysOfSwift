//
//  ViewController.swift
//  03-MilestoneProject
//
//  Created by Irakli Sokhaneishvili on 09.02.22.
//

import UIKit

class ViewController: UITableViewController {
    
    var images = [Image]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewImage))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        images.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath) as? ImageCell else  {
            fatalError("Unable to deque Image cell")
        }
        
        let image = images[indexPath.row]
        cell.captionName.text = image.caption
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // more code to come
    }
    
    
    @objc func addNewImage() {
        
    }

}

