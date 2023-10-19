//
//  BooksCollectionCell.swift
//  wesley-inevent-ios-test
//
//  Created by Wesley Calazans on 18/10/23.
//

import UIKit
import StackViewKit
import SDWebImage

class BooksCollectionCell: UICollectionViewCell {
    
    static let identifier = "BooksCollectionCell"
    
    // MARK: - Properties
    
    lazy var bookImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = .label
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label.withAlphaComponent(0.8)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.textColor = .systemGray
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .systemGray
        return label
    }()
    
    lazy var containerVStack: VStackView = {
        let view = VStackView(alignment: .leading,
                              spacing: 4,
                              distribution: .equalCentering,
                              margins: .init(top: 4, left: 4, bottom: 4, right: 4),
                              subviews: [
                                titleLabel,
                                descriptionLabel,
                                authorLabel
                              ]
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 8
        return view
    }()
    
    lazy var containerHStack: HStackView = {
        let view = HStackView(alignment: .center,
                              spacing: 4,
                              distribution: .fillProportionally,
                              margins: .init(top: 4, left: 4, bottom: 4, right: 4),
                              subviews: [
                                bookImage,
                                containerVStack
                              ]
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 8
        return view
    }()
    
    // MARK: - Overrides
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initViewCode()
    }
    
}

// MARK: - Functions

extension BooksCollectionCell {
    
    func data(data: VolumeInfo) {
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        
        if let authors = data.authors {
            let authorsText = authors.joined(separator: ", ")
            authorLabel.text = authors.count > 1
            ? "Autores: \(authorsText)"
            : "Autor: \(authorsText)"
        } else {
            authorLabel.text = "Autor: Unknown Author"
        }
        
        if let imageLinks = data.imageLinks,
           let thumbnailURLString = imageLinks.thumbnail,
           let thumbnailURL = URL(string: thumbnailURLString.replacingOccurrences(of: "http", with: "https")) {
            bookImage.sd_setImage(with: URL(string: thumbnailURL.absoluteString), placeholderImage: UIImage(systemName: "photo")?.withRenderingMode(.alwaysTemplate))
        } else {
            bookImage.image = UIImage(systemName: "photo")?.withRenderingMode(.alwaysTemplate)
        }
    }
    
}

// MARK: -  ConfigureConstraints

extension BooksCollectionCell: ViewCode {
    
    func configureSubviews() {
        contentView.addSubview(containerHStack)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            containerHStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerHStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerHStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            bookImage.widthAnchor.constraint(equalToConstant: 100),
            bookImage.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func configureAdditionalBehaviors() { }
    
}
