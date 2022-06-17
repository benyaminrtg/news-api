//
//  NewsArticlesContract.swift
//  TestAssessmentNewsAPI
//
//  Created by Benyamin Rondang Tuahta on 16/06/22.
//

import Foundation
import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewNewsArticleProtocol: AnyObject {
    func onFetchSourcesSuccess(sources: SourceDetailModel)
    func onFetchSourcesFailure(error: String)
    func onFetchArticleSuccess(articles: [Article])

    func showNewsCategory()
    
    func deselectRowAt(row: Int)
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterNewsArticleProtocol: AnyObject {
    
    var view: PresenterToViewNewsArticleProtocol? { get set }
    var interactor: PresenterToInteractorNewsArticleProtocol? { get set }
    var router: PresenterToRouterNewsArticleProtocol? { get set }
    
    var newsCategory: NewsCategory { get set }
    var newsSource: SourceDetail! { get set }
    var article: ArticleModel! { get set }
    var relatedArticle: [Article]! { get set }
    
    func viewDidLoad()
    func showWebView(url: String)
    
    func refresh()
    
    func numberOfRowsInSection() -> Int
    func textLabelText(indexPath: IndexPath) -> String?
    
    func didSelectRowAt(index: Int)
    func deselectRowAt(index: Int)

}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorNewsArticleProtocol: AnyObject {
    
    var presenter: InteractorToPresenterNewsArticleProtocol? { get set }
    func getNewsArticle(source: SourceDetail, article: ArticleModel)
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterNewsArticleProtocol: AnyObject {

    func fetchSourcesSuccess(sources: SourceDetailModel)
    func fetchSourcesFailure(errorCode: String)
    func fetchArticlesSuccess(article: [Article])
    
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterNewsArticleProtocol: AnyObject {
    
    static func createModule(source: SourceDetail, article: ArticleModel) -> UIViewController
    func pushToWebView(on view: PresenterToViewNewsArticleProtocol, with url: String)

}
