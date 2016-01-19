
import UIKit
import SDWebImage

class PerspectivePhotoHolderViewController: UIViewController, PerspectivePhotoViewer {

  // MARK: PerspectivePhotoViewer
  var photoArray: [PerspectivePhoto]!
  var startIndex: Int = 0

  @IBOutlet var collectionView: UICollectionView!
  var userDidScrollTo: (Int? -> Void)!

  override func viewDidLoad() {
    super.viewDidLoad()
    self.collectionView.showsHorizontalScrollIndicator = false
    self.collectionView.backgroundColor = UIColor.whiteColor()
    self.automaticallyAdjustsScrollViewInsets = false

    dispatch_async(dispatch_get_main_queue()) { () -> Void in
      self.collectionView.reloadData()
      self.userDidSelectThumbnailAt(index: self.startIndex, animated: false)
    }
  }

  func userDidSelectThumbnailAt(index index: Int, animated: Bool = true) {
    let indexPath = NSIndexPath(forItem: index, inSection: 0)

    let cell = self.collectionView(self.collectionView, cellForItemAtIndexPath: indexPath)
    self.collectionView.scrollRectToVisible(cell.frame, animated: animated)
  }

  func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
    var cell: UICollectionViewCell?

    var visibleCells = self.collectionView.visibleCells()
    for var i = 0; i<visibleCells.count;i++ {
      if (!CGRectContainsRect(self.collectionView.bounds, visibleCells[i].frame)) {
        continue
      }
      cell = visibleCells[i]
    }

    if let cell = cell {
      let indexpath = self.collectionView.indexPathForCell(cell)
      userDidScrollTo(indexpath?.row)
    }
  }
}

extension PerspectivePhotoHolderViewController: UICollectionViewDataSource {
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photoArray.count
  }

  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let photoHolderCell = collectionView.dequeueReusableCellWithReuseIdentifier("PerspectivePhotoHolderCell", forIndexPath: indexPath) as! PerspectivePhotoHolderCell
    let perspectivePhoto = photoArray[indexPath.row]

    if let photo = perspectivePhoto.photo {
      photoHolderCell.photoImageView.image = photo
    } else if let photoURL = perspectivePhoto.URL {
      photoHolderCell.photoImageView.sd_setImageWithURL(photoURL)
    }

    return photoHolderCell
  }
}

extension PerspectivePhotoHolderViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    return CGSizeMake(collectionView.widthFor(1), collectionView.minimumHeight())
  }
}
