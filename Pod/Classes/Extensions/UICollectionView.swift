
extension UICollectionView {
  func widthForCell(withNumberOfColumns numberOfColumns: Int) -> CGFloat {
    let collectionViewFlowLayout = self.collectionViewLayout as! UICollectionViewFlowLayout
    let leftInset = collectionViewFlowLayout.sectionInset.left
    let rightInset = collectionViewFlowLayout.sectionInset.right
    let lineSpacing = collectionViewFlowLayout.minimumLineSpacing
    let contentWidth = (bounds.width - leftInset - rightInset - lineSpacing * CGFloat(numberOfColumns - 1)) / CGFloat(numberOfColumns)
    return contentWidth
  }

  func minimumHeight() -> CGFloat {
    let collectionViewFlowLayout = self.collectionViewLayout as! UICollectionViewFlowLayout
    let totalHeight = bounds.height - collectionViewFlowLayout.sectionInset.top - collectionViewFlowLayout.sectionInset.bottom - self.contentInset.bottom - self.contentInset.top

    return totalHeight
  }
}

