
import UIKit

private let MinimumZoomScale: CGFloat = 1.0
private let MaximumZoomScale: CGFloat = 2.0

class PerspectivePhotoHolderCell: UICollectionViewCell {
  @IBOutlet var photoImageView: UIImageView!
  @IBOutlet var scrollView: UIScrollView!

  var didZoom: (() -> Void)?

  override func awakeFromNib() {
    super.awakeFromNib()
    self.scrollView.delegate = self
    self.scrollView.minimumZoomScale = MinimumZoomScale
    self.scrollView.maximumZoomScale = 2.0

    self.setupDoubleTapGesture()
  }

  private func setupDoubleTapGesture() {
    let doubleTap = UITapGestureRecognizer(target: self, action: #selector(userDidDoubleTap(_:)))
    doubleTap.numberOfTapsRequired = 2
    self.scrollView.addGestureRecognizer(doubleTap)
  }

  // MARK: Actions
  @objc func userDidDoubleTap(_ gesture: UITapGestureRecognizer) {
    if self.scrollView.zoomScale == MinimumZoomScale {
      self.scrollView.zoom(to: gesture.location(in: self.scrollView), withScale: MaximumZoomScale, animated: true)
      return
    }
    self.scrollView.zoom(to: gesture.location(in: self.scrollView), withScale: MinimumZoomScale, animated: true)
  }
}

// MARK: UIScrollViewDelegate
extension PerspectivePhotoHolderCell: UIScrollViewDelegate {
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return self.photoImageView
  }

  func scrollViewDidZoom(_ scrollView: UIScrollView) {
    didZoom?()
  }
}
