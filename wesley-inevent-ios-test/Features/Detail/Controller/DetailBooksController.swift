//
//  DetailBooksController.swift
//  wesley-inevent-ios-test
//
//  Created by Wesley Calazans on 18/10/23.
//

import UIKit
import ServiceKit

class DetailBooksController: UIViewController {
    
    private var detailBooksView: DetailBooksView = DetailBooksView()
    private var booksViewModel: BooksViewModel = BooksViewModel()
    private var volumeInfo: VolumeInfo?
    
    override func loadView() {
        detailBooksView = DetailBooksView()
        view = detailBooksView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initController()
    }
    
    convenience init(viewModel: VolumeInfo) {
        self.init()
        configureViewModel(viewModel)
    }
    
}

// MARK: - Configure HomeViewModel

extension DetailBooksController {
    
    func configureViewModel(_ volumeInfo: VolumeInfo) {
        self.volumeInfo = volumeInfo
    }
    
}

// MARK: - Configure controller

extension DetailBooksController: Controller {
    
    func configureRequets() { 
        if let volumeInfo = volumeInfo {
            detailBooksView.configure(volumeInfo)
        }
    }
    
    func configureDelegates() {
        detailBooksView.delegate(delegate: self)
    }
    
    func configureCompositionalLayout() { }
    
    func configureAdditionalBehaviors() { }
    
}

// MARK: - GenericDelegate

extension DetailBooksController: GenericDelegate {
    
    func tappedButton(_ view: UIView) {
        switch view.tag {
        case 1:
            dismiss(animated: true)
        default:
            break
        }
    }
    
}

// MARK: - HomeViewModelProtocol

//extension DetailBooksController: HomeViewModelProtocol {
//    
//    func fetchSuccess() {
//        detailView.collectionView.reloadData()
//    }
//    
//    func fetchError(message: String) {
//        print("Error: message \(message) ❌")
//    }
//    
//}
