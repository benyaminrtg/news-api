//
//  NewsSourceContract.swift
//  TestAssessmentNewsAPI
//
//  Created by Benyamin Rondang Tuahta on 15/06/22.
//

import Foundation
import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewNewsSourceProtocol: AnyObject {
    func onFetchSourcesSuccess(sources: SourceDetailModel)
    func onFetchSourcesFailure(error: String)

    func showNewsCategory()
    
    func deselectRowAt(row: Int)
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterNewsSourceProtocol: AnyObject {
    
    var view: PresenterToViewNewsSourceProtocol? { get set }
    var interactor: PresenterToInteractorNewsSourceProtocol? { get set }
    var router: PresenterToRouterNewsSourceProtocol? { get set }
    
    var newsCategory: NewsCategory { get set }
    var article: ArticleModel! { get set }
    
    func viewDidLoad()
    
    func refresh()

    func didSelectSource(source: SourceDetail)
    
    func numberOfRowsInSection() -> Int
    func textLabelText(indexPath: IndexPath) -> String?
    
    func didSelectRowAt(index: Int)
    func deselectRowAt(index: Int)

}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorNewsSourceProtocol: AnyObject {
    
    var presenter: InteractorToPresenterNewsSourceProtocol? { get set }
    func getNewsArticle(with category: String, source: String)
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterNewsSourceProtocol: AnyObject {

    func fetchSourcesSuccess(sources: SourceDetailModel)
    func fetchSourcesFailure(errorCode: String)
    
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterNewsSourceProtocol: AnyObject {
    
    static func createModule(with article: ArticleModel) -> UIViewController
    
    func pushToNewsArticle(on view: PresenterToViewNewsSourceProtocol, with source: SourceDetail, article: ArticleModel)
}
