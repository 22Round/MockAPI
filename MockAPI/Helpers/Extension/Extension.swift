import UIKit

extension UIButton {
    convenience init(title: String) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UILabel {
    convenience init(text: String, font: UIFont, numberOfLines: Int = 1) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UITextField {
    convenience init(placeholder: String, font: UIFont = .systemFont(ofSize: 12), leftPadding: CGFloat = 11) {
        self.init(frame: .zero)
        self.font = font
        self.placeholder = placeholder
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.setLeftPadding(leftPadding)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setLeftPadding(_ amount: CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPadding(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension UIViewController {
    func setViewSize(targetView: UIView, width: CGFloat, height: CGFloat) {
        targetView.widthAnchor.constraint(equalToConstant: width).isActive = true
        targetView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
}

extension String {
    static var empty: String { String() }
    var isValidEmail: Bool {
        let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}" +
            "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
            "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
            "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
            "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
            "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
            "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format: "SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        let passwordRegEx = ".{6,12}"
        
        let passwordTest = NSPredicate(format: "SELF MATCHES[c] %@", passwordRegEx)
        return passwordTest.evaluate(with: self)
    }
    
    var isValidAge: Bool {
        guard let int: Int = Int(self) else { return false }
        let ageRange = 18...99
        return ageRange.contains(int)
    }
}
