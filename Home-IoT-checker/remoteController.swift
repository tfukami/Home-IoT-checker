//
//  remoteController.swift
//  Home-IoT-checker
//
//  Created by 深見 on 2019/07/24.
//  Copyright © 2019 深見. All rights reserved.
//

import UIKit
class remoteController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tvSegmentControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            sendinfrared(device: "tv", command: "tv_on")
        case 1:
            sendinfrared(device: "tv", command: "tv_off")
        default:
            print("")
        }
    }
    
    @IBAction func cellingrightSegmentContol(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            sendinfrared(device: "light", command: "light_on")
        case 1:
            sendinfrared(device: "light", command: "light_off")
        default:
            print("")
        }
    }
    
    @IBAction func airconSegmentControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            sendinfrared(device: "aircon", command: "aircon_on")
        case 1:
            sendinfrared(device: "aircon", command: "aircon_off")
        default:
            print("")
        }
    }
    
    func sendinfrared(device:String, command:String) {
        let url = URL(string: "")
        //let url = URL(string: "http://192.168.10.106:5050/\(device)/\(command).php?token=")
        let request = URLRequest(url: url!)
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if error == nil, let _ = data, let response = response as? HTTPURLResponse {
                // HTTPステータスコード
                print("statusCode: \(response.statusCode)")
            }
            }.resume()
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
