//
//  ViewController.swift
//  AlamofireMultipleDownload+GCD
//
//  Created by Duong Dang Hoang on 18/6/18.
//  Copyright © 2018 Duong Dang Hoang. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    @IBOutlet var imageViewArr: [UIImageView]!
    @IBOutlet var labelArr: [UILabel]!
    
    
    let IMAGE_URL_ARR: [String] = [
        "http://www.altinawildlife.com/wp-content/uploads/2016/10/Google-app-icon-small.png",
        "https://cdn.eso.org/images/screen/potw1023a.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/e/e3/Large_and_small_magellanic_cloud_from_new_zealand.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/3/3d/LARGE_elevation.jpg"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startBtnWasPressed(_ sender: Any) {
        let utilityDQ = DispatchQueue.global(qos: .utility)
        
        for i in 0..<IMAGE_URL_ARR.count{
            Alamofire.request(IMAGE_URL_ARR[i])
            .downloadProgress(queue: utilityDQ){ progess in
                DispatchQueue.main.async {
                    self.labelArr[i].text = "\(progess.fractionCompleted)"
                }
            }
            .responseData{ response in
                if let data = response.data, let image = UIImage(data: data){
                    self.imageViewArr[i].image = image
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

