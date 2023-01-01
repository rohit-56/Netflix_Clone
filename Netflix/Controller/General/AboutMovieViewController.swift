//
//  AboutMovieViewController.swift
//  Netflix
//
//  Created by Rohit Sharma on 29/12/22.
//

import UIKit
import WebKit

class AboutMovieViewController: UIViewController {
    
    private var wkWebView : WKWebView = {
       let wkWebView = WKWebView()
        wkWebView.translatesAutoresizingMaskIntoConstraints = false
        return wkWebView
    }()
    
    private var movieName : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Movie-Name"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    private var overview : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Overview"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    private var downloadButton : UIButton = {
       let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(addMovieDetailsInPersistence), for: .touchUpInside)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        view.addSubview(wkWebView)
        view.addSubview(downloadButton)
        view.addSubview(movieName)
        view.addSubview(overview)
        
        applyConstraints()
        
        
    }
    
    func configure(with model : YoutubePreviewViewModel){
        movieName.text = model.movieDetails.title
        overview.text = model.movieDetails.overview
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.videoDetails.id.videoId)") else {return}
        
        wkWebView.load(URLRequest(url: url))
    }
    
    func applyConstraints(){
        let wkWebViewConstraints = [
            wkWebView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            wkWebView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 4),
            wkWebView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 4),
            wkWebView.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        let movieNameConstraints = [
            movieName.topAnchor.constraint(equalTo: wkWebView.bottomAnchor, constant: 10),
            movieName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 4),
            movieName.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 4),
           
        ]
        
        let overviewConstraints = [
            overview.topAnchor.constraint(equalTo: movieName.bottomAnchor, constant: 10),
            overview.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 4),
            overview.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 4),
           
        ]
        
        let downloadButtonConstraints = [
            downloadButton.topAnchor.constraint(equalTo: overview.bottomAnchor, constant: 10),
            downloadButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 4),
            downloadButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 4),
        ]
        
        NSLayoutConstraint.activate(wkWebViewConstraints)
        NSLayoutConstraint.activate(movieNameConstraints)
        NSLayoutConstraint.activate(overviewConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
    }
    @objc func addMovieDetailsInPersistence(){
        
    }
}
