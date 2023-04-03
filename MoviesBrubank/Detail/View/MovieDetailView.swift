//
//  MovieDetailView.swift
//  MoviesBrubank
//
//  Created by Juan Bazan Carrizo on 01/04/2023.
//

import UIKit

class MovieDetailView: UIView {

    // MARK: - PRIVATE PROPERTIES
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleToFill
        imageView.alpha = 0.1
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        scrollView.alwaysBounceHorizontal = false
        return scrollView
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 37, bottom: 0, right: 37)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 23
        return stackView
    }()
    
    private lazy var mainImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var movieNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subscribeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Susbcribe", for: .normal)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 45/2
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var overviewTextLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.setLineSpacing(lineSpacing: -0.34, lineHeightMultiple: 24)
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - INITS
    
    init() {
        super.init(frame: .zero)
        setup()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup() {
        addSubview(backgroundImageView)
        addSubview(scrollView)
        scrollView.addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(mainImageView)
        containerStackView.addArrangedSubview(movieNameLabel)
        containerStackView.addArrangedSubview(subscribeButton)
        containerStackView.addArrangedSubview(overviewTextLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            containerStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            mainImageView.heightAnchor.constraint(equalToConstant: 273),
            mainImageView.widthAnchor.constraint(equalToConstant: 182),
            
            
            subscribeButton.heightAnchor.constraint(equalToConstant: 45),
            subscribeButton.widthAnchor.constraint(equalToConstant: 195),
        ])
    }
    
    // MARK: -  INTERNAL FUNCS
    func update(item: Movie) {
        movieNameLabel.text = item.title
        overviewTextLabel.text = item.overview
    }
    
    func update(image: UIImage) {
        backgroundImageView.image = image
        mainImageView.image = image
    }

}





