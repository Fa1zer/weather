//
//  OnboardingViewModel.swift
//  Weather
//
//  Created by Artemiy Zuzin on 01.02.2022.
//

import Foundation

final class OnboardingViewModel: Coordinatable {
    
    init(dataManager: DataManager) {
        
        self.model.dataManager = dataManager
        
    }
    
    private let model = OnboardingModel()
    
    var appCoordinator: AppCoordinator?
    
    func getLocation() {
                    
        self.model.locationRequest()
        self.model.callBack = self.pushHomepage
        
    }
    
    func pushHomepage() {
        self.appCoordinator?.goToHomepage()
    }

}
