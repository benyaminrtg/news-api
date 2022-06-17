//
//  WebViewPresenter.swift
//  TestAssessmentNewsAPI
//
//  Created by Benyamin Rondang Tuahta on 17/06/22.
//

import Foundation

class WebViewPresenter: ViewToPresenterWebProtocol {

    var view: PresenterToViewWebProtocol?
    var router: PresenterToRouterWebProtocol?
    var url: String!
    
    func didLoad() {
        view?.loadWebView(url: url)
    }
}
