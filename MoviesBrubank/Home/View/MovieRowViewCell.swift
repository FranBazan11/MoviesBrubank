//
//  MovieRowViewCell.swift
//  MoviesBrubank
//
//  Created by Juan Bazan Carrizo on 30/03/2023.
//

import Foundation
import UIKit

class MovieRowViewCell: UITableViewCell {
    
    // MARK: - PRIVATE PROPERTIES
    
    private lazy var bannerImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.layer.cornerRadius = 3
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var movieMainTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .left
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var containerGenreLabel: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.Movies.dark_blue_grey
        view.layer.opacity = 0.67
        view.layer.cornerRadius = 3
        return view
    }()
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - INITS

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setupConstraints()
    }
    
    // MARK: - PRIVATE FUNCS
    
    private func setup() {
        contentView.backgroundColor = UIColor.Movies.black_02
        contentView.addSubview(bannerImageView)
        contentView.addSubview(movieMainTitle)
        contentView.addSubview(containerGenreLabel)
        containerGenreLabel.addSubview(genreLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bannerImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            bannerImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            bannerImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            bannerImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            bannerImageView.heightAnchor.constraint(equalToConstant: 176),
            
            movieMainTitle.bottomAnchor.constraint(equalTo: bannerImageView.bottomAnchor, constant: -15),
            movieMainTitle.leadingAnchor.constraint(equalTo: bannerImageView.leadingAnchor, constant: 15),
            movieMainTitle.trailingAnchor.constraint(equalTo: bannerImageView.trailingAnchor, constant: -15),
            
            containerGenreLabel.topAnchor.constraint(equalTo: bannerImageView.topAnchor, constant: 8),
            containerGenreLabel.trailingAnchor.constraint(equalTo: bannerImageView.trailingAnchor, constant: -6),
            
            genreLabel.topAnchor.constraint(equalTo: containerGenreLabel.topAnchor, constant: 4),
            genreLabel.leadingAnchor.constraint(equalTo: containerGenreLabel.leadingAnchor, constant: 15),
            genreLabel.bottomAnchor.constraint(equalTo: containerGenreLabel.bottomAnchor, constant: -4),
            genreLabel.trailingAnchor.constraint(equalTo: containerGenreLabel.trailingAnchor, constant: -15),
            
        ])
    }
    
    // MARK: INTERNAL FUNCS
    func update(model: Movie, image: UIImage, genre: String) {
        movieMainTitle.text = model.title
        bannerImageView.image = image
        genreLabel.text = genre.uppercased()
    }
    
    override func prepareForReuse() {
        bannerImageView.image = nil
    }
}
