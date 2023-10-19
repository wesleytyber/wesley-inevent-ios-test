//
//  OnboardingCell.swift
//  wesley-inevent-ios-test
//
//  Created by Wesley Calazans on 19/10/23.
//

import UIKit
import StackViewKit

class OnboardingCell: UICollectionViewCell {
    
    static let identifier = "OnboardingCell"
    
    var onboardingViewModel: OnboardingCellViewModel?
    
    lazy var onboardingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var onboardingPrimaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    lazy var onboardingSecondaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    lazy var containerVStack: VStackView = {
        let view = VStackView(alignment: .center,
                              spacing: 8,
                              distribution: .equalCentering,
                              margins: .init(top: 4, left: 16, bottom: 4, right: 16),
                              subviews: [
                                onboardingImageView,
                                onboardingPrimaryLabel,
                                onboardingSecondaryLabel
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

// MARK: - Functions

extension OnboardingCell {
    
    func configureCell(data: OnboardingModel) {
        onboardingViewModel = OnboardingCellViewModel(onboardingModel: data)
        onboardingPrimaryLabel.text = onboardingViewModel?.primaryLabel
        onboardingSecondaryLabel.text = onboardingViewModel?.secondaryLabel
        onboardingImageView.image = UIImage(named: onboardingViewModel?.imageString ?? "")
    }
    
}

// MARK: - ViewCode

extension OnboardingCell: ViewCode {
    
    func configureSubviews() {
        contentView.addSubview(containerVStack)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            onboardingImageView.widthAnchor.constraint(equalToConstant: 250),
            onboardingImageView.heightAnchor.constraint(equalToConstant: 250),
            
            containerVStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            containerVStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerVStack.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func configureAdditionalBehaviors() { }
    
    func configureAccessibility() { }
    
}
