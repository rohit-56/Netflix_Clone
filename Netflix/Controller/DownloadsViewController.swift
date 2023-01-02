//
//  DownloadsViewController.swift
//  Netflix
//
//  Created by Rohit Sharma on 05/12/22.
//

import UIKit

class DownloadsViewController: UIViewController {
    
    private var titles = [TitleModel]()
    
    private var downloadedMovies : UITableView = {
        let tableView = UITableView()
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        title = "Download"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(downloadedMovies)
        
        downloadedMovies.delegate = self
        downloadedMovies.dataSource = self
        showDownloadedMovies()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        downloadedMovies.frame = view.bounds
    }
    func showDownloadedMovies(){
        DataPersistenceManager.shared.fetchTitleModelList{ [self] results in
            switch results{
            case .success(let titleModel):
                self.titles = titleModel    
                print(titles.count)
                DispatchQueue.main.async {
                    self.downloadedMovies.reloadData()
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
}
extension DownloadsViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {return UITableViewCell()}
        
        cell.configure(with: TitleViewModel(movie: titles[indexPath.row].original_title ?? titles[indexPath.row].title ?? "Unknown", poster: titles[indexPath.row].poster_path ?? "Unknown"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    
}
