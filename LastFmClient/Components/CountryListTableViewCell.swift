import UIKit

class CountryListTableViewCell: UITableViewCell {
    
    private let nameLabel = UILabel()
    private let flagImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(flagImageView)
        
        selectionStyle = .none
        flagImageView.contentMode = .scaleAspectFit
        flagImageView.clipsToBounds = true
    }
    
    private func setConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        flagImageView.translatesAutoresizingMaskIntoConstraints = false
        
        flagImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        flagImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        flagImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        flagImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: flagImageView.trailingAnchor, constant: 10).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
    }
    
    func setProperties(country: Country) {
        
        nameLabel.text = country.name
        if let svg = URL(string: country.flag) {
            flagImageView.downloadedSVG(from: svg)
        }
    }
}
