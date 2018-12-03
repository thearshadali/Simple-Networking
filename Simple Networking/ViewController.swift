//
//  ViewController.swift
//  Simple Networking
//
//  Created by Arshad Ali on 03/12/18.
//  Copyright © 2018 Arshad Ali. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func requestButtonAction(_ sender: Any) {
        imageView.image = nil
        progress.progress = 0.0
        request(url: "https://www.fabfilter.com/static/img/download.png?v=1494430597")
    }
    
    //https://www.fabfilter.com/static/img/download.png?v=1494430597
    func request(url:String){
        let url = URL(string: url)!
        let session = URLSession.shared
//        let task = session.dataTask(with: url) { (data, response, error) in
//                if error == nil && data != nil {
//                    let image =  UIImage(data: data!)
//                    DispatchQueue.main.async {
//                        self.imageView.image = image
//                    }
//                }
//            }
        
        
        let task = session.downloadTask(with: url) { (fileUrl, response, error) in
            if let furl = fileUrl,let d = try? Data(contentsOf: furl){
                let im = UIImage(data: d)
                DispatchQueue.main.async {
                    self.imageView.image = im
                }
            }
        }
       self.progress.observedProgress = task.progress
       task.resume()
    }
    
    
    // Creating session using initializer with delegate
    
    func requestSecond(urlString:String){
        let url = URL(string: urlString)!
//        let urlSessionConfiguration = URLSessionConfiguration.init()   // never do that
        let urlSessionConfiguration = URLSessionConfiguration.ephemeral
        urlSessionConfiguration.allowsCellularAccess = true
        
        let session = URLSession.init(configuration: urlSessionConfiguration, delegate: self, delegateQueue: .main)
        let task = session.dataTask(with: url)
        task.resume()
        
        // all update progress tracking etc done through delegate methods
    }
}


extension ViewController: URLSessionDelegate {
    
    
}
