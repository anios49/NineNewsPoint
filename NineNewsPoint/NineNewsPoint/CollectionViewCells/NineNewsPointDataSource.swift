//
//  NineNewsPointDataSource.swift
//  NineNewsPoint
//
//  Created by Animesh Mishra on 26/11/21.
//

import Foundation
import NineNewsPointServices

public class NineNewsPointDataSource: NineNewsPointCollectionViewCellDataSource {
    // MARK: - Private Variables
    /// News Url
    public let url: String
    
    ///News Article List
    public let assets: AssetsListData?
    
    ///If an 'asset' has 'relatedImages', display the smallest image available as a thumbnail on the cell\
    /// Sorting of images on the basis of their area = width*height.
    public var imageURL: String? {
        var images = assets?.relatedImages
        images?.sort(by: { ($0.width * $0.height) < ($1.width * $1.height) })
        return images?.first?.url
    }
    
    /// News Headline
    public var headingLabelText: String? {
        assets?.headline
    }
    
    /// News Abstract
    public var abstractLabelText: String? {
        assets?.theAbstract
    }
    
    /// News Author information
    public var authorLabelText: String? {
        assets?.byLine
    }
   
    /// Provide date in "MMM dd, hh:mm a" format
    public var dateTimeLabelText: String? {
        assets?.timeStamp.getDateTimeString()
    }
    
    // MARK: Public Intializer
    /// NineNewsPointDataSource
    /// - Parameters:
    ///   - assets: AssetsListData
    public init(assets: AssetsListData?) {
        self.assets = assets
        self.url = assets?.url ?? Constants.BlankString
    }
    
}
