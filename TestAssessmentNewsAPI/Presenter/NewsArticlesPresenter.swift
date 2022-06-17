//
//  NewsArticlesPresenter.swift
//  TestAssessmentNewsAPI
//
//  Created by Benyamin Rondang Tuahta on 16/06/22.
//

import Foundation

class NewsArticlesPresenter: ViewToPresenterNewsArticleProtocol {

    // MARK: Properties
    weak var view: PresenterToViewNewsArticleProtocol?
    var interactor: PresenterToInteractorNewsArticleProtocol?
    var router: PresenterToRouterNewsArticleProtocol?

    var newsCategory: NewsCategory = NewsCategory()
    var newsSource: SourceDetail!
    var article: ArticleModel!
    var relatedArticle: [Article]!
    
    func viewDidLoad() {
        interactor?.getNewsArticle(source: newsSource, article: article)
    }

    func showWebView(url: String) {
        router?.pushToWebView(on: self.view!, with: url)
    }

//    func
    
    func refresh() {
        //
    }
    
    func numberOfRowsInSection() -> Int {
        return 1
    }
    
    func textLabelText(indexPath: IndexPath) -> String? {
        return ""
    }
    
    func didSelectRowAt(index: Int) {
        //
    }
    
    func deselectRowAt(index: Int) {
        //
    }
    
    
    
}

// MARK: - Outputs to view
extension NewsArticlesPresenter: InteractorToPresenterNewsArticleProtocol {
    func fetchSourcesSuccess(sources: SourceDetailModel) {
        view?.onFetchSourcesSuccess(sources: sources)
    }
    
    func fetchSourcesFailure(errorCode: String) {
        view?.onFetchSourcesFailure(error: errorCode)
    }

    func fetchArticlesSuccess(article: [Article]) {
        relatedArticle = article
        view?.onFetchArticleSuccess(articles: article)
    }
    
    
}
