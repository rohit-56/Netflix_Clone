//
//  CollectionViewTableViewCell.swift
//  Netflix
//
//  Created by Rohit Sharma on 05/12/22.
//

import UIKit

protocol CollectionViewTableViewCellDelegate : AnyObject{
    func collectionViewTableViewCellDidTapCell(_ cell : CollectionViewTableViewCell ,_ model : YoutubePreviewViewModel )
}

class CollectionViewTableViewCell: UITableViewCell {
    
    private var titles = [Title]()
    
    weak var delegate : CollectionViewTableViewCellDelegate?

   static let identifier = "CollectionViewTableViewCell"
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        collectionView.backgroundColor = UIColor.black
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    public func configure(with titles : [Title]){
        self.titles = titles
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    func downloadConfig(_ indexPath : IndexPath){
        let title = titles[indexPath.row]
    
    }
}
extension CollectionViewTableViewCell : UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else { return UICollectionViewCell()
        }
        
        guard let model = titles[indexPath.row].poster_path else {return UICollectionViewCell()}
      cell.configure(with: model)
     
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let title = titles[indexPath.row].title else {return}
        
        let movieDetails : Title
        
        movieDetails = titles[indexPath.row]
        
        APICaller.shared.getYoutubeResponseForSearchQuery(with: title + " trailer"){[weak self] results in
            switch results{
                
            case .success(let videoResponse):
                
                guard let strongself = self else {return}
                
                self?.delegate?.collectionViewTableViewCellDidTapCell(strongself, YoutubePreviewViewModel(movieDetails: movieDetails,videoDetails: videoResponse))
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfiguration configuration: UIContextMenuConfiguration, highlightPreviewForItemAt indexPath: IndexPath) -> UITargetedPreview? {
      
            let downloadAction = UIAction(title: "Download", state: .off){ _ in
                print("Inside here")
                self.downloadConfig(indexPath)
            }
            return UITargetedPreview(view: UIView())
            
        
       
    }
}
