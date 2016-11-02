
extension UICollectionView {
  func widthForCell(withNumberOfColumns numberOfColumns: Int) -> CGFloat {
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

