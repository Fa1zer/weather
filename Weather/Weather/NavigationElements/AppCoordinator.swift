//
//  CustomCoordinator.swift
//  Weather
//
//  Created by Artemiy Zuzin on 01.02.2022.
//

import UIKit

final class AppCoordinator {
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        self.dataManager.homepageWeatherRequest()
    }
    
    private let navigationController: UINavigationController
    private let userDefaults = UserDefaults()
    private let dataManager = DataManager()
        
    func start() {
        
        DispatchQueue.main.async { [ weak self ] in
            
            if let citys = self?.userDefaults.object(forKey: "citys") as? [String], citys != [] {
                
                self?.goToHomepage()
                
            } else {
                
                self?.goToOnboardingPage()
                
            }
            
        }
        
    }
    
    func goToOnboardingPage() {
        let viewModel = OnboardingViewModel(dataManager: self.dataManager)
        let viewController = OnboardingViewController(viewModel: viewModel)
        
        viewModel.appCoordinator = self
        
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToHomepage() {
        
        let viewModel = HomepageViewModel(dataManager: self.dataManager)
        let viewController = HomepageViewController(viewModel: viewModel)
        
        viewModel.appCoordinator = self
        
        self.navigationController.setNavigationBarHidden(false, animated: true)
        self.navigationController.pushViewController(viewController, animated: true)
        
    }
    
    func goToTwentyFourHours(index: Int) {
        
        let viewModel = TwentyFourHoursWeatherViewModel(dataManager: self.dataManager)
        let viewController = TwentyFourHoursWeatherViewController(viewModel: viewModel, index: index)
        
        viewModel.appCoordinator = self
        
        self.navigationController.setNavigationBarHidden(false, animated: true)
        self.navigationController.pushViewController(viewController, animated: true)
        
    }
    
    func popViewController() {
        self.navigationController.setNavigationBarHidden(false, animated: true)
        self.navigationController.popViewController(animated: true)
    }
    
    func goToTwentyFiveDays(index: Int, dateIndex: Int) {
                
        let viewModel = TwentyFiveDaysViewModel(dataManager: self.dataManager)
        let viewController = TwentyFiveDaysViewController(viewModel: viewModel,
                                                          index: index,
                                                          dateIndex: dateIndex)
        
        viewModel.appCoordinator = self
        
        self.navigationController.setNavigationBarHidden(false, animated: true)
        self.navigationController.pushViewController(viewController, animated: true)
        
    }
    
    func goToSettings() {
        
        let viewModel = SettingsViewModel(dataManager: self.dataManager)
        let viewController = SettingsViewController(viewModel: viewModel)
        
        viewModel.appCoordinator = self
        
        self.navigationController.setNavigationBarHidden(true, animated: true)
        self.navigationController.pushViewController(viewController, animated: true)
        
    }
    
}
