//
//  WebViewRouter.swift
//  TestAssessmentNewsAPI
//
//  Created by Benyamin Rondang Tuahta on 17/06/22.
//

import Foundation
import UIKit

class WebViewRouter: PresenterToRouterWebProtocol {
    
    // MARK: - Static methods
    static func createModule(url: String) -> UIViewController {
        let viewController = WebViewController()
        
        let presenter: ViewToPresenterWebProtocol = WebViewPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = WebViewRouter()
        viewController.presenter?.view = viewController

        viewController.presenter?.url = url
        
        return viewController
    }
}
