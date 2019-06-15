//
//  ViewController.swift
//  MyGarden
//
//  Created by Filipe Marques on 13/06/19.
//  Copyright © 2019 Filipe Marques. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var lumLabel: UILabel!
    @IBOutlet weak var humLabel: UILabel!
    
    var temperature = 18
    var luminosity = 730
    var humidity = 38
    
    @IBAction func update(_ sender: Any) {
        temperature += 1
        luminosity += 50
        humidity += 7
        updateCards()
    }
    
    @IBAction func reset(_ sender: Any) {
        temperature = 18
        luminosity = 730
        humidity = 38
        updateCards()
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barStyle = .black
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        updateCards()
    }
    
    func updateCards() {
        self.tempLabel.text = "\(temperature)º C"
        self.lumLabel.text = "\(luminosity) lm"
        self.humLabel.text = "\(humidity)%"
        self.tableView.reloadData()
    }
    
    func setStatus(of crop:Crop) -> Int {
        var tempStatus:Int = 0
        var humStatus:Int = 0
        var lumStatus:Int = 0
        
        if temperature <= crop.tempRangeStart-1 || temperature >= crop.tempRangeEnd+1 {
            tempStatus = 2
        } else if temperature >= crop.tempRangeStart+1 && temperature <= crop.tempRangeEnd-1 {
            tempStatus = 0
        } else {
            tempStatus = 1
        }
        
        if humidity <= crop.humRangeStart-10 || humidity >= crop.humRangeEnd+10 {
            humStatus = 2
        } else if humidity >= crop.humRangeStart+10 && humidity <= crop.humRangeEnd-10 {
            humStatus = 0
        } else {
            humStatus = 1
        }
        
        if luminosity <= crop.lumRangeStart-70 || luminosity >= crop.lumRangeEnd+70 {
            lumStatus = 2
        } else if luminosity >= crop.lumRangeStart+70 && luminosity <= crop.lumRangeEnd-70 {
            lumStatus = 0
        } else {
            lumStatus = 1
        }
        
        if tempStatus == 0 && humStatus == 0 && lumStatus == 0 {
            return 0
        } else if tempStatus == 2 || humStatus == 2 || lumStatus == 2 {
            return 2
        } else {
            return 1
        }
        
    }

}

extension ViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let crop = MockupData.crops[indexPath.row]
        if crop.isCollapsed {
            return 56
        } else {
            return 120
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        MockupData.crops[indexPath.row].isCollapsed = !MockupData.crops[indexPath.row].isCollapsed
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
}

extension ViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MockupData.crops.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cropCell", for: indexPath) as! TableViewCell
        let crop = MockupData.crops[indexPath.row]
        cell.cellImage.image = crop.image
        cell.cellTitle.text = crop.name
        cell.tempRange.text = "Temperatura: \(crop.tempRangeStart) ºC ~ \(crop.tempRangeEnd) ºC"
        cell.lumRange.text = "Luminosidade: \(crop.lumRangeStart) lm ~ \(crop.lumRangeEnd) lm"
        cell.humRange.text = "Umidade: \(crop.humRangeStart)% ~ \(crop.humRangeEnd)%"
        
        if crop.isCollapsed {
            cell.tempRange.alpha = 0.0
            cell.humRange.alpha = 0.0
            cell.lumRange.alpha = 0.0
            cell.cellCaret.transform = CGAffineTransform(scaleX: 1, y: 1);
        } else {
            cell.tempRange.alpha = 1.0
            cell.humRange.alpha = 1.0
            cell.lumRange.alpha = 1.0
            cell.cellCaret.transform = CGAffineTransform(scaleX: 1, y: -1);
        }
        
        // TODO: Change for the right func after updating mockup data
        let status = setStatus(of: crop)
        
        switch status {
        case 0:
            cell.cellStatus.text = "Ótimo!"
            cell.cellStatus.textColor = UIColor(red: 64/255, green: 192/255, blue: 87/255, alpha: 1.0)
        case 1:
            cell.cellStatus.text = "Regular"
            cell.cellStatus.textColor = UIColor(red: 250/255, green: 176/255, blue: 5/255, alpha: 1.0)
        default:
            cell.cellStatus.text = "Ruim"
            cell.cellStatus.textColor = UIColor(red: 250/255, green: 82/255, blue: 82/255, alpha: 1.0)
        }
        
        return cell
    }
}
