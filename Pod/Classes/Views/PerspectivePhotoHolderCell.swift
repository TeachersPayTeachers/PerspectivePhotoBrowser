
import UIKit

class PerspectivePhotoHolderCell: UICollectionViewCell {
  @IBOutlet var photoImageView: UIImageView!
  @IBOutlet var scrollView: UIScrollView!

  override func awakeFromNib() {
    super.awakeFromNib()
    self.scrollView.delegate = self
    self.scrollView.minimumZoomScale = 1.0
    self.scrollView.maximumZoomScale = 2.0
  }
}

// MARK: UIScrollViewDelegate
extension PerspectivePhotoHolderCell: UIScrollViewDelegate {
  func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
    return self.photoImageView
  }
}
