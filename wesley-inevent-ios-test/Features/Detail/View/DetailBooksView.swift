//
//  BooksDetailView.swift
//  wesley-inevent-ios-test
//
//  Created by Wesley Calazans on 18/10/23.
//

import UIKit
import StackViewKit

class DetailBooksView: UIView {
    
    private weak var delegate: GenericDelegate?
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isScrollEnabled = true
        view.backgroundColor = .clear
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "darkOnLight"), for: .normal)
        button.clipsToBounds = true
        button.tag = 1
        button.layer.zPosition = 1
        button.addTarget(self, action: #selector(tappedCloseDetailButton), for: .touchUpInside)
        return button
    }()
    
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
        label.textColor = .label.withAlphaComponent(0.8)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var publishedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var containerLabelsVStack: VStackView = {
        let view = VStackView(alignment: .leading,
                              spacing: 8,
                              distribution: .fillProportionally,
                              margins: .init(top: 4, left: 4, bottom: 4, right: 4),
                              subviews: [
                                titleLabel,
                                authorLabel,
                                publishedLabel,
                                descriptionLabel,
                              ]
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var containerVStack: VStackView = {
        let view = VStackView(alignment: .center,
                              spacing: 8,
                              distribution: .equalCentering,
                              margins: .init(top: 4, left: 4, bottom: 4, right: 4),
                              subviews: [
                                bookImage,
                                containerLabelsVStack,
                              ]
        )
        view.translatesAutoresizingMaskIntoConstraints = false
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

extension DetailBooksView {
    
    func configure(_ data: VolumeInfo) {
        
        // MARK: - Thumbnail
        
        if let imageLinks = data.imageLinks,
           let thumbnailURLString = imageLinks.thumbnail,
           let thumbnailURL = URL(string: thumbnailURLString.replacingOccurrences(of: "http", with: "https")) {
            bookImage.sd_setImage(with: URL(string: thumbnailURL.absoluteString), placeholderImage: UIImage(systemName: "photo")?.withRenderingMode(.alwaysTemplate))
        } else {
            bookImage.image = UIImage(systemName: "photo")?.withRenderingMode(.alwaysTemplate)
        }
        
        // MARK: - Title
        
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemGray,
            .font: UIFont.systemFont(ofSize: 20, weight: .bold)
        ]
        
        let titleInfoAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.label,
            .font: UIFont.systemFont(ofSize: 20, weight: .bold)
        ]
        
        let attributedTitle = NSMutableAttributedString(
            string: "Livro: ",
            attributes: titleAttributes
        )
        
        attributedTitle.append(NSAttributedString(string: data.title ?? "", attributes: titleInfoAttributes))
        titleLabel.attributedText = attributedTitle
        
        // MARK: - Authors
        
        if let authors = data.authors {
            let authorsText = authors.joined(separator: ", ")
            let authorTextAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.systemGray,
                .font: UIFont.systemFont(ofSize: 20, weight: .bold)
            ]
            
            let authorInfoTextAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.label,
                .font: UIFont.systemFont(ofSize: 20, weight: .bold)
            ]

            let authorAttributedString = NSMutableAttributedString(
                string: authors.count > 1 ? "Autores: " : "Autor: ",
                attributes: authorTextAttributes
            )

            authorAttributedString.append(NSAttributedString(string: authorsText, attributes: authorInfoTextAttributes))
            authorLabel.attributedText = authorAttributedString
            
        } else {
            let unknownAuthorText: String = "Autor: Unknown Author"
            let unknownAuthorAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.label,
                .font: UIFont.systemFont(ofSize: 20, weight: .bold)
            ]
            let unknownAuthorAttributedString = NSAttributedString(string: unknownAuthorText, attributes: unknownAuthorAttributes)
            authorLabel.attributedText = unknownAuthorAttributedString
        }
        
        // MARK: - Published date
        
        let publishedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemGray,
            .font: UIFont.systemFont(ofSize: 20, weight: .bold)
        ]
        
        let publishedInfoAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.label,
            .font: UIFont.systemFont(ofSize: 20, weight: .bold)
        ]
        
        let publishedAttributedTitle = NSMutableAttributedString(
            string: "Publicado em: ",
            attributes: publishedAttributes
        )
        
        publishedAttributedTitle.append(NSAttributedString(string:
                                                            convertDateFormatter(inputDateString: data.publishedDate ?? "Não disponível",
                                                                                 inputFormat: "yyyy-MM-dd",
                                                                                 outputFormat: "dd/MM/yyyy") ?? "Não disponível",
                                                           attributes: publishedInfoAttributes))
        publishedLabel.attributedText = publishedAttributedTitle
        
        // MARK: - Description
        
        let descriptionAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemGray,
            .font: UIFont.systemFont(ofSize: 20, weight: .bold)
        ]
        
        let descriptionInfoAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.label.withAlphaComponent(0.5),
            .font: UIFont.systemFont(ofSize: 16, weight: .bold)
        ]
        
        let descriptionAttributedTitle = NSMutableAttributedString(
            string: "Sinopse: ",
            attributes: descriptionAttributes
        )
        
        descriptionAttributedTitle.append(NSAttributedString(string: data.description ?? "Não disponível", attributes: descriptionInfoAttributes))
        descriptionLabel.attributedText = descriptionAttributedTitle
        
    }
    
    func delegate(delegate: GenericDelegate?) {
        self.delegate = delegate
    }
    
    @objc func tappedCloseDetailButton(_ button: UIButton) {
        self.delegate?.tappedButton(button)
    }
    
}

// MARK: - ConfigureConstraints

extension DetailBooksView: ViewCode {
    
    func configureSubviews() {
        addSubview(scrollView)
        addSubview(closeButton)
        scrollView.addSubview(containerVStack)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            closeButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            
            containerVStack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerVStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            containerVStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            containerVStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -50),
        ])
    }
    
    func configureAdditionalBehaviors() {
        backgroundColor = .systemBackground
    }
    
}
