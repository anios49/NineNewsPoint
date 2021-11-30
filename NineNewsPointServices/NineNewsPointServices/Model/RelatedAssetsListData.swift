//
//  RelatedAssetsListData.swift
//  NineNewsPoint
//
//  Created by Animesh Mishra on 26/11/21.
//

import Foundation

public struct RelatedAssetsListData: Codable {
    public let assetType: String?
    public let headline: String?
    public let id: Int?
    public let lastModified: Int?
    public let sponsored: Bool
    public let timeStamp: Int?
    public let url: String?
    
    //
    public let authors: [AuthorsListData]?
    public let categories: [CategoriesListData]?
}
