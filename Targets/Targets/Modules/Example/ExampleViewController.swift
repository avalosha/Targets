//
//  ExampleViewController.swift
//  Targets
//
//  Created by Sferea-Lider on 05/10/23.
//

import UIKit
import SwiftUI

class ExampleViewController: UIViewController {
    
    @IBOutlet var sideMenuBtn: UIBarButtonItem!
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var showBtn: UIButton!
    
    private var posOriginX: CGFloat = 0
    private var posOriginY: CGFloat = 0
    private var widthView: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
        
        blackView.isHidden = true
        posOriginX = showBtn.frame.minX
        posOriginY = showBtn.frame.minY
        widthView = view.frame.width
        print("FRAME BTN: ",showBtn.frame)
    }
    
    private func showAnimation() {
        blackView.isHidden = false
        
        blackView.frame = CGRect(x: 0, y: 0, width: Int(widthView), height: 280)
        blackView.transform = CGAffineTransform(scaleX: 1, y: 1)
        print("FRAME: ",self.blackView.frame)
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.fromValue = [posOriginX, posOriginY]
        animation.toValue = [widthView/2,280/2]
        
        let scale: CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        scale.toValue = 1
        scale.fromValue = 0
        
        let group = CAAnimationGroup()
        group.animations = [animation, scale]
        group.duration = 0.4
        group.repeatDuration = .zero
        
        blackView.layer.add(group, forKey: nil)
    }
    
    private func hideAnimation() {
        blackView.frame = CGRect(x: posOriginX, y: posOriginY, width: 0, height: 0)
        blackView.transform = CGAffineTransform(scaleX: 0, y: 0)
        print("FRAME: ",self.blackView.frame)
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.fromValue = [widthView/2,280/2]
        animation.toValue = [posOriginX, posOriginY]
        
        let scale: CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
        scale.toValue = 0
        scale.fromValue = 1
        
        let group = CAAnimationGroup()
        group.animations = [animation, scale]
        group.duration = 0.4
        group.repeatDuration = .zero
        group.delegate = self
        
        blackView.layer.add(group, forKey: nil)
    }

    @IBAction func onClickShowBtn(_ sender: Any) {
        showAnimation()
//        blackView.isHidden = false
//        let width = self.blackView.frame.width
//        blackView.frame = CGRect(x: 0, y: 0, width: Int(width), height: 280)
//        print("FRAME: ",self.blackView.frame)
//        
//        let animation = CABasicAnimation(keyPath: "position")
//        animation.fromValue = [-width/2,-280/2]
//        animation.toValue = [width/2,280/2]
//        animation.duration = 1.0
//        animation.repeatDuration = .zero
//        animation.timingFunction = CAMediaTimingFunction(name: .easeIn)
//        blackView.layer.add(animation, forKey: nil)
    }
    
    @IBAction func onClickHideBtn(_ sender: Any) {
        hideAnimation()
//        let width = self.blackView.frame.width
//        blackView.frame = CGRect(x: Int(-width), y: -280, width: Int(width), height: 280)
//        print("FRAME: ",self.blackView.frame)
//        
//        let animation = CABasicAnimation(keyPath: "position")
//        animation.fromValue = [width/2,280/2]
//        animation.toValue = [-width/2,-280/2]
//        animation.duration = 1.0
//        animation.repeatDuration = .zero
//        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
//        blackView.layer.add(animation, forKey: nil)
    }
    
//    @IBAction func onClickOpenSwiftUIBtn(_ sender: Any) {
//        let swiftUIViewController = UIHostingController(rootView: Charts(navigationController: self.navigationController))
//        self.navigationController?.pushViewController(swiftUIViewController, animated: true)
//    }
    
    @IBAction func onClickOpenSwiftUIBtn(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            let swiftUIViewController = UIHostingController(rootView: Charts(navigationController: self.navigationController))
            self.navigationController?.pushViewController(swiftUIViewController, animated: true)
        case 1:
            let swiftUIViewController = UIHostingController(rootView: BarChart(navigationController: self.navigationController))
            self.navigationController?.pushViewController(swiftUIViewController, animated: true)
        case 2:
            let swiftUIViewController = UIHostingController(rootView: PieChart(navigationController: self.navigationController))
            self.navigationController?.pushViewController(swiftUIViewController, animated: true)
        case 3:
            let swiftUIViewController = UIHostingController(rootView: LineChart(navigationController: self.navigationController))
            self.navigationController?.pushViewController(swiftUIViewController, animated: true)
        default:
            return
        }
    }
}

extension ExampleViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("Anim: ",anim," Finished: ",flag)
        if flag {
            blackView.isHidden = true
        }
    }
}
