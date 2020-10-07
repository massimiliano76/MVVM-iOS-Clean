//
//  ViewModelAssembly.swift
//  MVVM-Clean
//
//  Created by Alessandro Marcon on 04/08/2020.
//  Copyright © 2020 Alessandro Marcon. All rights reserved.
//

import Foundation
import Swinject

class ViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(SplashScreenViewModelDelegate.self) { resolver in
            let splashViewModel = SplashScreenViewModel()
            guard let sessionRepository = resolver.resolve(SessionRepositoryDelegate.self) else {
                fatalError("Assembler was unable to resolve SessionRepositoryDelegate")
            }
            splashViewModel.sessionRepository = sessionRepository
            return splashViewModel
        }.inObjectScope(.transient)
        
        // Login View Model
        container.register(LoginViewModelDelegate.self) { resolver in
            let loginViewModel = LoginViewModel()
            
            guard let sessionRepository = resolver.resolve(SessionRepositoryDelegate.self) else {
                fatalError("Assembler was unable to resolve SessionRepositoryDelegate")
            }
            loginViewModel.sessionRepository = sessionRepository
            
            guard let loginUseCase = resolver.resolve(LoginUseCaseDelegate.self) else {
                fatalError("Assembler was unable to resolve LoginUseCaseDelegate")
            }
            loginViewModel.loginUseCase = loginUseCase
            
            return loginViewModel
        }.inObjectScope(.transient)
        
        
        container.register(SummaryCovidViewModelDelegate.self) { resolver in
            let mainViewModel = SummaryCovidViewModel()
            
            guard let summaryUseCase = resolver.resolve(SummaryUseCaseDelegate.self) else {
                fatalError("Assembler was unable to resolve SummaryUseCaseDelegate")
            }
            mainViewModel.summaryUseCase = summaryUseCase
            mainViewModel.summaryUseCase?.responseDelegate = mainViewModel
            
            return mainViewModel
        }.inObjectScope(.transient)
        
        container.register(CountryCovidViewModelDelegate.self) { resolver in
            let countryViewModel = CountryCovidViewModel()
            
            guard let countryUseCase = resolver.resolve(CountryUseCaseDelegate.self) else {
                fatalError("Assembler was unable to resolve CountryUseCaseDelegate")
            }
            countryViewModel.countryUseCase = countryUseCase
            countryViewModel.countryUseCase?.responseDelegate = countryViewModel
            
            return countryViewModel
        }.inObjectScope(.transient)
        
    }
}