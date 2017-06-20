//
//  KBOpenAppStoreViewController.swift
//  SwiftDayDayStudy
//
//  Created by llj on 2017/6/20.
//  Copyright © 2017年 llj. All rights reserved.
//

import UIKit
import YogaKit
import StoreKit

class KBOpenAppStoreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "打开App Store"
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func setupUI() {
        let containerSize = self.view.bounds.size
        
        let root = self.view!
        root.backgroundColor = .white
        root.configureLayout { (layout) in
            layout.isEnabled = true
            
            layout.width = YGValue(containerSize.width)
            layout.height = YGValue(containerSize.height)
            layout.justifyContent = .flexStart
            layout.alignItems = .center
        }
        
        let button1 = UIButton(type: .system)
        button1.setTitle("利用UIApplication", for: .normal)
        button1.addTarget(self, action: Selector.openStoreByApplication, for: .touchUpInside)
        button1.configureLayout { (layout) in
            layout.isEnabled = true
            layout.height = 40
            
            layout.marginTop = 64
        }
        root.addSubview(button1)
        
        let button2 = UIButton(type: .system)
        button2.setTitle("利用SKStoreProductViewController", for: .normal)
        button2.addTarget(self, action: Selector.openStoreByStoreKit, for: .touchUpInside)
        button2.configureLayout { (layout) in
            layout.isEnabled = true
            layout.height = 40
        }
        root.addSubview(button2)
        
        root.yoga.applyLayout(preservingOrigin: true)
    }
    
}

extension KBOpenAppStoreViewController {
    @objc fileprivate func openAppStoreByUIApplication() {
        let link = "https://itunes.apple.com/cn/app/ke-de-yan-jing/id1015323862?mt=8"
        if let url = URL(string: link), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url,
                                      options: [:],
                                      completionHandler: { (result) in
                                        print(result ? "打开成功" : "打开失败");
            })
        }
    }
}

extension KBOpenAppStoreViewController: SKStoreProductViewControllerDelegate {
   @objc fileprivate func openAppStoreByStoreKit() {
        let storeProductViewController = SKStoreProductViewController()
        storeProductViewController.delegate = self
        
        let parametersDict = [SKStoreProductParameterITunesItemIdentifier: 1015323862]
        storeProductViewController.loadProduct(withParameters: parametersDict) { (status: Bool, error: Error?) -> Void in
            if status {
                self.present(storeProductViewController, animated: true, completion: nil)
            }
            else {
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}

private extension Selector {
    static let openStoreByApplication = #selector(KBOpenAppStoreViewController.openAppStoreByUIApplication)
    static let openStoreByStoreKit = #selector(KBOpenAppStoreViewController.openAppStoreByStoreKit)
}
