//
//  NewsArticlesView.swift
//  TestAssessmentNewsAPI
//
//  Created by Benyamin Rondang Tuahta on 16/06/22.
//

import Foundation
import UIKit
import WebKit

class NewsArticlesView: UIViewController {
    var presenter: ViewToPresenterNewsArticleProtocol?
    var articles: [Article] = []
    var sources: SourceDetailModel?
    var webView: WKWebView!

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "articleCell")
        table.isHidden = true
        return table
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = "News Articles"
        self.navigationController?.navigationBar.backgroundColor = .white
        view.addSubview(label)

        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        label.center = view.center
    }
}

extension NewsArticlesView: PresenterToViewNewsArticleProtocol {
    func onFetchSourcesSuccess(sources: SourceDetailModel) {
        DispatchQueue.main.async {
            self.sources = sources
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func onFetchSourcesFailure(error: String) {
        DispatchQueue.main.async {
            self.sources = nil
            self.label.text = error
            self.tableView.isHidden = true
            self.label.isHidden = false
        }
    }

    func onFetchArticleSuccess(articles: [Article]) {
        self.articles = articles
        self.tableView.reloadData()
        self.tableView.isHidden = false
    }
    
    func showNewsCategory() {
        tableView.reloadData()
    }
}

extension NewsArticlesView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath)
        cell.textLabel?.text = articles[indexPath.row].title
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let newsUrl = articles[indexPath.row].url!

        presenter?.showWebView(url: newsUrl)
    }
}

extension NewsArticlesView: WKNavigationDelegate {
    
}
