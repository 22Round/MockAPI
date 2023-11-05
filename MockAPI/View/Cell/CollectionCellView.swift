import UIKit
import SDWebImage

class CollectionCellView: UICollectionViewCell {
    
    private let label: UILabel = {
        let label: UILabel = .init(text: .empty, font: .boldSystemFont(ofSize: 18))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var imageWidthConstraint: NSLayoutConstraint = .init()
    var imageHeightConstraint: NSLayoutConstraint = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        addSubview(label)
        imageWidthConstraint = imageView.widthAnchor.constraint(equalToConstant: 50)
        imageHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: 50)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageWidthConstraint,
            imageHeightConstraint
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(model: CollectionDataModel) {
        label.text = model.user
        imageView.sd_setImage(with: URL(string: model.previewURL))
        imageWidthConstraint.constant = model.previewWidth
        imageHeightConstraint.constant = model.previewHeight
    }
}
