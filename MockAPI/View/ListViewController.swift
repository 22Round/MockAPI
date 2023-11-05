import UIKit

class ListViewController: UIViewController {
    
    private let cellID: String = "cellID"
    fileprivate let viewModel : ListViewModelProtocol
    fileprivate var data: [CollectionDataModel] = []

    private let collectionViewLayout: UICollectionViewFlowLayout = {
        let layout: UICollectionViewFlowLayout = .init()
        layout.scrollDirection = .vertical
        return layout
    }()
    
    fileprivate lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CollectionCellView.self, forCellWithReuseIdentifier: cellID)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    init(viewModel: ListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .yellow
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.search()
        layoutView(collectionView)
        navigationItem.title = "Main"
    }
    
    private func layoutView(_ source: UIView) {
        view.addSubview(source)
        NSLayoutConstraint.activate([
            source.topAnchor.constraint(equalTo: view.topAnchor),
            source.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            source.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            source.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ListViewController: ViewControllerDelegate {
    func reload(_ data: [CollectionDataModel]) {
        self.data = data
        collectionView.reloadData()
    }
}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
        let model = data[indexPath.item]
        viewModel.goToDetails(model: model)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? CollectionCellView {
            let data = self.data[indexPath.item]
            cell.setupView(model: data)
            return cell
        }
        fatalError("Unable to dequeue subclassed cell")
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        return CGSize(width: screenWidth, height: data[indexPath.item].previewHeight + 5)
    }
}
