//
//  Presenter.swift
//  TestAssessmentNewsAPI
//
//  Created by Benyamin Rondang Tuahta on 14/06/22.
//

import Foundation

enum FetchError: Error {
    case failed
}

protocol AnyPresenter {
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set }
    var view: AnyView? { get set }

    func interactorDidFetchUsers(with result: Result<ArticleModel, Error>)
    func interactorDidFetchNews(with article: ArticleModel)
    func interactorDidFetchSearchedNews(with article: ArticleModel)
    func didGetNewsCategory()

    func didSelectCategory(category: String)
    func deselectRowAt(index: Int)
    func getSearchedNews(text: String)
    func showWebView(url: String)
}

class UserPresenter: AnyPresenter {
    
    func didSelectCategory(category: String) {
        interactor?.getNewsSource(with: category)
    }
    
    func deselectRowAt(index: Int) {
        //
    }
    
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getNewsCategory()
        }
    }
    
    var view: AnyView?
    
    func interactorDidFetchUsers(with result: Result<ArticleModel, Error>) {
        switch result {
        case .success(let articles):
            view?.update(with: articles)
        case .failure:
            view?.update(with: "Something went wrong")
        }
    }

    func interactorDidFetchNews(with article: ArticleModel) {
        DispatchQueue.main.async {
            self.router?.pushToNewsSource(on: self.view!, with: article)
        }
    }

//    func getQuoteSuccess(_ quote: Quote) {
//        router?.pushToQuoteDetail(on: view!, with: quote)
//    }

    func didGetNewsCategory() {
        view?.update(with: NewsCategory())
    }

    func getSearchedNews(text: String) {
        interactor?.getSearchedNews(text: text)
    }

    func interactorDidFetchSearchedNews(with article: ArticleModel) {
        view?.didFetchSearchedNews(article: article)
    }

    func showWebView(url: String) {
        router?.pushToWebView(on: self.view!, with: url)
    }
}
