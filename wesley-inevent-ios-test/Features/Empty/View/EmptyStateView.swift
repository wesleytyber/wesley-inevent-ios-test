//
//  EmptyStateView.swift
//  wesley-inevent-ios-test
//
//  Created by Wesley Calazans on 19/10/23.
//

import UIKit
import StackViewKit

class EmptyStateView: UIView {
    
    lazy var ImageView: UIImageView = {
        let image = UIImage(systemName: "books.vertical.fill")
        let imageView = UIImageView(image: image)
        imageView.tintColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Para começar, pesquise por livros do seu interesse, temos um catálogo imenso."
        label.numberOfLines = 0
        label.textColor = .gray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    lazy var containerVStack: VStackView = {
        let view = VStackView(alignment: .center,
                              spacing: 8,
                              distribution: .equalCentering,
                              margins: .init(top: 4, left: 16, bottom: 4, right: 16),
                              subviews: [
                                ImageView,
                                messageLabel
                              ]
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

extension EmptyStateView: ViewCode {
    
    func configureSubviews() {
        addSubview(containerVStack)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            ImageView.widthAnchor.constraint(equalToConstant: 156),
            ImageView.heightAnchor.constraint(equalToConstant: 136),
            
            containerVStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            containerVStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerVStack.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
    }
    
    func configureAdditionalBehaviors() { }

}

