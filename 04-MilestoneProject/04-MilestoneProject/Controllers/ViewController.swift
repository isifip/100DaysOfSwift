//
//  ViewController.swift
//  04-MilestoneProject
//
//  Created by Irakli Sokhaneishvili on 12.02.22.
//

import UIKit

class ViewController: UITableViewController {
    
    var countries = [Country]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Countries"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        if let jsonUrl = Bundle.main.url(forResource: "Countries", withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: jsonUrl)
                let jsonDecoder = JSONDecoder()
                let countries = try jsonDecoder.decode([Country].self, from: jsonData)
                //self.countries = countries\
                self.countries = countries
            } catch {
                print("Couldn't parse local JSON data")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        let country = countries[indexPath.row]
        cell.textLabel?.text = country.name
        //cell.imageView?.image = UIImage(named: country.flag)
        return cell
    }


}

