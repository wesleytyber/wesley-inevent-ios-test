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
    private var bookModel: ModelBooks?
    
    private var isLoadingData = false
    private let pageSize = 10
    
}

// MARK: - BooksViewModelProtocol

extension BooksViewModel {
    
    func delegate(delegate: BooksViewModelProtocol?) {
        self.delegate = delegate
    }
    
}

// MARK: - Resquest

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
    
    func getBooksPage(search: String) {
        let startIndex = bookModel?.items.count ?? 0
        booksService.fetchBooksPage(with: search, startIndex: startIndex, pageSize: pageSize) { response in
            switch response {
            case .success(let response):
                print("resposta de sucesso", response)
                self.bookModel?.items.append(contentsOf: response.items)
                DispatchQueue.main.async { [self] in
                    self.isLoadingData = false // Restablece el indicador de carga
                }
                self.bookModel = response
                self.delegate?.fetchSuccess()
            case .failure(let error):
                print("Error fetching data: \(error)")
                self.delegate?.fetchError(message: error.localizedDescription)
                self.isLoadingData = false
            }
        }
    }
    
}

// MARK: - CollectionCell

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
