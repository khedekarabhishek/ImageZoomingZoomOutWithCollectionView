//
//  ProductZoomingViewController.swift
//  ImageZoomInZoomOut
//
//  Created by Abhishek Khedekar on 30/12/17.
//  Copyright © 2017 Abhishek Khedekar. All rights reserved.
//

import UIKit

class ProductZoomingViewController: UIViewController,UIScrollViewDelegate {
    @IBOutlet weak var collectionViewProduct: UICollectionView!
    @IBOutlet weak var imageviewProduct: UIImageView!
    @IBOutlet weak var imageBackgroundView: UIView!
    @IBOutlet weak var imageScrollview: UIScrollView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var btnDismiss: UIButton!
    
    let arrImages = ["image1.png","image2.png","image3.png","image4.png","image5.png","image6.png"]
    var currentSelectedIndex:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageviewProduct.image =  UIImage(named:arrImages[currentSelectedIndex])
        imageScrollview.minimumZoomScale = 1.0
        imageScrollview.maximumZoomScale = 6.0
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageviewProduct
    }
    
    @IBAction func handleDoubleTap(gestureRecognizer:UIGestureRecognizer) {
        if imageScrollview.zoomScale > imageScrollview.minimumZoomScale {
            imageScrollview.setZoomScale(imageScrollview.minimumZoomScale, animated: true)
        } else {
            imageScrollview.setZoomScale(imageScrollview.maximumZoomScale, animated: true)
        }
    }
    
    @IBAction private func nextButtonClick(_ sender: AnyObject) {
        let visibleItems: NSArray = collectionViewProduct.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        let nextItem: IndexPath = IndexPath(item: currentItem.item + 1, section: 0)
        if nextItem.row < arrImages.count {
            collectionViewProduct.scrollToItem(at: nextItem, at: .left, animated: false)
        }
    }

    @IBAction private func previousButtonClick(_ sender: AnyObject) {
        let visibleItems: NSArray = collectionViewProduct.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        let previousItem: IndexPath = IndexPath(item: currentItem.item - 1, section: 0)
        if previousItem.row > 0 {
            collectionViewProduct.scrollToItem(at: previousItem, at: .right, animated: false)
        }
    }
    
    @IBAction func dismissController(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ProductZoomingViewController : UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.productImageView.image = UIImage(named:arrImages[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        imageviewProduct.image = UIImage(named:arrImages[indexPath.row])
    }
}


extension ProductZoomingViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 4
        let hardCodedPadding:CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        print("item size is : \(itemWidth) and \(itemHeight)")
        print("collectionview size is :\(collectionView.bounds)")
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
}




