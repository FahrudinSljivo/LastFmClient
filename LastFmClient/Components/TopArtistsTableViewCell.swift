import UIKit

class TopArtistsTableViewCell: UITableViewCell {
    
    private let artistImageView = UIImageView()
    private let nameLabel = UILabel()
    private let listenersLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        contentView.addSubview(artistImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(listenersLabel)
        
        selectionStyle = .none
        artistImageView.contentMode = .scaleAspectFit
        artistImageView.clipsToBounds = true
        nameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        listenersLabel.font = UIFont.systemFont(ofSize: 15)
    }
    
    private func setConstraints() {
        artistImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        listenersLabel.translatesAutoresizingMaskIntoConstraints = false
        
        artistImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        artistImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        artistImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: artistImageView.trailingAnchor, constant: 10).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        listenersLabel.leadingAnchor.constraint(equalTo: artistImageView.trailingAnchor, constant: 10).isActive = true
        listenersLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
    }
    
    func setProperties(artist: TopArtist) {
        
        nameLabel.text = artist.name
        listenersLabel.text = "\("listenersLabel".localized): \(artist.listeners)"
        artistImageView.load(imageUrl: artist.image[1].imageUrl)
    }
}
