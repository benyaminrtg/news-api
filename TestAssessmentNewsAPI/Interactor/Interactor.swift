//
//  Interactor.swift
//  TestAssessmentNewsAPI
//
//  Created by Benyamin Rondang Tuahta on 14/06/22.
//

import Foundation

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }

    func getNewsCategory()
    func getNewsSource(with category: String)
    func getSearchedNews(text: String)
}

class UserInteractor: AnyInteractor {
    var presenter: AnyPresenter?

    func getNewsCategory() {
        self.presenter?.didGetNewsCategory()
    }

    func getNewsSource(with category: String) {
        let country: String = "us"
        let parameters: String = "?category=\(category)&country=\(country)"
        let urlTopHeadlines: String = "https://newsapi.org/v2/top-headlines\(parameters)"
        
        guard let url = URL(string: urlTopHeadlines) else { return }
        var request = URLRequest(url: url)
        request.setValue("b04cf70ed12049f5a234188dbd87edc7", forHTTPHeaderField: "X-Api-Key")
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _ , error in
            guard let data = data, error == nil else { return }
            
            do {
                let entities = try JSONDecoder().decode(ArticleModel.self, from: data)
                self?.presenter?.interactorDidFetchNews(with: entities)
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }

    func getSearchedNews(text: String) {
        let language: String = "en"
        let parameters: String = "?q=\(text)&language=\(language)"
        let urlTopHeadlines: String = "https://newsapi.org/v2/everything\(parameters)"
        
        guard let url = URL(string: urlTopHeadlines) else { return }
        var request = URLRequest(url: url)
        request.setValue("b04cf70ed12049f5a234188dbd87edc7", forHTTPHeaderField: "X-Api-Key")

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _ , error in
            guard let data = data, error == nil else { return }
            
            do {
                let entities = try JSONDecoder().decode(ArticleModel.self, from: data)
                self?.presenter?.interactorDidFetchSearchedNews(with: entities)
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
}
