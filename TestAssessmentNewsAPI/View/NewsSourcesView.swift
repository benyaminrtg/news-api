//
//  NewsSourcesView.swift
//  TestAssessmentNewsAPI
//
//  Created by Benyamin Rondang Tuahta on 15/06/22.
//

import Foundation
import UIKit

class NewsSourcesVC: UIViewController {
    var presenter: ViewToPresenterNewsSourceProtocol?
    var articles: ArticleModel?
    var sources: SourceDetailModel?
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "sourcesCell")
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
        self.navigationItem.title = "News Sources"
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

    func update(with articles: ArticleModel) {
        DispatchQueue.main.async {
            self.articles = articles
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }

    func update(with error: String) {
        DispatchQueue.main.async {
            self.articles = nil
            self.label.text = error
            self.tableView.isHidden = true
            self.label.isHidden = false
        }
    }

}

extension NewsSourcesVC: PresenterToViewNewsSourceProtocol {
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
    
    func showNewsCategory() {
        tableView.reloadData()
    }
    
    func deselectRowAt(row: Int) {
        //
    }
    
    
}

extension NewsSourcesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sourcesCell", for: indexPath)
        cell.textLabel?.text = sources?.sources[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sources?.sources.count ?? 0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let sources = sources else { return }
        self.presenter?.didSelectSource(source: sources.sources[indexPath.row])
    }
}
