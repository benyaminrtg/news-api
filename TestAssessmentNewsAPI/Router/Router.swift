//
//  Router.swift
//  TestAssessmentNewsAPI
//
//  Created by Benyamin Rondang Tuahta on 14/06/22.
//

import Foundation
import UIKit
import WebKit

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entry: EntryPoint? { get }
    static func start() -> AnyRouter
    func pushToNewsSource(on view: AnyView, with article: ArticleModel)
    func pushToWebView(on view: AnyView, with url: String)
}

class UserRouter: AnyRouter {
    var entry: EntryPoint?

    static func start() -> AnyRouter {
        let router = UserRouter()
        
        var view: AnyView = HomeViewController()
        var presenter: AnyPresenter = UserPresenter()
        var interactor: AnyInteractor = UserInteractor()

        view.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        router.entry = view as? EntryPoint

        return router
    }

    static func createModule() -> UINavigationController {
        let viewController = HomeViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let presenter: AnyPresenter = UserPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = UserRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = UserInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return navigationController
    }
    
    // MARK: - Navigation
    func pushToNewsSource(on view: AnyView, with article: ArticleModel) {
        let newsSourceVC = NewsSourceRouter.createModule(with: article)
            
        let viewController = view as! HomeViewController
        viewController.navigationController?
            .pushViewController(newsSourceVC, animated: true)
    }

    func pushToWebView(on view: AnyView, with url: String) {
        let webVC = WebViewRouter.createModule(url: url)
            
        let viewController = view as! HomeViewController
        
        webVC.modalPresentationStyle = .fullScreen
        viewController.present(webVC, animated: true)
        
    }
    
}
