//
//  WebViewController.swift
//  TestAssessmentNewsAPI
//
//  Created by Benyamin Rondang Tuahta on 17/06/22.
//

import Foundation
import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    var presenter: ViewToPresenterWebProtocol?
    var url: String!
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.didLoad()
    }

    @objc func closeTapped() {
        self.dismiss(animated: true)
    }
    
}

extension WebViewController: PresenterToViewWebProtocol {
    func loadWebView(url: String) {
        webView = WKWebView()
        webView.navigationDelegate = self

        let url = URL(string: url)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true

        let width = self.view.frame.width
        let safeView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 44))
        safeView.backgroundColor = .white
        let navigationBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 44, width: width, height: 44))
        navigationBar.backgroundColor = .white
        let navigationItem = UINavigationItem()
              let doneBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(closeTapped))
              navigationItem.rightBarButtonItem = doneBtn
              navigationBar.setItems([navigationItem], animated: false)
        webView.frame = CGRect(x: 0, y: 88, width: width, height: self.view.frame.height)
        
        view.addSubview(safeView)
        view.addSubview(navigationBar)
        view.addSubview(webView)
        
    }
}
