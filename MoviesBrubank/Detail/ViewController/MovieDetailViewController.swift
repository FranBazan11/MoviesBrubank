//
//  MovieDetailViewController.swift
//  MoviesBrubank
//
//  Created by Juan Bazan Carrizo on 01/04/2023.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    // MARK: - PRIVATE PROPERTIES
    
    private lazy var movieDetailView: MovieDetailView = {
        let view = MovieDetailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let loaderImage = DownloadAsyncImageLoader()
    let item: Movie

    // MARK: - LIFECYRCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Movies.black_02
        setup()
        setupConstraints()
        
        spinner.startAnimating()
        movieDetailView.update(item: item)
        fetchImage()
        
    }
    
    init(item: Movie) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE FUNCS
    
    private func fetchImage() {
        Task {
            do {
                let image = try await loaderImage.fetchImage(with: item.posterPath)
                movieDetailView.update(image: image)
                self.view.backgroundColor = image.averageColor
                spinner.stopAnimating()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func setup() {
        view.addSubview(movieDetailView)
        view.addSubview(spinner)
    }
    
    private func setupConstraints() {
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            movieDetailView.topAnchor.constraint(equalTo: margins.topAnchor),
            movieDetailView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            movieDetailView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            movieDetailView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
        ])
    }
}
