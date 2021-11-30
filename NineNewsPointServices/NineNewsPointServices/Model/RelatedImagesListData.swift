//
//  RelatedImagesListData.swift
//  NineNewsPoint
//
//  Created by Animesh Mishra on 26/11/21.
//

import Foundation

public struct RelatedImagesListData: Codable {
    public let assetType: String?
    public let authors: [AuthorsListData]?
    public let brands: [BrandListData]?
    public let categories: [CategoriesListData]?
    public let descriptionField: String?
    public let height: Int
    public let id: Int?
    public let lastModified: Int?
    public let photographer: String?
    public let sponsored: Bool
    public let timeStamp: Int?
    public let type: String?
    public let url: String
    public let width: Int
}
