
import UIKit
import SDWebImage

class PerspectivePhotoHolderViewController: UIViewController, PerspectivePhotoHolder {
  var photoArray: [PerspectivePhoto]!
  @IBOutlet var collectionView: UICollectionView!
  var userDidScrollTo: (Int? -> Void)!

  override func viewDidLoad() {
    super.viewDidLoad()
    self.collectionView.showsHorizontalScrollIndicator = false
    self.collectionView.backgroundColor = UIColor.whiteColor()
    self.automaticallyAdjustsScrollViewInsets = false
  }

  func userDidSelectThumbnailAt(index: Int) {
    self.collectionView.scrollToItemAtIndexPath(NSIndexPath(forItem: index, inSection: 0), atScrollPosition: .None, animated: true)
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
