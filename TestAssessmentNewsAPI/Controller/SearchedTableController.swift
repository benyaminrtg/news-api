//
//  SearchedTableController.swift
//  TestAssessmentNewsAPI
//
//  Created by Benyamin Rondang Tuahta on 17/06/22.
//

import UIKit

protocol SearchedTableControllerDelegate: AnyObject {
    func searchedTableController(
        _ searchedTableController: SearchedTableController,
        url: String
    )
}

class SearchedTableController: UITableViewController {

    var items: ArticleModel? {
        didSet {
            tableView.reloadData()
        }
    }
    weak var searchedTableControllerDelegate: SearchedTableControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.articles.count ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = items?.articles[indexPath.row].title

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchedTableControllerDelegate?
            .searchedTableController(
                self,
                url: items?.articles[indexPath.row].url ?? ""
            )
    }


}
