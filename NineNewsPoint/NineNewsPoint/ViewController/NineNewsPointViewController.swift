//
//  NineNewsPointViewController.swift
//  NineNewsPoint
//
//  Created by Animesh Mishra on 26/11/21.
//

import UIKit
import NineNewsPointServices

class NineNewsPointViewController: UIViewController {
    // MARK: - Private Outlets
    @IBOutlet weak var nineNewsPointCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Private Variables
    private var nineNewsPointViewModel = NineNewsPointViewModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Constants.NewsList
        setupCollectionView()
        setupData()
    }
    
    /// SetupData for View Model
    func setupData() {
        nineNewsPointViewModel.delegate = self
        nineNewsPointViewModel.requestData()
        activityIndicator.startAnimating()
    }
    
    /// Setup Collection View, delegate, datasource and refresh control
    func setupCollectionView() {
        let nineNewsPointCollectionViewCell = UINib.init(nibName: Constants.NineNewsPointCollectionViewCell,
                                               bundle: Bundle(for: NineNewsPointViewController.self))
        nineNewsPointCollectionView.register(nineNewsPointCollectionViewCell,
                                             forCellWithReuseIdentifier: Constants.NineNewsPointCollectionViewCell)
        /// Collection View Refresh control setup and add target
        nineNewsPointCollectionView.refreshControl = UIRefreshControl()
        nineNewsPointCollectionView.refreshControl?.tintColor = UIColor.getAppearanceColor(.black)
        nineNewsPointCollectionView.refreshControl?.addTarget(self, action: #selector(callPullToRefresh), for: .valueChanged)
    }
    
    /// RefreshControl action
    @objc func callPullToRefresh(){
        nineNewsPointViewModel.requestData()
    }
}

extension NineNewsPointViewController: UICollectionViewDelegate {
    /// Tells the delegate that the item at the specified index path was selected.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard(name: Constants.Main, bundle: nil)
        if let nineNewsPointDetailsViewController = mainStoryboard.instantiateViewController(withIdentifier: Constants.NineNewsPointDetailsViewController) as? NineNewsPointDetailsViewController {
            /// Setting data and navigation for WKWebView
            nineNewsPointDetailsViewController.urlString = nineNewsPointViewModel.assets?[indexPath.row].url
            nineNewsPointDetailsViewController.navigationItem.title = Constants.NewsDetails
            navigationController?.pushViewController(nineNewsPointDetailsViewController, animated: true)
        }
    }
}

// MARK: - UICollectionViewDataSource Functions
extension NineNewsPointViewController: UICollectionViewDataSource {
    /// Asks your data source object for the number of items in the specified section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        nineNewsPointViewModel.numberOfItemsInSection()
    }
    
    /// Asks your data source object for the cell that corresponds to the specified item in the collection view.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        ///Dequeues a reusable cell object using Reuse Identifier
        let cell = nineNewsPointCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.NineNewsPointCollectionViewCell,
                                                      for: indexPath as IndexPath) as!  NineNewsPointCollectionViewCell
        ///Getting Cell Data sourceand settingup
        if let dataSource = nineNewsPointViewModel.cellForItemAtIndexPathForSection(row: indexPath.row) {
            cell.setCellData(dataSource)
        }
        ///Setting Cell Border color and delegate
        cell.layer.borderColor = UIColor.getAppearanceColor(.black).cgColor
        cell.delegate = self
        return cell
    }
    
    /// Called when the iOS interface environment changes.
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        nineNewsPointCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout Function
extension NineNewsPointViewController: UICollectionViewDelegateFlowLayout {
    /// Asks the delegate for the size of the specified item’s cell.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        nineNewsPointViewModel.collectionViewLayoutSize(collectionView)
    }
}

// MARK: - NineNewsPointViewModelDelegate Function
extension NineNewsPointViewController: NineNewsPointViewModelDelegate {
    /// API Success Handler
    /// - Parameter assets: [AssetsListData]
    func success(assets: [AssetsListData]?) {
        DispatchQueue.main.async() {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.hidesWhenStopped = true
            self.nineNewsPointCollectionView.refreshControl?.endRefreshing()
            self.nineNewsPointCollectionView.reloadData()
        }
    }
    
    /// API Failure Handler
    func failure() {
        DispatchQueue.main.async() {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.hidesWhenStopped = true
            self.showAlert(title: Constants.ErrorTitle, message: Constants.ErrorMessage, buttonTitle: Constants.ErrorOk) {
                self.nineNewsPointCollectionView.refreshControl?.endRefreshing()
            }
        }
    }
}

// MARK: - NineNewsPointCollectionViewCellDelegate Function
extension NineNewsPointViewController: NineNewsPointCollectionViewCellDelegate {
    /// Share Button Action handler
    /// - Parameters:
    ///   - headingText: String
    ///   - abstractText: String
    ///   - newsUrl: String
    func buttonAction(headingText:String, abstractText:String, newsUrl:String) {
        let items:[Any] = [headingText + Constants.LineSpace + abstractText + Constants.LineSpace + newsUrl]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        self.present(ac, animated: true)
    }
}
