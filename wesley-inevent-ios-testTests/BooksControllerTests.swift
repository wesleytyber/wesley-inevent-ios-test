//
//  wesley_inevent_ios_testTests.swift
//  wesley-inevent-ios-testTests
//
//  Created by Wesley Calazans on 20/10/23.
//

import XCTest

@testable import wesley_inevent_ios_test

class ViewModelMock {
    weak var delegate: BooksViewModelProtocol?
    
    func action() {
        delegate?.fetchSuccess()
    }
}

final class BooksControllerTests: XCTestCase {
    
    private var booksView: BooksView = BooksView()
    private var booksController: BooksController!
    private var collectionView: UICollectionView!
    private var collectionViewMock: CollectionViewMock!
    private var viewModelMock = ViewModelMock()
    
    override func setUpWithError() throws {
        booksController = BooksController()
        booksController?.loadViewIfNeeded()
        continueAfterFailure = false
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        booksView.collectionView = collectionView
        booksView.configureCollectionViewDelegate(delegate: booksController.self, datasource: booksController.self)
        viewModelMock = ViewModelMock()
        viewModelMock.delegate = booksController
        collectionViewMock = CollectionViewMock(frame: .zero, collectionViewLayout: UICollectionViewLayout.init())
    }

    override func tearDownWithError() throws {
        booksController = nil
        collectionView = nil
        collectionViewMock = nil
    }

    func testConfigCollection() throws {
        XCTAssertTrue(booksView.collectionView.delegate is BooksViewModelProtocol)
        XCTAssertTrue(booksView.collectionView.dataSource is BooksViewModelProtocol)
    }
    
    func testNumberOfItemsInSection() {
        collectionViewMock.dataSource = booksController
        collectionViewMock.delegate = booksController
        XCTAssertEqual(collectionViewMock.numberOfRows, 0)
        _ = collectionViewMock.numberOfItems(inSection: 0)
        XCTAssertEqual(collectionViewMock.numberOfRows, 1)
    }
    
    func testCellForItemAtIndexPath() {
        collectionViewMock.dataSource = booksController
        XCTAssertEqual(collectionViewMock.cellForItem, 0)
        _ = collectionViewMock.cellForItem(at: IndexPath(row: 0, section: 0))
        XCTAssertEqual(collectionViewMock.cellForItem, 1)
    }
    
}

class CollectionViewMock: UICollectionView {
    var numberOfRows = 0
    var cellForItem = 0
    
    override func numberOfItems(inSection section: Int) -> Int {
        numberOfRows += 1
        return super.numberOfItems(inSection: section)
    }
    
    override func cellForItem(at indexPath: IndexPath) -> UICollectionViewCell? {
        cellForItem += 1
        return super.cellForItem(at: indexPath)
    }
}
