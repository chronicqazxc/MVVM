//
//  LoadingViewController.swift
//  MVVMDemo
//
//  Created by Wayne Hsiao on 2019/5/26.
//  Copyright © 2019 Wayne Hsiao. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    let indicatorView = UIActivityIndicatorView()
    
    static func initWithFrame(_ frame: CGRect) -> UIViewController {
        let modalViewController = LoadingViewController(nibName: nil, bundle: nil)
        modalViewController.modalPresentationStyle = .overCurrentContext
        modalViewController.view.frame = frame
        return modalViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 0.3449539812)
        indicatorView.startAnimating()
        indicatorView.style = .white
        view.addSubview(indicatorView)
        setupAutoLayout()
    }
    
    func setupAutoLayout() {
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        let indicatorViewKey = "indicatorView"
        let views = ["\(indicatorViewKey)": indicatorView]
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(indicatorViewKey)]|", options: .alignAllCenterY, metrics: nil, views: views)
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[\(indicatorViewKey)]|", options: .alignAllCenterX, metrics: nil, views: views)
        NSLayoutConstraint.activate(horizontalConstraints)
        NSLayoutConstraint.activate(verticalConstraints)
    }
}
