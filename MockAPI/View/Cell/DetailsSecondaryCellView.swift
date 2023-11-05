import UIKit

class DetailsSecondaryCellView: UICollectionViewCell {
    var model: DetailsSecondaryCellModel? {
        didSet {
            userLabel.text = "User: \(model?.user ?? .empty)"
            viewsLabel.text = "Views: \(String(model?.views ?? 0))"
            downloadsLabel.text = "Downloads: \(String(model?.downloads ?? 0))"
            collectionsLabel.text = "Collection: \(String(model?.collections ?? 0))"
            likesLabel.text = "Likes: \(String(model?.likes ?? 0))"
            commentsLabel.text = "Comments: \(String(model?.comments ?? 0))"
        }
    }
    
    let userLabel = UILabel(text: "User", font: .systemFont(ofSize: 13))
    let viewsLabel = UILabel(text: "Views", font: .systemFont(ofSize: 13))
    let downloadsLabel = UILabel(text: "Downloads", font: .systemFont(ofSize: 13))
    let collectionsLabel = UILabel(text: "Collection", font: .systemFont(ofSize: 13))
    let likesLabel = UILabel(text: "Likes", font: .systemFont(ofSize: 13))
    let commentsLabel = UILabel(text: "Comments", font: .systemFont(ofSize: 13))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let labelsStackView = VerticalStackView(arrangedSubviews: [
            userLabel,
            viewsLabel,
            downloadsLabel,
            collectionsLabel,
            likesLabel,
            commentsLabel
            ], spacing: 5)
        
        addSubview(labelsStackView)
        NSLayoutConstraint.activate([
            labelsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            labelsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 5),
            labelsStackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            labelsStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
