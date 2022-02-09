//
//  ViewController.swift
//  03-MilestoneProject
//
//  Created by Irakli Sokhaneishvili on 09.02.22.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var images = [Image]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewImage))
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Image", for: indexPath) as? ImageCell else  {
            fatalError("Unable to deque Image cell")
        }
        
        let person = images[indexPath.row]
        cell.captionName.text = person.caption
        let path = getDocumentsDirectory().appendingPathComponent(person.imageName)
        cell.imageView?.image = UIImage(contentsOfFile: path.path)
        cell.imageView?.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView?.layer.borderWidth = 2
        cell.imageView?.layer.cornerRadius = 3
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // more code to come
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let partImage = Image(caption: "Unknown", imageName: imageName)
        images.append(partImage)
        tableView.reloadData()
        
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
    @objc func addNewImage() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }

}

