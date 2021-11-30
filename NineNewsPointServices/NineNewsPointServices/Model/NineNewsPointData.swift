//
//  NineNewsData.swift
//  NineNewsPoint
//
//  Created by Animesh Mishra on 26/11/21.
//

import Foundation

public struct NineNewsPointData: Codable {
    //Data
    public let assetType: String?
    public let displayName: String?
    public let id: Int?
    public let lastModified: Int?
    public let onTime: Int?
    public let sponsored: Bool?
    public let timeStamp: Int?
    public let url: String?

    //ListCustomData
    public let authors: [AuthorsListData]?
    public let assets: [AssetsListData]?
    public let categories: [CategoriesListData]?
    public let relatedAssets: [RelatedAssetsListData]?
    public let relatedImages: [RelatedImagesListData]?
}
