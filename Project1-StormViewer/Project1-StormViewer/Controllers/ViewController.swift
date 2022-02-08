//
//  ViewController.swift
//  Project1-StormViewer
//
//  Created by Irakli Sokhaneishvili on 03.02.22.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]()
    var picturesViewCount = [String: Int]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "StormViewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)

        
        for item in items.sorted() {
            if item.hasPrefix("nssl") {
                // this is a picture to load
                pictures.append(item)
            }
        }
        
        let userDefaults = UserDefaults.standard
        picturesViewCount = userDefaults.object(forKey: "ViewCount") as? [String: Int] ?? [String: Int]()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            
            picturesViewCount[pictures[indexPath.row], default: 0] += 1
            
            vc.detailImageTitle = "Picture \(indexPath.row) of \(pictures.count)"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func saveViewCount() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(picturesViewCount, forKey: "ViewCount")
    }
}

