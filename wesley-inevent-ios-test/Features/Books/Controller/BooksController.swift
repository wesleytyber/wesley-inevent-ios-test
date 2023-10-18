//
//  BooksController.swift
//  wesley-inevent-ios-test
//
//  Created by Wesley Calazans on 14/10/23.
//

import UIKit

class BooksController: UIViewController {
    
    private var booksView: BooksView = BooksView()
    private let booksviewModel: BooksViewModel = BooksViewModel()
    
    override func loadView() {
        booksView = BooksView()
        view = booksView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initController()
    }
    
}

// MARK: - Controller

extension BooksController: Controller {
    
    func configureRequets() {
        booksviewModel.getBooks(search: "Harry")
    }
    
    func configureDelegates() {
        booksviewModel.delegate(delegate: self)
        booksView.configureCollectionViewDelegate(delegate: self, datasource: self)
    }
    
    func configureCompositionalLayout() {
        let layout = UICollectionViewCompositionalLayout { (sectionNumber, env) in
            switch sectionNumber {
            case 0:
                return LayoutType.reusable.getLayout()
            case 1:
                return LayoutType.normal.getLayout()
            default:
                return LayoutType.normal.getLayout()
            }
        }
        
        booksView.collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    func configureAdditionalBehaviors() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Livros"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}

extension BooksController: BooksViewModelProtocol {
    
    func fetchSuccess() {
        booksView.collectionView.reloadData()
    }
    
    func fetchError(message: String) {
        print("deu ruim")
    }
    
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource

extension BooksController: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return booksviewModel.numberOfSections
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return booksviewModel.numberOfItemsInSection
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return booksviewModel.configureCell(collectionView: booksView.collectionView, for: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let data = viewModel.loadLines(indexPath: indexPath)
        //navigationController?.pushViewController(BooksDetailView(busSelected: data), animated: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let visibleHeight = scrollView.frame.height
        
        if offsetY > contentHeight - visibleHeight {
            print("i'm here")
            
            if !booksviewModel.isLoadingData {
                booksviewModel.isLoadingData = true
            }
        }
    }
    
}
