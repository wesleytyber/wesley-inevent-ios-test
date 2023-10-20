//
//  BooksController.swift
//  wesley-inevent-ios-test
//
//  Created by Wesley Calazans on 14/10/23.
//

import UIKit

class BooksController: UIViewController {
    
    private var booksView: BooksView = BooksView()
    private let booksViewModel: BooksViewModel = BooksViewModel()
    private var emptyView: EmptyStateView?
    
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
        updateEmptyViewVisibility()
    }
    
}

// MARK: - Functions

extension BooksController {
    
    func updateEmptyViewVisibility() {
        let isEmpty = booksViewModel.numberOfItemsInSection == 0
        if isEmpty {
            emptyView = EmptyStateView()
            emptyView?.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(emptyView!)
            
            NSLayoutConstraint.activate([
                emptyView!.topAnchor.constraint(equalTo: view.topAnchor),
                emptyView!.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                emptyView!.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                emptyView!.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        } else {
            emptyView?.removeFromSuperview()
        }
    }
}
           
// MARK: - UISearchResultsUpdating & UISearchBarDelegate

extension BooksController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        booksViewModel.searchText = text.trimmingCharacters(in: .whitespaces)
        booksViewModel.getBooks(search: booksViewModel.searchText)
        emptyView?.removeFromSuperview()
    }
    
}

// MARK: - Controller

extension BooksController: Controller {
    
    func configureRequets() { }
    
    func configureDelegates() {
        booksView.searchBar.searchResultsUpdater = self
        booksViewModel.delegate(delegate: self)
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
        navigationItem.title = "Google Livros"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.searchController = booksView.searchBar
    }
    
}

extension BooksController: BooksViewModelProtocol {
    
    func fetchSuccess() {
        booksView.collectionView.reloadData()
    }
    
    func fetchError(message: String) { }
    
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource

extension BooksController: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return booksViewModel.numberOfSections
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return booksViewModel.numberOfItemsInSection
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return booksViewModel.configureCell(collectionView: booksView.collectionView, for: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = DetailBooksController(viewModel: booksViewModel.books(indexPath: indexPath))
        detailController.modalPresentationStyle = .fullScreen
        present(detailController, animated: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let visibleHeight = scrollView.frame.height
        
        if offsetY > contentHeight - visibleHeight {
            booksViewModel.getBooksPerPage()
        }
    }
    
}
