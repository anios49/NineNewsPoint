//
//  NineNewsPointCollectionViewCell.swift
//  NineNewsPoint
//
//  Created by Animesh Mishra on 26/11/21.
//

import UIKit
import NineNewsPointServices

// MARK: NineNewsPointCollectionViewCell Data Source Protocol
public protocol NineNewsPointCollectionViewCellDataSource {
    var imageURL:String? { get }
    var headingLabelText:String? { get }
    var abstractLabelText:String? { get }
    var authorLabelText:String? { get }
    var dateTimeLabelText:String? { get }
}

// MARK: NineNewsPointCollectionViewCell Delegate Protocol
public protocol NineNewsPointCollectionViewCellDelegate: class {
    func buttonAction(headingText:String, abstractText:String, newsUrl:String)
}

class NineNewsPointCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var abstractLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var cellWidthConstraintConstant: NSLayoutConstraint!
    
    // MARK: - Variables
    weak var delegate: NineNewsPointCollectionViewCellDelegate?
    var newsUrl = Constants.BlankString
    
    override func awakeFromNib() {
        super.awakeFromNib()
        /// Labels color setup
        headingLabel.textColor = UIColor.getAppearanceColor(.black)
        abstractLabel.textColor = UIColor.getAppearanceColor(.black)
        authorLabel.textColor = UIColor.getAppearanceColor(.gray)
        dateTimeLabel.textColor = UIColor.getAppearanceColor(.gray)
    }
    
    /// Set custom cell & lables data
    /// - Parameter nineNewsPointDataSource: NineNewsPointDataSource
    func setCellData(_ nineNewsPointDataSource: NineNewsPointDataSource) {
        headingLabel.text = nineNewsPointDataSource.headingLabelText
        abstractLabel.text = nineNewsPointDataSource.abstractLabelText
        authorLabel.text = nineNewsPointDataSource.authorLabelText
        dateTimeLabel.text = nineNewsPointDataSource.dateTimeLabelText
        imageView.loadImage(urlSting: nineNewsPointDataSource.imageURL ?? Constants.BlankString)
        newsUrl = nineNewsPointDataSource.url
        
        /// Cell width setup using Constraint Constant
        cellWidthConstraintConstant.constant = UIWindow.isLandscape ? UIScreen.main.bounds.width - 96 : UIScreen.main.bounds.width - 16
    }
    
    /// Share Button Action
    /// - Parameter sender: Any
    @IBAction func shareButtonAction(_ sender: Any) {
        delegate?.buttonAction(headingText:self.headingLabel.text ?? Constants.BlankString, abstractText:self.abstractLabel.text ?? Constants.BlankString, newsUrl: newsUrl)
    }
}
