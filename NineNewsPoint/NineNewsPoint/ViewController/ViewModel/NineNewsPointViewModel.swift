//
//  NineNewsPointViewModel.swift
//  NineNewsPoint
//
//  Created by Animesh Mishra on 26/11/21.
//

import Foundation
import UIKit
import NineNewsPointServices

// MARK: - NineNewsPointViewModelDelegate
/// NineNewsPointViewModelDelegate for API success and fail handling
protocol NineNewsPointViewModelDelegate: AnyObject {
    func success(assets: [AssetsListData]?)
    func failure()
}

public class NineNewsPointViewModel {
    // MARK: - Public variables
    public var assets: [AssetsListData]? = nil
    
    // MARK: - Internal variables
    weak var delegate: NineNewsPointViewModelDelegate?
    
    // MARK: - Public functions
    /// Request API Data
    func requestData() {
        requestAPI()
    }

    // MARK: - Private functions
    // fetch News data
    private func requestAPI() {
        Networking.fetchNineNewsData { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let nineNewsPointData):
                self.assets = nineNewsPointData.assets
                /// Display the latest article first in the list, use article's 'timeStamp
                self.assets?.sort(by: { $0.timeStamp > $1.timeStamp})
                self.delegate?.success(assets: self.assets)

            case .failure( _):
                self.delegate?.failure()
            }
        }
    }
}

// MARK: - NineNewsPointViewModel - Extension for Collection View
extension NineNewsPointViewModel {
    
    /// cellForItemAtIndexPathForSection - Provide data source object for the cell for the collection view.
    /// - Parameters:
    ///   - row: An index number identifying a row in collection view.
    /// - Returns: NineNewsPointDataSource
    
    public func cellForItemAtIndexPathForSection(row: Int) -> NineNewsPointDataSource? {
        return NineNewsPointDataSource(assets: assets?[row])
    }
    
    /// numberOfItemsInSection - Provide number of items in the specified of the collection view.
    /// - Returns: Integer (Number of items)
    public func numberOfItemsInSection() -> Int {
        return assets?.count ?? 0
    }
    
    ///  collectionViewLayoutSize - Provide size of the specified item’s cell of collection view
    /// - Parameter collectionView: UICollectionView
    /// - Returns: CGSize
    public func collectionViewLayoutSize(_ collectionView: UICollectionView) -> CGSize {
        UIWindow.isLandscape ?
            CGSize(width: collectionView.frame.width -  32.0, height: collectionView.frame.height) :
            CGSize(width: collectionView.frame.width -  32.0, height: collectionView.frame.height / 2)
    }
}
