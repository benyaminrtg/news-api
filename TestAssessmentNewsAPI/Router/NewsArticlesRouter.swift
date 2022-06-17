//
//  NewsArticlesRouter.swift
//  TestAssessmentNewsAPI
//
//  Created by Benyamin Rondang Tuahta on 16/06/22.
//

import Foundation
import UIKit

class NewsArticlesRouter: PresenterToRouterNewsArticleProtocol {

    // MARK: - Static methods
    static func createModule(source: SourceDetail, article: ArticleModel) -> UIViewController {
        let viewController = NewsArticlesView()
        
        let presenter: ViewToPresenterNewsArticleProtocol & InteractorToPresenterNewsArticleProtocol = NewsArticlesPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = NewsArticlesRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = NewsArticlesInteractor()
        viewController.presenter?.interactor?.presenter = presenter

        viewController.presenter?.newsSource = source
        viewController.presenter?.article = article
        
        return viewController
    }

    // MARK: - Navigation

    func pushToWebView(on view: PresenterToViewNewsArticleProtocol, with url: String) {
        let webVC = WebViewRouter.createModule(url: url)
            
        let viewController = view as! NewsArticlesView
        
        webVC.modalPresentationStyle = .fullScreen
        viewController.present(webVC, animated: true)
        
    }
}
