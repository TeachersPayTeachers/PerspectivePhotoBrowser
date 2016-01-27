
import UIKit

private let MinimumZoomScale: CGFloat = 1.0
private let MaximumZoomScale: CGFloat = 2.0

class PerspectivePhotoHolderCell: UICollectionViewCell {
  @IBOutlet var photoImageView: UIImageView!
  @IBOutlet var scrollView: UIScrollView!

  override func awakeFromNib() {
    super.awakeFromNib()
    self.scrollView.delegate = self
    self.scrollView.minimumZoomScale = MinimumZoomScale
    self.scrollView.maximumZoomScale = 2.0

    self.setupDoubleTapGesture()
  }

  private func setupDoubleTapGesture() {
    let doubleTap = UITapGestureRecognizer(target: self, action: "userDidDoubleTap:")
    doubleTap.numberOfTapsRequired = 2
    self.scrollView.addGestureRecognizer(doubleTap)
  }

  // MARK: Actions
  func userDidDoubleTap(gesture: UITapGestureRecognizer) {
    if self.scrollView.zoomScale == MinimumZoomScale {
      self.scrollView.zoomToPoint(gesture.locationInView(self.scrollView), withScale: MaximumZoomScale, animated: true)
      return
    }
    self.scrollView.zoomToPoint(gesture.locationInView(self.scrollView), withScale: MinimumZoomScale, animated: true)
  }
}

// MARK: UIScrollViewDelegate
extension PerspectivePhotoHolderCell: UIScrollViewDelegate {
  func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
    return self.photoImageView
  }
}
