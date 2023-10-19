//
//  BooksView.swift
//  wesley-inevent-ios-test
//
//  Created by Wesley Calazans on 18/10/23.
//

import UIKit
import StackViewKit
import SDWebImage

class BooksView: UIView {
    
    lazy var searchBar: UISearchController = {
        let searchBar = UISearchController(searchResultsController: nil)
        searchBar.searchBar.placeholder = "Ex: Harry potter"
        searchBar.automaticallyShowsCancelButton = true
        searchBar.searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentInsetAdjustmentBehavior = .never
        view.register(BooksCollectionCell.self, forCellWithReuseIdentifier: BooksCollectionCell.identifier)
        view.showsVerticalScrollIndicator = false
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

extension BooksView {
    
    func searchBarDelegate(delegate: UISearchResultsUpdating) {
        searchBar.searchResultsUpdater = delegate
    }
    
    func configureCollectionViewDelegate(delegate: UICollectionViewDelegate,
                                         datasource: UICollectionViewDataSource) {
        collectionView.delegate = delegate
        collectionView.dataSource = datasource
    }
    
}

// MARK: - ConfigureConstraints

extension BooksView: ViewCode {
    
    func configureSubviews() {
        addSubview(collectionView)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func configureAdditionalBehaviors() { }
    
}
