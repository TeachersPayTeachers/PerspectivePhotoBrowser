
import UIKit

private let NumberOfColumns: CGFloat = 6
private let HighlightBarHeight: CGFloat = 10

public class PerspectiveThumbnailViewController: UIViewController, PerspectivePhotoViewer {

  // MARK: PublicVar
  public var highlightBar: UIView!

  // MARK: PerspectivePhotoViewer
  var photoArray: [PerspectivePhoto]!
  var startIndex: Int = 0

  // MARK: InternalVar
  var userDidSelectThumbnail: (Int -> Void)!

  @IBOutlet var collectionView: UICollectionView!

  override public func viewDidLoad() {
    super.viewDidLoad()
    self.initializeCollectionView()
    self.collectionView.backgroundColor = UIColor.whiteColor()
  }

  func selectThumbnailAt(index index: Int) {
    let newIndexPath = NSIndexPath(forItem: index, inSection: 0)
    self.userShouldScrollTo(newIndexPath)
    self.collectionView.scrollToItemAtIndexPath(newIndexPath, atScrollPosition: .None, animated: true)
  }

  private func userShouldScrollTo(indexPath: NSIndexPath, animated: Bool = true) {
    CATransaction.setCompletionBlock { () -> Void in
      let cell = self.collectionView(self.collectionView, cellForItemAtIndexPath: indexPath)
      UIView.animateWithDuration(animated ? 0.4 : 0.0, animations: { () -> Void in
        self.highlightBar.center = CGPoint(x: cell.center.x, y: cell.center.y * 2)
        }, completion: .None)
      self.collectionView.scrollRectToVisible(cell.frame, animated: animated)
    }
  }

  private func initializeCollectionView() {
    self.collectionView.showsHorizontalScrollIndicator = false
    self.highlightBar = UIView()

    self.highlightBar.backgroundColor = UIColor.redColor()
    self.collectionView.addSubview(self.highlightBar)
    self.collectionView.bringSubviewToFront(self.highlightBar)

    dispatch_async(dispatch_get_main_queue()) { () -> Void in
      self.collectionView.reloadData()
      self.userShouldScrollTo(NSIndexPath(forItem: self.startIndex, inSection: 0), animated: false)
    }
  }
}

extension PerspectiveThumbnailViewController: UICollectionViewDataSource {
  public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photoArray.count
  }

  public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let thumbnailCell = collectionView.dequeueReusableCellWithReuseIdentifier("PerspectiveThumbnailCell", forIndexPath: indexPath) as! PerspectiveThumbnailCell
    let perspectivePhoto = photoArray[indexPath.row]

    if let photo = perspectivePhoto.photo {
      thumbnailCell.photoImageView.image = photo
    } else if let photoURL = perspectivePhoto.URL {
      thumbnailCell.photoImageView.sd_setImageWithURL(photoURL)
    }

    return thumbnailCell
  }
}

extension PerspectiveThumbnailViewController: UICollectionViewDelegateFlowLayout {
  public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    let cellWidth = collectionView.widthForCellWith(NumberOfColumns)
    self.highlightBar.frame = CGRectMake(0, 0, cellWidth, HighlightBarHeight)
    return CGSizeMake(cellWidth, collectionView.bounds.height)
  }
  public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    self.userDidSelectThumbnail(indexPath.row)
    self.userShouldScrollTo(indexPath)
  }

  public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
    let numberOfColumns = CGFloat(self.photoArray.count)
    let cellWidth = collectionView.widthForCellWith(NumberOfColumns)
    var leftInset = (self.collectionView.bounds.size.width - cellWidth * numberOfColumns)/2

    leftInset = leftInset > 0 ? leftInset : 0
    return UIEdgeInsetsMake(0, leftInset, 0, 0)
  }
}
