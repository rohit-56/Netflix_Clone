//
//  DownloadsViewController.swift
//  Netflix
//
//  Created by Rohit Sharma on 05/12/22.
//

import UIKit
import SwipeCellKit

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
        
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    
}

extension DownloadsViewController : SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { [self] action, indexPath in
            // handle action by updating model with deletion
            DataPersistenceManager.shared.deleteDownloadTitleMovie(titles[indexPath.row]){ [self] results in
                switch results{
                case .success():
                    titles.remove(at: indexPath.row)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
            }
        }

        // customize the action appearance
        deleteAction.image = UIImage(systemName: "trash")

        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
}
