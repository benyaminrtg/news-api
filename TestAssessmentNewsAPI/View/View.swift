//
//  View.swift
//  TestAssessmentNewsAPI
//
//  Created by Benyamin Rondang Tuahta on 14/06/22.
//

import Foundation
import UIKit
import SnapKit

protocol AnyView {
    var presenter: AnyPresenter? { get set }
    
    func update(with article: ArticleModel)
    func update(with error: String)
    func update(with newsCategory: NewsCategory)
    func didFetchSearchedNews(article: ArticleModel)
}

class HomeViewController: UIViewController, AnyView {
    
    //MARK: - Properties
    var presenter: AnyPresenter?
    var articles: ArticleModel?
    var newsCategory = NewsCategory()
    var searchTimer: Timer?

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    private let searchedTableController: SearchedTableController = {
        let controller = SearchedTableController()
        return controller
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search News"
        searchBar.searchTextField.borderStyle = .roundedRect
        searchBar.layer.borderColor = UIColor.systemGray.cgColor
        return searchBar
    }()

    //MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        self.navigationItem.title = "News Categories"
        view.addSubview(label)

        layoutTheView()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        searchedTableController.searchedTableControllerDelegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        label.center = view.center
    }

    func layoutTheView() {
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(90)
            make.left.right.equalToSuperview()
        }
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(searchBar).offset(60)
        }
        view.addSubview(searchedTableController.tableView)
        searchedTableController.tableView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(searchBar).offset(60)
        }
        self.searchedTableController.tableView.isHidden = true
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

    func update(with newsCategory: NewsCategory) {
        self.tableView.reloadData()
        self.tableView.isHidden = false
    }

    func didFetchSearchedNews(article: ArticleModel) {
        DispatchQueue.main.async {
            self.searchedTableController.items = article
            self.tableView.isHidden = true
            self.searchedTableController.tableView.isHidden = false
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = NewsCategory().categories[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsCategory().categories.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter?.didSelectCategory(category: newsCategory.categories[indexPath.row])
    }
    
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.count >= 3 else { return }
        searchTimer?.invalidate()
        searchTimer =  Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            self.searchNews(with: searchText)
        })
    }

    func searchNews(with text: String) {
        self.presenter?.getSearchedNews(text: text)
    }
}

extension HomeViewController: SearchedTableControllerDelegate {
    func searchedTableController(
        _ searchedTableController: SearchedTableController,
        url: String
    ) {
        presenter?.showWebView(url: url)
    }
}
