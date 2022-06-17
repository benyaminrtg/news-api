//
//  NewsSourcePresenter.swift
//  TestAssessmentNewsAPI
//
//  Created by Benyamin Rondang Tuahta on 15/06/22.
//

import Foundation

class NewsSourcePresenter: ViewToPresenterNewsSourceProtocol {

    // MARK: Properties
    weak var view: PresenterToViewNewsSourceProtocol?
    var interactor: PresenterToInteractorNewsSourceProtocol?
    var router: PresenterToRouterNewsSourceProtocol?

    var newsCategory: NewsCategory = NewsCategory()
    var article: ArticleModel!
    
    func viewDidLoad() {
        interactor?.getNewsArticle(with: "", source: "")
    }

//    func

    func didSelectSource(source: SourceDetail) {
        self.router?.pushToNewsArticle(on: self.view!, with: source, article: self.article)
    }
    
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
extension NewsSourcePresenter: InteractorToPresenterNewsSourceProtocol {
    func fetchSourcesSuccess(sources: SourceDetailModel) {
        view?.onFetchSourcesSuccess(sources: sources)
    }
    
    func fetchSourcesFailure(errorCode: String) {
        view?.onFetchSourcesFailure(error: errorCode)
    }
    
    
}
