
import UIKit

private let NumberOfColumns = 6
private let HighlightBarHeight: CGFloat = 10

public class PerspectiveThumbnailViewController: UIViewController, PerspectivePhotoViewer {

  // MARK: PublicVar
  public var highlightBar: UIView!

  // MARK: PerspectivePhotoViewer
  var photoArray: [PerspectivePhoto]!
  var startIndex: Int = 0

  // MARK: InternalVar
  var userDidSelectThumbnail: ((Int) -> Void)!

  @IBOutlet var collectionView: UICollectionView!

  override public func viewDidLoad() {
    super.viewDidLoad()
    self.initializeCollectionView()
    self.collectionView.backgroundColor = UIColor.white
  }

  func selectThumbnail(atIndex index: Int) {
    let newIndexPath = IndexPath(item: index, section: 0)
    self.userShouldScroll(to: newIndexPath)
    self.collectionView.scrollToItem(at: newIndexPath, at: UICollectionViewScrollPosition(), animated: true)
  }

  fileprivate func userShouldScroll(to indexPath: IndexPath, animated: Bool = true) {
    CATransaction.setCompletionBlock { () -> Void in
      let cell = self.collectionView(self.collectionView, cellForItemAt: indexPath)
      UIView.animate(withDuration: animated ? 0.4 : 0.0, animations: { () -> Void in
        self.highlightBar.center = CGPoint(x: cell.center.x, y: cell.center.y * 2)
        }, completion: .none)
      self.collectionView.scrollRectToVisible(cell.frame, animated: animated)
    }
  }

  fileprivate func initializeCollectionView() {
    self.collectionView.showsHorizontalScrollIndicator = false
    self.highlightBar = UIView()

    self.highlightBar.backgroundColor = UIColor.red
    self.collectionView.addSubview(self.highlightBar)
    self.collectionView.bringSubview(toFront: self.highlightBar)

    DispatchQueue.main.async {
      self.collectionView.reloadData()
      self.userShouldScroll(to: IndexPath(item: self.startIndex, section: 0), animated: false)
    }
  }
}

extension PerspectiveThumbnailViewController: UICollectionViewDataSource {
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photoArray.count
  }

  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let thumbnailCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PerspectiveThumbnailCell", for: indexPath) as! PerspectiveThumbnailCell
    let perspectivePhoto = photoArray[indexPath.row]

    if let photo = perspectivePhoto.photo {
      thumbnailCell.photoImageView.image = photo
    } else if let photoURL = perspectivePhoto.URL {
      thumbnailCell.photoImageView.sd_setImage(with: photoURL)
    }

    return thumbnailCell
  }
}

extension PerspectiveThumbnailViewController: UICollectionViewDelegateFlowLayout {
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cellWidth = collectionView.widthForCell(withNumberOfColumns: NumberOfColumns)
    self.highlightBar.frame = CGRect(x: 0, y: 0, width: cellWidth, height: HighlightBarHeight)
    return CGSize(width: cellWidth, height: collectionView.bounds.height)
  }
  public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    self.userDidSelectThumbnail(indexPath.row)
    self.userShouldScroll(to: indexPath)
  }

  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    let numberOfColumns = CGFloat(self.photoArray.count)
    let cellWidth = collectionView.widthForCell(withNumberOfColumns: NumberOfColumns)
    var leftInset = (self.collectionView.bounds.size.width - cellWidth * numberOfColumns)/2

    leftInset = leftInset > 0 ? leftInset : 0
    return UIEdgeInsetsMake(0, leftInset, 0, 0)
  }
}
