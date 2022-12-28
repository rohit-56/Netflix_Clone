//
//  TitleTableViewCell.swift
//  Netflix
//
//  Created by Rohit Sharma on 27/12/22.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    
    static let identifier = "TitleTableViewCell"
    
    private var posterImageView : UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var movieName : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var playButton : UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "play.circle"), for: .normal)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(posterImageView)
            contentView.addSubview(movieName)
        contentView.addSubview(playButton)
        
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func applyConstraints(){
       let posterImageViewConstraints = [
        posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
        posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
        posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
        posterImageView.widthAnchor.constraint(equalToConstant: 100)
       ]
        
       let movieNameConstraints = [
        movieName.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 20),
        movieName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
       ]
        
       let playButtonConstraints = [
        playButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        playButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
       ]
        
        NSLayoutConstraint.activate(posterImageViewConstraints)
        NSLayoutConstraint.activate(movieNameConstraints)
        NSLayoutConstraint.activate(playButtonConstraints)
    }
    
    public func configure(with model : TitleViewModel){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.poster)") else {return}
        posterImageView.sd_setImage(with: url)
        movieName.text = model.movie
    }

}
