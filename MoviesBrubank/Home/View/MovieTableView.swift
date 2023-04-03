//
//  MovieTableView.swift
//  MoviesBrubank
//
//  Created by Juan Bazan Carrizo on 24/03/2023.
//

import UIKit

protocol MovieTableViewDelegate: AnyObject {
    func didTap(item: Movie)
}

class MovieTableView: UIView {
    
    enum MovieSection {
        case main
    }

    typealias DataSource = UITableViewDiffableDataSource<MovieSection, MovieModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<MovieSection, MovieModel>
    
    // MARK: - PRIVATE PROPERTIES
    
    private var dataSource: DataSource?
    
    private lazy var movieTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(MovieRowViewCell.self, forCellReuseIdentifier: MovieRowViewCell.identifier())
        tableView.backgroundColor = UIColor.Movies.black_02
        tableView.separatorStyle = .none
        tableView.separatorInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 176
        return tableView
    }()
    
    // MARK: - INTERNAL PROPERTIES
    
    weak var delegate: MovieTableViewDelegate?
    
    // MARK: - INITS
    
    init() {
        super.init(frame: .zero)
        setup()
        makeDataSource()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PRIVATE FUNCS
    
    private func setup() {
        movieTableView.delegate = self
        addSubview(movieTableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            movieTableView.topAnchor.constraint(equalTo: self.topAnchor),
            movieTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            movieTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            movieTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    private func snapshot(items: [MovieModel]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items, toSection: .main)
        snapshot.reloadItems(items)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    private func makeDataSource() {
        dataSource = DataSource(tableView: movieTableView, cellProvider: { tableView, indexPath, model in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieRowViewCell.identifier(), for: indexPath) as? MovieRowViewCell else { return UITableViewCell() }
            cell.update(model: model.movie, image: model.image, genre: model.genre)
            return cell
        })
    }
    
    // MARK: -  INTERNAL FUNCS
    func update(items: [MovieModel]) {
        snapshot(items: items)
    }
}

// MARK: - UITableViewDelegate
extension MovieTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let itemModel = dataSource?.itemIdentifier(for: indexPath) else { return }
        delegate?.didTap(item: itemModel.movie)
    }
}
