//
//  WeatherViewController.swift
//  ToDoList
//
//  Created by Nikita Robertson on 16.02.2020.
//  Copyright © 2020 Nikita Robertson. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var currentWeather: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCurrentWeather()
    }
    override func viewDidAppear(_ animated: Bool) {
        loadAlamofire(completion: {self.tableView.reloadData(); self.setCurrentWeather()})
    }
    
    func setCurrentWeather(){
        if days.count > 0 {
            currentWeather.text = "\(days[0].temp) \(days[0].weather)"
        } else { currentWeather.text = "0 nan" }
    }

}

extension WeatherViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return days[section].day
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! WeatherCell
        cell.weatherLabel.text = days[indexPath.section].weather
        cell.tempLabel.text = "\(days[indexPath.section].temp)"
        return cell
    }
    
    
}
