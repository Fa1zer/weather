//
//  CustomCoordinator.swift
//  Weather
//
//  Created by Artemiy Zuzin on 01.02.2022.
//

import Foundation
import UIKit

final class AppCoordinator {
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    private let navigationController: UINavigationController
    
    func start() {
        self.goToOnboardingPage()
    }
    
    func goToOnboardingPage() {
        let viewModel = OnboardingViewModel()
        let viewController = OnboardingViewController(viewModel: viewModel)
        
        viewModel.appCoordinator = self
        
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToHomepage() {
        let viewModel = HomepageViewModel()
        let viewController = HomepageViewController(viewModel: viewModel)
        
        viewModel.appCoordinator = self
        
        self.navigationController.setNavigationBarHidden(false, animated: true)
        self.navigationController.pushViewController(viewController, animated: true)
        
    }
    
    func goToTwentyFourHours() {
        print(#function)
    }
    
    func goToOneHourInformation() {
        print(#function)
    }
    
}
