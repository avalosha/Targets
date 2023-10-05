//
//  TabBarController.swift
//  Targets
//
//  Created by Sferea-Lider on 05/10/23.
//

import UIKit

class TabBarController: UITabBarController {
    
    @IBOutlet var sideMenuBtn: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTaps()
        setupTabItems()
        
        sideMenuBtn.target = revealViewController()
        sideMenuBtn.action = #selector(revealViewController()?.revealSideMenu)
    }
    
    private func setupTaps() {
        let storyboard = UIStoryboard(name: "profile", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "ProfileID")
        let profile = self.createNav(title: "Perfil", image: UIImage(systemName: "person"), vc: destinationVC)
        let example = self.createNav(title: "Example", image: UIImage(systemName: "clock"), vc: ExampleViewController())
        
        self.setViewControllers([profile, example], animated: true)
    }
    
    private func setupTabItems() {
        let tabAppearance = UITabBarAppearance()

        tabAppearance.configureWithOpaqueBackground()
        tabAppearance.backgroundImage = UIImage()
        tabAppearance.backgroundColor = UIColor.black

        tabAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
        tabAppearance.stackedLayoutAppearance.selected.iconColor = UIColor.white

        tabAppearance.stackedLayoutAppearance.normal.iconColor = UIColor.gray
        tabAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]

        UITabBar.appearance().standardAppearance = tabAppearance

        if #available(iOS 15, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabAppearance
        }

        setNeedsStatusBarAppearanceUpdate()

        tabBarController?.tabBar.tintColor = .white
        tabBarController?.tabBar.barTintColor = UIColor.black
        tabBarController?.tabBar.isTranslucent = false
    }

    private func createNav(title: String, image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        nav.viewControllers.first?.navigationItem.title = title + " Controller"
        nav.viewControllers.first?.navigationController?.navigationBar.isHidden = true
        
        nav.viewControllers.first?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Button", style: .plain, target: nil, action: nil)
        
        return nav
    }
}
