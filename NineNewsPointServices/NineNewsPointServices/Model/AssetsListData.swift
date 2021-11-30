//
//  AssetsListData.swift
//  NineNewsPoint
//
//  Created by Animesh Mishra on 26/11/21.
//

import Foundation

public struct AssetsListData: Codable {
    //Data
    public let acceptComments: Bool
    public let assetType: String?
    public let byLine: String
    public let headline: String
    public let id: Int
    public let indexHeadline: String?
    public let lastModified: Int?
    public let legalStatus: String?
    public let numberOfComments: Int?
    public let onTime: Int?
    public let signPost: String?
    public let sponsored: Bool
    public let tabletHeadline: String?
    public let theAbstract: String
    public let timeStamp: Date
    public let url: String?

    //ListCustomData
    public let authors: [AuthorsListData]?
    public let categories: [CategoriesListData]?
    public let companies: [CompanyListData]?
    public let overrides: OverrideData?
    public let relatedAssets: [RelatedAssetsListData]?
    public let relatedImages: [RelatedImagesListData]?
    public let sources: [SourceData]?
}
