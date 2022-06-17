//
//  Presenter.swift
//  TestAssessmentNewsAPI
//
//  Created by Benyamin Rondang Tuahta on 14/06/22.
//

import Foundation

protocol AnyPresenter {
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set }
    var view: AnyView? { get set }

    func interactorDidFetchNews(with article: ArticleModel)
    func interactorDidFetchSearchedNews(with article: ArticleModel)
    func didGetNewsCategory()

    func didSelectCategory(category: String)
    func getSearchedNews(text: String)
    func showWebView(url: String)
}

class UserPresenter: AnyPresenter {
    
    func didSelectCategory(category: String) {
        interactor?.getNewsSource(with: category)
    }
    
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getNewsCategory()
        }
    }
    
    var view: AnyView?

    func interactorDidFetchNews(with article: ArticleModel) {
        DispatchQueue.main.async {
            self.router?.pushToNewsSource(on: self.view!, with: article)
        }
    }

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
