//
//  AuthorsListData.swift
//  NineNewsPoint
//
//  Created by Animesh Mishra on 26/11/21.
//

import Foundation

public struct AuthorsListData: Codable {
    //Data
    public let email: String?
    public let name: String?
    public let title: String?
    
    //ListCustomData
    public let relatedAssets: [RelatedAssetsListData]?
    public let relatedImages: [RelatedImagesListData]?
}
