import UIKit

class DetailViewController: UICollectionViewController {
    
    private let headerId = "headerId"
    private let mainCellId = "mainCellId"
    private let secondaryCellId = "secondaryCellId"
    private let model: CollectionDataModel
    
    init(model: CollectionDataModel) {
        
        let layout = UICollectionViewCompositionalLayout { (sectionNumber, _) -> NSCollectionLayoutSection? in
            
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            let groupHeight: CGFloat = sectionNumber == 0 ? 470 : 100
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(groupHeight)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            
            if sectionNumber != 0 {
                let kind = UICollectionView.elementKindSectionHeader
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30)), elementKind: kind, alignment: .topLeading)
                ]
            }
            return section
        }
        self.model = model
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(DetailsSectionHeaderCellView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.register(DetailsMainCellView.self, forCellWithReuseIdentifier: mainCellId)
        collectionView.register(DetailsSecondaryCellView.self, forCellWithReuseIdentifier: secondaryCellId)
        
        collectionView.backgroundColor = .systemBackground
        navigationItem.title = "Details"
        setupDiffableDatasource()
    }
    
    enum AppSection {
        case mainSection
        case secondarySection
    }
    
    lazy var diffableDataSource: UICollectionViewDiffableDataSource<AppSection, AnyHashable> = .init(collectionView: self.collectionView) { [unowned self] (collectionView, indexPath, object) -> UICollectionViewCell? in
        
        if let object = object as? DetailedMainCellModel {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.mainCellId, for: indexPath) as! DetailsMainCellView
            cell.model = object
            
            return cell
        } else if let object = object as? DetailsSecondaryCellModel {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.secondaryCellId, for: indexPath) as! DetailsSecondaryCellView
            cell.model = object
            return cell
        }
        
        return nil
    }
    
    private func setupDiffableDatasource() {
        collectionView.dataSource = diffableDataSource
        
        diffableDataSource.supplementaryViewProvider = .some({ [unowned self] (collectionView, kind, indexPath) -> UICollectionReusableView? in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.headerId, for: indexPath) as! DetailsSectionHeaderCellView
            
            let snapshot = self.diffableDataSource.snapshot()
            if let object = self.diffableDataSource.itemIdentifier(for: indexPath) {
                if let section = snapshot.sectionIdentifier(containingItem: object) {
                    if section == .secondarySection {
                        header.label.text = "More Information"
                    }
                }
            }
            return header
        })
        
        var snapshot = diffableDataSource.snapshot()
        snapshot.appendSections([.mainSection])
        snapshot.appendItems([
            DetailedMainCellModel.init(
                id: UUID().uuidString,
                imageSize: model.imageSize,
                type: model.type,
                tags: model.tags,
                previewURL: model.webformatURL
            )
        ], toSection: .mainSection)
        
        snapshot.appendSections([.secondarySection])
        snapshot.appendItems([
            DetailsSecondaryCellModel.init(
                id: UUID().uuidString,
                user: model.user,
                views: model.views,
                downloads: model.downloads,
                collections: model.collections,
                likes: model.likes,
                comments: model.comments
            )
        ], toSection: .secondarySection)
        self.diffableDataSource.apply(snapshot)
    }
}
