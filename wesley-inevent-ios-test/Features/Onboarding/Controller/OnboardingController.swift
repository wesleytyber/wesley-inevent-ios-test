//
//  OnboardingController.swift
//  wesley-inevent-ios-test
//
//  Created by Wesley Calazans on 19/10/23.
//

import UIKit

class OnboardingController: UIViewController {
    
    private var onboardingView: OnboardingView = OnboardingView()
    private var onboardingViewModel: OnboardingViewModel = OnboardingViewModel()
    private var index = 0
    
    override func loadView() {
        onboardingView = OnboardingView()
        view = onboardingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initController()
    }
    
}

// MARK: - Controller

extension OnboardingController: Controller {
    
    func configureRequets() { }
    
    func configureDelegates() {
        onboardingView.onboardingCollectionViewProtocols(delegate: self, dataSource: self)
        onboardingView.delegate(delegate: self)
    }
    
    func configureCompositionalLayout() { }
    
    func configureAdditionalBehaviors() {
        onboardingViewModel = OnboardingViewModel()
    }
    
}

// MARK: - GenericDelegate

extension OnboardingController: GenericDelegate {
    
    func tappedButton(_ view: UIView) {
        let nextIndex = min((onboardingView.onboardingViewPageControl.currentPage ) + 1, (onboardingViewModel.getOnboardingInfo.count) + 1)
        let index = IndexPath(item: nextIndex, section: 0)
        onboardingView.onboardingViewPageControl.currentPage = nextIndex
        
        if nextIndex == 2 {
            let vc = UINavigationController(rootViewController: BooksController())
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        } else if nextIndex == 1 {
            onboardingView.onboardingCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        } else {
            onboardingView.onboardingCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        }
        
    }
    
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource

extension OnboardingController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        onboardingView.onboardingViewPageControl.numberOfPages = onboardingViewModel.getOnboardingInfo.count
        return onboardingViewModel.getOnboardingInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.identifier, for: indexPath) as? OnboardingCell else { return UICollectionViewCell() }
        cell.configureCell(data: onboardingViewModel.getOnboardingInfo[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == 1 {
            index = -1
            onboardingView.skipIntroButton.setTitle("Iniciar", for: .normal)
        } else if indexPath.row == 0 {
            index = -0
            onboardingView.skipIntroButton.setTitle("Próximo", for: .normal)
        } else {
            onboardingView.skipIntroButton.setTitle("Próximo", for: .normal)
        }
        
        guard let visible = collectionView.visibleCells.last else {return}
        guard let index = collectionView.indexPath(for: visible)?.row else {return}
        onboardingView.onboardingViewPageControl.currentPage = index
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let visible = collectionView.visibleCells.last else {return}
        guard let index = collectionView.indexPath(for: visible)?.row else {return}
        onboardingView.onboardingViewPageControl.currentPage = index
    }
    
}
