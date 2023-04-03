//
//  HomeViewController.swift
//  MoviesBrubank
//
//  Created by Juan Bazan Carrizo on 24/03/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - PRIVATE PROPERTIES
    private let viewModel = MovieListViewModel()
    
    private lazy var movieListView: MovieTableView = {
        let view = MovieTableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - LIFECYRCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstraints()
        setupNavBar()
        
        
        spinner.startAnimating()
        Task {
            let movies = try await viewModel.fetchMovies()
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.movieListView.update(items: movies)
            }
            self.spinner.stopAnimating()
        }
    }
    
    // MARK: - PRIVATE PROPERTIES
    
    private func setup() {
        movieListView.delegate = self
        
        view.addSubview(movieListView)
        view.addSubview(spinner)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            movieListView.topAnchor.constraint(equalTo: view.topAnchor),
            movieListView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            movieListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieListView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func setupNavBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = UIColor.Movies.black_02
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.scrollEdgeAppearance = navigationBarAppearance
        navigationItem.standardAppearance = navigationBarAppearance
        navigationItem.compactAppearance = navigationBarAppearance
        
        self.title = "TV Show Reminder"
    }
}

extension HomeViewController: MovieTableViewDelegate {
    func didTap(item: Movie) {
        let vc = MovieDetailViewController(item: item)
        navigationController?.pushViewController(vc, animated: true)
    }
}
