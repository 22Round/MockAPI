import UIKit
import SDWebImage

class DetailsMainCellView: UICollectionViewCell {
    var model: DetailedMainCellModel? {
        didSet {
            sizeLabel.text = "Size: \(String(model?.imageSize ?? 0))"
            typeLabel.text = "Type: \(model?.type ?? .empty)"
            tagsLabel.text = "Tags: \(model?.tags ?? .empty)"
            imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imageView.sd_setImage(with: URL(string: model?.previewURL ?? String()))
        }
    }
    
    private let imageView: UIImageView = {
        let imageView: UIImageView = .init()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let sizeLabel = UILabel(text: "Image Size", font: .boldSystemFont(ofSize: 12))
    private let typeLabel = UILabel(text: "Image Type", font: .boldSystemFont(ofSize: 12))
    private let tagsLabel = UILabel(text: "Image Tags", font: .boldSystemFont(ofSize: 12))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tagsLabel.numberOfLines = 3
        let labelsStackView = VerticalStackView(arrangedSubviews: [
            sizeLabel,
            typeLabel,
            tagsLabel,
            ], spacing: 5)
                
        labelsStackView.alignment = .leading
        labelsStackView.distribution = .fill

        addSubview(imageView)
        addSubview(labelsStackView)
        NSLayoutConstraint.activate([
            labelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            labelsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 5),
            labelsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            imageView.topAnchor.constraint(equalTo: labelsStackView.bottomAnchor, constant: 5),
            imageView.heightAnchor.constraint(equalToConstant: 400),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
