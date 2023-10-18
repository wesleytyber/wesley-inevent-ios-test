//
//  BooksViewModel.swift
//  wesley-inevent-ios-test
//
//  Created by Wesley Calazans on 18/10/23.
//

import UIKit

protocol BooksViewModelProtocol: AnyObject {
    func fetchSuccess()
    func fetchError(message: String)
}

class BooksViewModel: NSObject {
    
    private weak var delegate: BooksViewModelProtocol?
    private var booksService: BooksService = BooksService()
    private var bookModel: ModelBooks!
    var isLoadingData = false
    var searchText = ""
}

// MARK: - BooksViewModelProtocol

extension BooksViewModel {
    
    func delegate(delegate: BooksViewModelProtocol?) {
        self.delegate = delegate
    }
    
}

extension BooksViewModel {
    
    func getBooks(search: String) {
        booksService.searchBooks(with: search) { [weak self] response, error in
            guard let self else { return }
            
            if let response {
                bookModel = response
                delegate?.fetchSuccess()
            } else {
                delegate?.fetchError(message: error?.localizedDescription ?? "")
            }
        }
    }
    
}

extension BooksViewModel {
    
    var numberOfSections: Int {
        return 1
    }
    
    var numberOfItemsInSection: Int {
        return bookModel?.items.count ?? 0
    }
    
    func books(indexPath: IndexPath) -> VolumeInfo {
        return (bookModel?.items[indexPath.row].volumeInfo)!
    }
    
    func configureCell(collectionView: UICollectionView, for indexPath: IndexPath) -> BooksCollectionCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BooksCollectionCell.identifier, for: indexPath) as? BooksCollectionCell else { return .init() }
        cell.data(data: books(indexPath: indexPath))
        return cell
    }
    
}
