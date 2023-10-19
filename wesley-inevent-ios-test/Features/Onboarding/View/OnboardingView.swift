//
//  OnboardingView.swift
//  wesley-inevent-ios-test
//
//  Created by Wesley Calazans on 19/10/23.
//

import UIKit
import StackViewKit

class OnboardingView: UIView {
    
    private weak var delegate: GenericDelegate?
    
    lazy var onboardingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSizeMake(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.indicatorStyle = .default
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isDirectionalLockEnabled = true
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: OnboardingCell.identifier)
        return collectionView
    }()
    
    lazy var onboardingViewPageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .systemRed
        pageControl.pageIndicatorTintColor = .gray
        pageControl.isUserInteractionEnabled = false
        pageControl.isAccessibilityElement = false
        pageControl.tag = 1
        pageControl.layer.masksToBounds = true
        pageControl.layer.cornerRadius = 10
        return pageControl
    }()
    
    lazy var skipIntroButton: UIButton = {
        let button = UIButton()
        button.setTitle("Próximo", for: .normal)
        button.tag = 1
        button.backgroundColor = .systemPink
        button.addTarget(self, action: #selector(skipIntroButtonTapped), for: .touchUpInside)
        return button
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

extension OnboardingView {
    
    func delegate(delegate: GenericDelegate?) {
        self.delegate = delegate
    }
    
    func onboardingCollectionViewProtocols(delegate: UICollectionViewDelegate,
                                           dataSource: UICollectionViewDataSource) {
        onboardingCollectionView.delegate = delegate
        onboardingCollectionView.dataSource = dataSource
    }
    
    @objc func skipIntroButtonTapped(_ button: UIButton) {
        self.delegate?.tappedButton(button)
    }
    
}

// MARK: - ViewCode

extension OnboardingView: ViewCode {
    
    func configureSubviews() {
        addSubview(onboardingCollectionView)
        addSubview(onboardingViewPageControl)
        addSubview(skipIntroButton)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            onboardingCollectionView.topAnchor.constraint(equalTo: topAnchor),
            onboardingCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            onboardingCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            onboardingCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            onboardingViewPageControl.topAnchor.constraint(equalTo: onboardingCollectionView.bottomAnchor, constant: -120),
            onboardingViewPageControl.leadingAnchor.constraint(equalTo: leadingAnchor),
            onboardingViewPageControl.trailingAnchor.constraint(equalTo: trailingAnchor),
            onboardingViewPageControl.heightAnchor.constraint(equalToConstant: 50),
            
            skipIntroButton.topAnchor.constraint(equalTo: onboardingViewPageControl.topAnchor, constant: -44),
            skipIntroButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100),
            skipIntroButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100),
            skipIntroButton.heightAnchor.constraint(equalToConstant: 44),
            
        ])
    }
    
    func configureAdditionalBehaviors() { }
    
    func configureAccessibility() { }
    
}
