import UIKit

class SimilarArtistsCollectionViewCell: UICollectionViewCell {
    
    private let artistImageView = UIImageView()
    private let artistNameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        contentView.addSubview(artistImageView)
        contentView.addSubview(artistNameLabel)
        
        layer.cornerRadius = 20
        layer.masksToBounds = true
        backgroundColor = .brown.withAlphaComponent(0.1)
        
        artistImageView.layer.cornerRadius = 20
        artistImageView.layer.masksToBounds = true
    }
    
    private func setConstraints() {
        artistImageView.translatesAutoresizingMaskIntoConstraints = false
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        artistImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        artistImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        artistImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        artistImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        artistImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        artistNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        artistNameLabel.leadingAnchor.constraint(equalTo: artistImageView.trailingAnchor, constant: 5).isActive = true
        artistNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        artistNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    }
    
    func setProperties(artist: SimilarArtist) {
        artistImageView.load(imageUrl: artist.image.first?.imageUrl ?? "")
        artistNameLabel.text = artist.name
    }
}
