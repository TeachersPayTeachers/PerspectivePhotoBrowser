//
//  PerspectiveThumbnailViewController.swift
//  Pods
//
//  Created by Amol Chaudhari on 1/6/16.
//
//

import UIKit

class PerspectiveThumbnailViewController: UIViewController, PerspectivePhotoHolder {
  var photoArray: [PerspectivePhoto]!
  @IBOutlet var collectionView: UICollectionView!
  var highlightBar: UIView!

  var userDidSelectThumbnail: (Int -> Void)!

  override func viewDidLoad() {
    super.viewDidLoad()
    self.initializeCollectionView()
    self.collectionView.backgroundColor = UIColor.whiteColor()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
  }

  func selectThumbnailAt(index index: Int) {
    let newIndexPath = NSIndexPath(forItem: index, inSection: 0)
    self.userShouldScrollTo(newIndexPath)
    self.collectionView.scrollToItemAtIndexPath(newIndexPath, atScrollPosition: .None, animated: true)
  }

  private func userShouldScrollTo(indexPath: NSIndexPath) {
    CATransaction.setCompletionBlock { () -> Void in
      let cell = self.collectionView(self.collectionView, cellForItemAtIndexPath: indexPath)
      UIView.animateWithDuration(0.4, animations: { () -> Void in
        self.highlightBar.center = CGPoint(x: cell.center.x, y: cell.center.y * 2)
        }, completion: .None)
    }
  }

  private func initializeCollectionView() {
    self.collectionView.showsHorizontalScrollIndicator = false
    let cellSize = self.collectionView(self.collectionView, layout: self.collectionView.collectionViewLayout, sizeForItemAtIndexPath: NSIndexPath(forItem: 0, inSection: 0))

    self.highlightBar = UIView(frame:CGRectMake(0,cellSize.height,cellSize.width,10))
    self.highlightBar.backgroundColor = UIColor.redColor()
    self.collectionView.addSubview(self.highlightBar)
    self.collectionView.bringSubviewToFront(self.highlightBar)

    dispatch_async(dispatch_get_main_queue()) { () -> Void in
      self.collectionView.reloadData()
      self.userShouldScrollTo(NSIndexPath(forItem: 0, inSection: 0))
    }
  }
}

extension PerspectiveThumbnailViewController: UICollectionViewDataSource {
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photoArray.count
  }

  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let thumbnailCell = collectionView.dequeueReusableCellWithReuseIdentifier("PerspectiveThumbnailCell", forIndexPath: indexPath) as! PerspectiveThumbnailCell
    let perspectivePhoto = photoArray[indexPath.row]

    if let photo = perspectivePhoto.photo {
      thumbnailCell.photoImageView.image = photo
    } else if let photoURL = perspectivePhoto.URL {
      thumbnailCell.photoImageView.sd_setImageWithURL(photoURL)
    }

    self.highlightBar.bounds = CGRectMake(0, 0, thumbnailCell.frame.width, 10)
    return thumbnailCell
  }
}

extension PerspectiveThumbnailViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    return CGSizeMake(collectionView.widthFor(6), collectionView.bounds.height)
  }
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    self.userDidSelectThumbnail(indexPath.row)
    self.userShouldScrollTo(indexPath)
  }
}

extension UICollectionView {
  func widthFor(numberOfColumns: CGFloat) -> CGFloat {
    let viewWidth = self.bounds.width ?? 0
    let collectionViewFlowLayout = self.collectionViewLayout as! UICollectionViewFlowLayout
    let leftInset = collectionViewFlowLayout.sectionInset.left
    let rightInset = collectionViewFlowLayout.sectionInset.right
    let lineSpacing = collectionViewFlowLayout.minimumLineSpacing
    let contentWidth = (viewWidth - leftInset - rightInset - lineSpacing * CGFloat(numberOfColumns - 1)) / CGFloat(numberOfColumns)
    return contentWidth
  }

  func minimumHeight() -> CGFloat {
    let viewHeight = self.bounds.height ?? 0

    let collectionViewFlowLayout = self.collectionViewLayout as! UICollectionViewFlowLayout
    let totalHeight = viewHeight - collectionViewFlowLayout.sectionInset.top - collectionViewFlowLayout.sectionInset.bottom - self.contentInset.bottom - self.contentInset.top
    
    return totalHeight
  }
}

