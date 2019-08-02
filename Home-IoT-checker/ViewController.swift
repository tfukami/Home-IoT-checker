//
//  ViewController.swift
//  Home-IoT-checker
//
//  Created by 深見 on 2019/07/21.
//  Copyright © 2019 深見. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var allView: UIScrollView!
    fileprivate let refreshCtl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allView.refreshControl = refreshCtl
        refreshCtl.addTarget(self, action: #selector(ViewController.refresh(sender:)), for: .valueChanged)
        
        topImage.image = UIImage(named: "IMG_1191")
        tempGraph.image = getImageByUrl(port: 5050, url:"pic/temperature.png")
        powerGraph.image = getImageByUrl(port: 5050, url:"pic/power.png")
        cameraView.image = getImageByUrl(port: 8999, url: "?action=snapshot")
        
        guard let req_url = URL(string: "") else {
        //guard let req_url = URL(string: "http://192.168.10.106:5050/dat/dat.json") else {
            print("error:")
            return
        }
        let req = URLRequest(url: req_url)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: req, completionHandler: {
            (data, response, error) in
            session.finishTasksAndInvalidate()
            
            do {
                let decoder = JSONDecoder()
                let json = try decoder.decode(DataJson.self, from: data!)

                if let power = json.power_value, let temperature = json.temp_value, let power_time = json.power_time, let temperature_time = json.temp_time {
                    self.powerValue.text = "\(power)W"
                    self.tempValue.text = "\(temperature)℃"
                    self.power_time.text = "\(power_time)"
                    self.temperatureTime.text = "\(temperature_time)"
                }
            } catch {
                print("error:", error.localizedDescription)
            }
        })
        task.resume()
        
    }
    
    struct DataJson: Codable {
        var power_time: String?
        var power_value: String?
        var temp_time: String?
        var temp_value: String?
        var humid_time: String?
        var humid_value: String?
        var aircon_stat: String?
        var aircon_time: String?
        var motion_time: String?
        var light_time: String?
        var light_value: String?
        var tv_time: String?
        var tv_channel: String?
        var tv_stat: String?
        var fun_stat: String?
        var fun_time: String?
    }

    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var powerGraph: UIImageView!
    @IBOutlet weak var tempGraph: UIImageView!
    
    @IBOutlet weak var powerValue: UILabel!
    @IBOutlet weak var tempValue: UILabel!
    
    @IBOutlet weak var power_time: UILabel!
    @IBOutlet weak var temperatureTime: UILabel!
    
    @IBOutlet weak var cameraView: UIImageView!
    @IBAction func cameraUpButton(_ sender: Any) {
    }
    @IBAction func cameraDownButton(_ sender: Any) {
    }
    @IBAction func cameraLeftButton(_ sender: Any) {
    }
    @IBAction func cameraRightButton(_ sender: Any) {
    }
    
    @IBAction func cameraReloadButton(_ sender: Any) {
        cameraView.image = getImageByUrl(port: 8999, url: "?action=snapshot")
    }

    @IBAction func remoconButton(_ sender: Any) {
        performSegue(withIdentifier: "toremotecontroller", sender: nil)
    }
    
    func getImageByUrl(port: Int, url: String) -> UIImage{
        //let url = URL(string: "http://192.168.10.106:\(port)/\(url)")
        let url = URL(string: "")
        do {
            let data = try Data(contentsOf: url!)
            return UIImage(data: data)!
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
        return UIImage()
    }
    
    
    @objc func refresh(sender: UIRefreshControl) {
        tempGraph.image = getImageByUrl(port: 5050, url:"pic/temperature.png")
        powerGraph.image = getImageByUrl(port: 5050, url:"pic/power.png")
        cameraView.image = getImageByUrl(port: 8999, url: "?action=snapshot")
        
        self.topImage.reloadInputViews()
        
        guard let req_url = URL(string: "") else {
        //guard let req_url = URL(string: "http://192.168.10.106:5050/dat/dat.json") else {
            print("error:")
            return
        }
        let req = URLRequest(url: req_url)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: req, completionHandler: {
            (data, response, error) in
            session.finishTasksAndInvalidate()
            
            do {
                let decoder = JSONDecoder()
                let json = try decoder.decode(DataJson.self, from: data!)
                
                if let power = json.power_value, let temperature = json.temp_value, let power_time = json.power_time, let temperature_time = json.temp_time {
                    self.powerValue.text = "\(power)W"
                    self.tempValue.text = "\(temperature)℃"
                    self.power_time.text = "\(power_time)"
                    self.temperatureTime.text = "\(temperature_time)"
                }
            } catch {
                print("error:", error.localizedDescription)
            }
        })
        task.resume()
        sender.endRefreshing()
    }
    
}

