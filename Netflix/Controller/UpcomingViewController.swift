//
//  UpcomingViewController.swift
//  Netflix
//
//  Created by Rohit Sharma on 05/12/22.
//

import UIKit

class UpcomingViewController: UIViewController {
    
    private var titles = [Title]()
    
    
    private var upcomingTableView : UITableView = {
       let upcomingTableView = UITableView()
        upcomingTableView.register(TitleTableViewCell.self , forCellReuseIdentifier: TitleTableViewCell.identifier)
        return upcomingTableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        title = "UpComing"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        upcomingTableView.dataSource = self
        upcomingTableView.delegate = self
        view.addSubview(upcomingTableView)
        
        fetchUpcomingMovies()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingTableView.frame = view.bounds
    }
    
    func fetchUpcomingMovies(){
        APICaller.shared.getUpcomingMovies { result in
            
            switch result {
            case .success(let titles) :
                self.titles = titles
                DispatchQueue.main.async {
                    self.upcomingTableView.reloadData()
                }
            
            case .failure(let errors) :
                print(errors.localizedDescription)
            
            }
            
        }
    }
}

extension UpcomingViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else
        {return UITableViewCell()}
        cell.configure(with: TitleViewModel(movie: titles[indexPath.row].title ?? titles[indexPath.row].original_title ?? "Unknown", poster: titles[indexPath.row].poster_path ?? "Unknown"))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return  150
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
