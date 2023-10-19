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
        contentView.addSubview(onboardingImageView)
        contentView.addSubview(onboardingPrimaryLabel)
        contentView.addSubview(onboardingSecondaryLabel)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            onboardingImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 24),
            onboardingImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            onboardingImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            onboardingImageView.heightAnchor.constraint(equalToConstant: 250),
            
            onboardingPrimaryLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            onboardingPrimaryLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            onboardingPrimaryLabel.topAnchor.constraint(equalTo: onboardingImageView.bottomAnchor, constant: 50),
            
            onboardingSecondaryLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            onboardingSecondaryLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            onboardingSecondaryLabel.topAnchor.constraint(equalTo: onboardingPrimaryLabel.bottomAnchor, constant: 12)
        ])
    }
    
    func configureAdditionalBehaviors() { }
    
    func configureAccessibility() { }
    
}
