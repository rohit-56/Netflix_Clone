//
//  SearchViewController.swift
//  Netflix
//
//  Created by Rohit Sharma on 05/12/22.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var titles = [Title]()
    
    private var serachTableView : UITableView = {
       let tableView = UITableView()
        tableView.register(TitleTableViewCell.self , forCellReuseIdentifier: TitleTableViewCell.identifier)
        return tableView
    }()
    
    
    private var searchView : UISearchController = {
       let searchView = UISearchController(searchResultsController: SearchResultsViewController())
        searchView.searchBar.tintColor = .label
        searchView.searchBar.placeholder = "Search a Movie or Tv Shows"
        return searchView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        serachTableView.delegate = self
        serachTableView.dataSource = self
        
        title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        navigationItem.searchController = searchView
        
        view.addSubview(serachTableView)
        
       fetchMovies()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        serachTableView.frame = view.bounds
    }
    
    func fetchMovies(){
        APICaller.shared.getUpcomingMovies{ results in
            switch results{
            case .success(let titles):
                self.titles = titles
                DispatchQueue.main.async {
                    self.serachTableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            
        }
    }
    
}

extension SearchViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else { return UITableViewCell()}
        cell.configure(with: TitleViewModel(movie: titles[indexPath.row].original_title ?? titles[indexPath.row].title ?? "Unknown", poster: titles[indexPath.row].poster_path ?? "Unknown"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
}
