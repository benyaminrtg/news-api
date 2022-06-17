//
//  NewsSourceRouter.swift
//  TestAssessmentNewsAPI
//
//  Created by Benyamin Rondang Tuahta on 15/06/22.
//

import Foundation
import UIKit

class NewsSourceRouter: PresenterToRouterNewsSourceProtocol {

    // MARK: - Static methods
    static func createModule(with article: ArticleModel) -> UIViewController {
        let viewController = NewsSourcesVC()
//        let navigationController = UINavigationController(rootViewController: viewController)
        
        let presenter: ViewToPresenterNewsSourceProtocol & InteractorToPresenterNewsSourceProtocol = NewsSourcePresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = NewsSourceRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = NewsSourcesInteractor()
        viewController.presenter?.interactor?.presenter = presenter

        viewController.presenter?.article = article
        
        return viewController
    }
    
    // MARK: - Navigation
    func pushToNewsArticle(on view: PresenterToViewNewsSourceProtocol, with source: SourceDetail, article: ArticleModel) {
        let newsArticleVC = NewsArticlesRouter.createModule(source: source, article: article)
            
        let viewController = view as! NewsSourcesVC
        viewController.navigationController?
            .pushViewController(newsArticleVC, animated: true)
    }
}


