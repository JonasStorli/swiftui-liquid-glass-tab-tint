//
//  TabTint.swift
//  TabLiquidGlassTint
//
//  Created by Jonas Storli on 22/09/2026.
//

import SwiftUI
import UIKit

struct SearchTabColor: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UIViewController {
        SearchTabColorController()
    }
    
    func updateUIViewController(
        _ uiViewController: UIViewController,
        context: Context
    ) {}
}


private final class SearchTabColorController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if #available(iOS 26.0, *) {
            changeSearchTabColor()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if #available(iOS 26.0, *) {
            changeSearchTabColor()
        }
    }
    
    private func changeSearchTabColor() {
        
        guard
            let root = view.window?.rootViewController,
            let tabBar = findTabBarController(in: root)?.tabBar
        else {
            return
        }
        
        let auxiliaryViews = tabBar.subviews.filter {
            String(describing: type(of: $0))
            == "_UITabBarAuxiliaryView"
        }
        
        for auxiliaryView in auxiliaryViews {
            
            auxiliaryView.subviews
                .compactMap { platter in
                    
                    platter.subviews.first {
                        String(describing: type(of: $0))
                        == "ContentView"
                    }
                    
                }
                .forEach { contentView in
                    
                    if let accentColor = UIColor(named: "accent") {
                        
                        contentView.backgroundColor = accentColor
                    }
                    
                    contentView.layer.cornerRadius =
                    contentView.bounds.height / 2
                    
                    contentView.clipsToBounds = true
                }
        }
    }
    
    private func findTabBarController(
        in viewController: UIViewController?
    ) -> UITabBarController? {
        
        guard let viewController else {
            return nil
        }
        
        if let tabBarController =
            viewController as? UITabBarController {
            
            return tabBarController
        }
        
        for child in viewController.children {
            
            if let tabBarController =
                findTabBarController(in: child) {
                
                return tabBarController
            }
        }
        
        return findTabBarController(
            in: viewController.presentedViewController
        )
    }
}
