//
//  Interactor.swift
//  TestAssessmentNewsAPI
//
//  Created by Benyamin Rondang Tuahta on 14/06/22.
//

import Foundation

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }

    func getUsers()
    func getNewsCategory()
    func getNewsSource(with category: String)
    func getSearchedNews(text: String)
}

class UserInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func getUsers() {
        print("get users")
        let urlEverything: String = "https://newsapi.org/v2/everything?q=bitcoin"
        let urlTopHeadlines: String = "https://newsapi.org/v2/top-headlines"
        guard let url = URL(string: urlTopHeadlines) else { return }
        var request = URLRequest(url: url)
        request.setValue("b04cf70ed12049f5a234188dbd87edc7", forHTTPHeaderField: "X-Api-Key")
        request.setValue("us", forHTTPHeaderField: "country")
        request.setValue("business", forHTTPHeaderField: "category")

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _ , error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFetchUsers(with: .failure(FetchError.failed))
                return
            }

            do {
                let entities = try JSONDecoder().decode(ArticleModel.self, from: data)
                self?.presenter?.interactorDidFetchUsers(with: .success(entities))
            }
            catch {
                print(error)
                self?.presenter?.interactorDidFetchUsers(with: .failure(error))
            }
        }
        task.resume()
    }

    func getNewsCategory() {
        self.presenter?.didGetNewsCategory()
    }

    func getNewsSource(with category: String) {
        print("get news source")
        let country: String = "us"
        let parameters: String = "?category=\(category)&country=\(country)"
        let urlTopHeadlines: String = "https://newsapi.org/v2/top-headlines\(parameters)"
        
        guard let url = URL(string: urlTopHeadlines) else { return }
        var request = URLRequest(url: url)
        request.setValue("b04cf70ed12049f5a234188dbd87edc7", forHTTPHeaderField: "X-Api-Key")
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _ , error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFetchUsers(with: .failure(FetchError.failed))
                return
            }
            
            do {
                let entities = try JSONDecoder().decode(ArticleModel.self, from: data)
                self?.presenter?.interactorDidFetchNews(with: entities)
            }
            catch {
                print(error)
                self?.presenter?.interactorDidFetchUsers(with: .failure(error))
            }
        }
        task.resume()
    }

    func getSearchedNews(text: String) {
        print("get searched news")
        let language: String = "en"
        let parameters: String = "?q=\(text)&language=\(language)"
        let urlTopHeadlines: String = "https://newsapi.org/v2/everything\(parameters)"
        
        guard let url = URL(string: urlTopHeadlines) else { return }
        var request = URLRequest(url: url)
        request.setValue("b04cf70ed12049f5a234188dbd87edc7", forHTTPHeaderField: "X-Api-Key")

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _ , error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFetchUsers(with: .failure(FetchError.failed))
                return
            }
            
            do {
                let entities = try JSONDecoder().decode(ArticleModel.self, from: data)
                print("HEYOOOOO=========HEYOOOOO=========HEYOOOOO=========")
                print(entities)
                print("HEYOOOOO=========HEYOOOOO=========HEYOOOOO=========")
                self?.presenter?.interactorDidFetchSearchedNews(with: entities)
            }
            catch {
                print(error)
                self?.presenter?.interactorDidFetchUsers(with: .failure(error))
            }
        }
        task.resume()
    }
}
