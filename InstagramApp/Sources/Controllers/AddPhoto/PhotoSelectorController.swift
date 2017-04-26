//
//  PhotoSelectorController.swift
//  InstagramApp
//
//  Created by André Luís  Campopiano on 26/04/17.
//  Copyright © 2017 André Campopiano. All rights reserved.
//

import UIKit
import Photos

private let reuseIdentifier = "Cell"
private let headerPhotoIdentifier = "headerPhotoIdentifier"

class PhotoSelectorController: UICollectionViewController,UICollectionViewDelegateFlowLayout {

    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        setupNavigationButtons()
        self.collectionView!.register(PhotoSelectorCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView?.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerPhotoIdentifier)
        fetchPhotos()
    }

    override var prefersStatusBarHidden: Bool{ return true }

    //MARK: Loading Photos
    fileprivate func fetchPhotos(){
        let fetchOptions = PHFetchOptions()
        fetchOptions.fetchLimit = 20
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchOptions.sortDescriptors = [sortDescriptor]
        let allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        allPhotos.enumerateObjects({ (asset, count, stop) in
            let imageManager  = PHImageManager.default()
            let targetSize = CGSize(width: 350, height: 350)
            let options = PHImageRequestOptions()
            options.isSynchronous = true
            imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options, resultHandler: { (image, info) in
                if let image = image {
                    self.images.append(image)
                }
                if count == allPhotos.count - 1 {
                    self.collectionView?.reloadData()
                }
            })
        })
    }
    
    //MARK: NavBarButton
    fileprivate func setupNavigationButtons(){
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: NSLocalizedString("title_cancel", comment: ""), style: .plain, target: self, action: #selector(handleCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("title_next", comment: ""), style: .plain, target: self, action: #selector(handleNext))
    }

    func handleNext(){
        
    }
    
    func handleCancel(){ dismiss(animated: true, completion: nil) }
    
    //MARK: HeaderView
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerPhotoIdentifier, for: indexPath)
        header.backgroundColor = .red
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = view.frame.width
        let size = CGSize(width: width, height: width)
        return size
    }
    
    //MARK: UICOllectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 3) / 4
        return CGSize(width: width , height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoSelectorCell
        cell.photoImageView.image = self.images[indexPath.item]
        
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
