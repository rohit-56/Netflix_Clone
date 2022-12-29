//
//  SearchResultsViewController.swift
//  Netflix
//
//  Created by Rohit Sharma on 28/12/22.
//

import UIKit

class SearchResultsViewController: UIViewController {
    
    public var titles = [Title]()
    
    public var showSearchResults : UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        flowLayout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.backgroundColor = .darkGray
        showSearchResults.delegate = self
        showSearchResults.dataSource = self
        
        view.addSubview(showSearchResults)
        fetchDiscoverAPIResponse()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        showSearchResults.frame = view.bounds
    }
    func fetchDiscoverAPIResponse(){
       
    }
}

extension SearchResultsViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {return UICollectionViewCell()}
        cell.configure(with: titles[indexPath.row].poster_path ?? "Unknown")
        return cell
    }
    
    
}
