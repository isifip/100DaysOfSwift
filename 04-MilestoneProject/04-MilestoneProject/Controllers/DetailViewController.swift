//
//  DetailViewController.swift
//  04-MilestoneProject
//
//  Created by Irakli Sokhaneishvili on 12.02.22.
//

import UIKit

class DetailViewController: UIViewController {
    
    var country: Country!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "\(country.name)"
        navigationItem.largeTitleDisplayMode = .never
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
