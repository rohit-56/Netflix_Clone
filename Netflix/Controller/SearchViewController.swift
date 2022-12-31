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
        
        searchView.searchResultsUpdater = self
        
       fetchMovies()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        serachTableView.frame = view.bounds
    }
    
    func fetchMovies(){
        APICaller.shared.getDiscoverMovies{ results in
            switch results{
            case .success(let titles):
                self.titles = titles
                DispatchQueue.main.async {
                    self.serachTableView.reloadData()
                }
            case .failure(let errors):
                print(errors.localizedDescription)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        APICaller.shared.getYoutubeResponseForSearchQuery(with: titles[indexPath.row].title ?? titles[indexPath.row].original_title ?? "Unknown"){ [self] results in
            switch results{
            case .success(let videoResponse):
                
                guard let title = titles[indexPath.row].title else {return}
                
                guard let overview = titles[indexPath.row].overview else {return}
                DispatchQueue.main.async { [weak self] in
                    
                    let vc = AboutMovieViewController()
                    vc.configure(with: YoutubePreviewViewModel(movieName: title, overview: overview, videoDetails: videoResponse))
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
}

extension SearchViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text ,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3 ,
              let resultsController = searchController.searchResultsController as? SearchResultsViewController else {return}
    
        APICaller.shared.getSearchQueryResults(with : query){ results in
            
            switch results{
            case .success(let titles):
                resultsController.titles = titles
                DispatchQueue.main.async {
                    resultsController.showSearchResults.reloadData()
                }
            case .failure(let errors):
                print(errors.localizedDescription)
            }
            
        }
        
    }
    
    
}
