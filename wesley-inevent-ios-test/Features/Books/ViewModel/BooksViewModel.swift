//
//  HomeViewModel.swift
//  wesley-inevent-ios-test
//
//  Created by Wesley Calazans on 18/10/23.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    func fetchSuccess()
    func fetchError(message: String)
}

class HomeViewModel: NSObject {
    
    private weak var delegate: HomeViewModelProtocol?
    private var homeService: HomeService = HomeService()
    private var service: Service = Service()
    private var searchViewModel: SearchViewModel = SearchViewModel(service: SearchService())
    private var lines = P()
    private var linesArray: [L] = []
    var linePosition: [PS] = []
    private var currentTime = ""
    var stopSearch: [StopSearch] = []
    private var locationManager: CLLocationManager = CLLocationManager()
    var userLocation: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var userAddress = ""
    
}

extension HomeViewModel {
    
    var numberOfSections: Int {
        return 2
    }
    
    var numberOfItemsInSection: Int {
        return linesArray.prefix(3).count
    }
    
    var nextArrivedNumberOfItemsInSection: Int {
        return linesArray.count
    }
    
    func loadLines(indexPath: IndexPath) -> L {
        return linesArray[indexPath.row]
    }
    
    func configureCell(collectionView: UICollectionView, for indexPath: IndexPath) -> HomeCollectionCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionCell.identifier, for: indexPath) as? HomeCollectionCell else { return .init() }
        cell.data(data: loadLines(indexPath: indexPath), actual: currentTime)
        return cell
    }
    
}
