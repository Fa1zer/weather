//
//  OnboardingViewModel.swift
//  Weather
//
//  Created by Artemiy Zuzin on 01.02.2022.
//

import Foundation

final class OnboardingViewModel: Coordinatable {
    
    private let model = OnboardingModel()
    
    var appCoordinator: AppCoordinator?
    var callBack: (() -> Void)?
    
    func getLocation() {
        
        self.model.locationRequest()
        self.pushMainMenu()
    }
    
    func pushMainMenu() {
        self.appCoordinator?.gotToMainMenu()
    }

}
