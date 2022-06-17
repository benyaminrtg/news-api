//
//  NewsSourcesInteractor.swift
//  TestAssessmentNewsAPI
//
//  Created by Benyamin Rondang Tuahta on 15/06/22.
//

import Foundation

class NewsSourcesInteractor: PresenterToInteractorNewsSourceProtocol {
    
    // MARK: Properties
    weak var presenter: InteractorToPresenterNewsSourceProtocol?
    
    func getNewsArticle(with category: String, source: String) {
        print("get news article")
        let language: String = "en"
        let parameters: String = "?category=\(category)&language=\(language)"
        let urlTopHeadlines: String = "https://newsapi.org/v2/top-headlines/sources\(parameters)"
        
        guard let url = URL(string: urlTopHeadlines) else { return }
        var request = URLRequest(url: url)
        request.setValue("b04cf70ed12049f5a234188dbd87edc7", forHTTPHeaderField: "X-Api-Key")

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _ , error in
            guard let data = data, error == nil else {
                self?.presenter?.fetchSourcesFailure(errorCode: error?.localizedDescription ?? "")
                return
            }
            
            do {
                let entities = try JSONDecoder().decode(SourceDetailModel.self, from: data)
                self?.presenter?.fetchSourcesSuccess(sources: entities)
            }
            catch {
                print(error)
                self?.presenter?.fetchSourcesFailure(errorCode: error.localizedDescription)
            }
        }
        task.resume()
    }

}
