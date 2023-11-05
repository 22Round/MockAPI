import UIKit

class DetailsSectionHeaderCellView: UICollectionReusableView {
    
    let label = UILabel(text: "Section Title", font: .boldSystemFont(ofSize: 20))
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        backgroundColor = .lightGray
        addSubview(label)
        
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
