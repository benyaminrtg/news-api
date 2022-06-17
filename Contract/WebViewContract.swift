//
//  WebViewContract.swift
//  TestAssessmentNewsAPI
//
//  Created by Benyamin Rondang Tuahta on 17/06/22.
//

import Foundation

import Foundation
import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewWebProtocol: AnyObject {
    func loadWebView(url: String)
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterWebProtocol: AnyObject {
    
    var view: PresenterToViewWebProtocol? { get set }
    var router: PresenterToRouterWebProtocol? { get set }
    var url: String! { get set }

    func didLoad()

}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterWebProtocol: AnyObject {
    
    static func createModule(url: String) -> UIViewController
}
