//
//  ViewController.swift
//  MVVMDemo
//
//  Created by Wayne Hsiao on 2019/5/20.
//  Copyright © 2019 Wayne Hsiao. All rights reserved.
//

import UIKit
import SimpleReactive

class ViewController: UIViewController {
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var city: UILabel! {
        didSet {
            addObserver(self, forKeyPath: "city.text", options: [.new], context: nil)
            labels.append(city)
        }
    }
    @IBOutlet weak var temperature: UILabel! {
        didSet {
            addObserver(self, forKeyPath: "temperature.text", options: [.new], context: nil)
            labels.append(temperature)
        }
    }
    @IBOutlet weak var precipitation: UILabel! {
        didSet {
            addObserver(self, forKeyPath: "precipitation.text", options: [.new], context: nil)
            labels.append(precipitation)
        }
    }
    var labels = [UILabel]()
    let weatherViewModel = WeatherViewModel()
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        switch keyPath {
        case "city.text", "temperature.text", "precipitation.text":
            for label in labels {
                label.alpha = 0.0
            }
            UIView.animate(withDuration: 0.5) {
                for label in self.labels {
                    label.alpha = 1.0
                }
            }
        default:
            break
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUIComponents()
    }
    
    func bindUIComponents() {
        weatherViewModel.city.bindTo(label: city)
        weatherViewModel.temperature.bindTo(label: temperature)
        weatherViewModel.precipitation.bindTo(label: precipitation)
    }
    
    @IBAction func refresh(_ sender: Any) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let indicatorViewController = LoadingViewController.initWithFrame(view.frame)
        present(indicatorViewController, animated: false, completion: nil)
        weatherViewModel.fetchWeather { (_) in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                indicatorViewController.dismiss(animated: false, completion: nil)
            }
        }
    }
}

