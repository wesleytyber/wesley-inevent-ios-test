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
    
    lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSizeMake(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
        return layout
    }()
    
    lazy var onboardingCollectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.indicatorStyle = .default
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.isDirectionalLockEnabled = true
        view.contentInsetAdjustmentBehavior = .never
        view.register(OnboardingCell.self, forCellWithReuseIdentifier: OnboardingCell.identifier)
        return view
    }()
    
    lazy var onboardingViewPageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .systemRed
        pageControl.pageIndicatorTintColor = .gray
        pageControl.isUserInteractionEnabled = false
        pageControl.tag = 1
        pageControl.layer.masksToBounds = true
        pageControl.layer.cornerRadius = 10
        return pageControl
    }()
    
    lazy var skipIntroButton: UIButton = {
        let button = UIButton()
        button.setTitle("Próximo", for: .normal)
        button.setButtonDesign(layout: .primary)
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
            skipIntroButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            skipIntroButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            skipIntroButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureAdditionalBehaviors() { }
    
    func configureAccessibility() { }
    
}
