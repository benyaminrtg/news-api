//
//  NewsArticlesInteractor.swift
//  TestAssessmentNewsAPI
//
//  Created by Benyamin Rondang Tuahta on 16/06/22.
//

import Foundation

class NewsArticlesInteractor: PresenterToInteractorNewsArticleProtocol {
    
    // MARK: - Properties
    weak var presenter: InteractorToPresenterNewsArticleProtocol?
    
    func getNewsArticle(source: SourceDetail, article: ArticleModel) {
        let articles = article.articles.filter {
            $0.source?.id == source.id
        }
        presenter?.fetchArticlesSuccess(article: articles)
    }

}
