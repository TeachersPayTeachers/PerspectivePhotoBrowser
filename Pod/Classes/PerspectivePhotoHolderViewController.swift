
import UIKit
import SDWebImage

public class PerspectivePhotoHolderViewController: UIViewController, PerspectivePhotoViewer {

  // MARK: PerspectivePhotoViewer
  var photoArray: [PerspectivePhoto]!
  var startIndex: Int = 0

  @IBOutlet var collectionView: UICollectionView!
  var userDidScrollTo: ((Int) -> Void)?
  var userDidZoom: (() -> Void)?

  // MARK: Override
  override public func viewDidLoad() {
    super.viewDidLoad()
    self.collectionView.showsHorizontalScrollIndicator = false
    self.collectionView.backgroundColor = UIColor.white
    self.automaticallyAdjustsScrollViewInsets = false
  }

  public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    DispatchQueue.main.async {
      self.collectionView.reloadData()
      self.userDidSelectThumbnail(atIndex: self.startIndex, animated: false)
    }
  }

  // MARK: Internal
  func userDidSelectThumbnail(atIndex index: Int, animated: Bool = true) {
    let indexPath = IndexPath(item: index, section: 0)

    let cell = self.collectionView(self.collectionView, cellForItemAt: indexPath)
    self.collectionView.scrollRectToVisible(cell.frame, animated: animated)
  }
}

// MARK: UIScrollViewDelegate
extension PerspectivePhotoHolderViewController: UIScrollViewDelegate {
  public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    var cell: UICollectionViewCell?

    var visibleCells = self.collectionView.visibleCells
    for i in 0 ..< visibleCells.count {
      if (!self.collectionView.bounds.contains(visibleCells[i].frame)) {
        continue
      }
      cell = visibleCells[i]
    }

    if let row = cell.flatMap({ collectionView.indexPath(for: $0)?.row }) {
      userDidScrollTo?(row)
    }
  }
}

// MARK: UICollectionViewDataSource
extension PerspectivePhotoHolderViewController: UICollectionViewDataSource {
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photoArray.count
  }

  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let photoHolderCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PerspectivePhotoHolderCell", for: indexPath) as! PerspectivePhotoHolderCell
    let perspectivePhoto = photoArray[indexPath.row]

    if let photo = perspectivePhoto.photo {
      photoHolderCell.photoImageView.image = photo
    } else if let photoURL = perspectivePhoto.URL {
      photoHolderCell.photoImageView.sd_setImage(with: photoURL)
    }

    photoHolderCell.didZoom = { [weak self] in
      self?.userDidZoom?()
    }

    return photoHolderCell
  }
}

// MARK: UICollectionViewDelegateFlowLayout
extension PerspectivePhotoHolderViewController: UICollectionViewDelegateFlowLayout {
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.widthForCell(withNumberOfColumns: 1), height: collectionView.minimumHeight())
  }
}
