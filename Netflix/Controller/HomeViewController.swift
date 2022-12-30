//
//  HomeViewController.swift
//  Netflix
//
//  Created by Rohit Sharma on 05/12/22.
//

import UIKit


enum Sections : Int  {
    case TrendingMovies = 0
    case Popular = 1
    case TrendingTvs = 2
    case UpComingMovies = 3
    case TopRated = 4
}

class HomeViewController: UIViewController {

    let sectionsHeader = ["Trending Movies" ,"Popular" ,"Trending Tv", "Upcoming Movies","Top Rated"]
    
    private var tableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return tableView
    }()
    
    var heroHeaderView : HeroHeaderView?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        configureNavigationBar()
       
            heroHeaderView = HeroHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 500))
           
        heroHeaderView?.delegate = self
           setTableViewHeaderMoviesDynamically()
        
        
       
        tableView.tableHeaderView = heroHeaderView

    }
    
 
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    func setTableViewHeaderMoviesDynamically(){
       
          
            APICaller.shared.getTrendingMovies { [self] results in
                switch results{
                case .success(let titles):
                    DispatchQueue.main.async { [self] in
                        let titleUsed = titles.randomElement()
                        heroHeaderView?.configure(with: TitleViewModel(movie: titleUsed?.title ?? titleUsed?.original_title ?? "Unknown", poster: titleUsed?.poster_path ?? "Unknown"))
                    }
                  
                case .failure(let errors):
                    print(errors.localizedDescription)
                }
            }

        
    }
    
    // MARK: Configuring Navigation Bar
    func configureNavigationBar(){
        var image = UIImage(named: "netflixLogo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "house"), style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.backgroundColor = .black
        
    }
  

}

// MARK: - Functionalities of TableView (No. of Rows , Sections , Row-Height)

extension HomeViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionsHeader.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell
                
        else{
            return UITableViewCell()
        }
        
        cell.delegate = self
        
        switch indexPath.section{
        case Sections.TrendingMovies.rawValue:
            APICaller.shared.getTrendingMovies { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                    
                case .failure(let error):
                    print(error)
                }
            }
        case Sections.Popular.rawValue:
            APICaller.shared.getPopular { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                    
                case .failure(let error):
                    print(error)
                }
            }
        case Sections.TrendingTvs.rawValue:
            APICaller.shared.getTrendingTvs { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                    
                case .failure(let error):
                    print(error)
                }
            }
        case Sections.UpComingMovies.rawValue:
            APICaller.shared.getUpcomingMovies { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                    
                case .failure(let error):
                    print(error)
                }
            }
        case Sections.TopRated.rawValue:
            APICaller.shared.getTopRated { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                    
                case .failure(let error):
                    print(error)
                }
            }
        default:
            return UITableViewCell()
        }
         
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionsHeader[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView = view as? UITableViewHeaderFooterView else {return}
        headerView.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        headerView.textLabel?.frame = CGRect(x: headerView.bounds.origin.x + 20 , y: headerView.bounds.origin.y, width: 100, height: headerView.bounds.height)
        headerView.textLabel?.textColor = .white
    }
    
    
}
extension HomeViewController : CollectionViewTableViewCellDelegate {
   
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, _ model: YoutubePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = AboutMovieViewController()
            vc.configure(with: model)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
       
    }
    
    
}

extension HomeViewController : HeroHeaderViewDelegate {
    func actionClickOnPlay(_ button: HeroHeaderView, _ model: YoutubePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = AboutMovieViewController()
            vc.configure(with: model)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

