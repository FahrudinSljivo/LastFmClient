import UIKit

class DetailsScreenViewController: AppViewController<DetailsScreenViewModel> {
    
    private let artistImage = UIImageView()
    private let artistName = UILabel()
    private let similarArtistsTitle = UILabel()
    private let similarArtistsCollectionView: SelfSizingUICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = SelfSizingUICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    private let artistStatsContainerView = UIView()
    private let listenersCountLabel = UILabel()
    private let playcountLabel = UILabel()
    private let summaryContainerView = UIView()
    private let summaryTitle = UILabel()
    private let summaryLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setConstraints()
        configureUI()
        setProperties()
        setLoader()
        viewModel.getArtistDetails(viewModel.artist)
        viewModel.delegate = self
        title = "artistDetailsTitle".localized
    }
    
    private func addSubviews() {
        view.addSubview(artistImage)
        view.addSubview(artistName)
        view.addSubview(similarArtistsTitle)
        view.addSubview(similarArtistsCollectionView)
        view.addSubview(artistStatsContainerView)
        artistStatsContainerView.addSubview(listenersCountLabel)
        artistStatsContainerView.addSubview(playcountLabel)
        view.addSubview(summaryContainerView)
        summaryContainerView.addSubview(summaryTitle)
        summaryContainerView.addSubview(summaryLabel)
    }
    
    private func configureUI() {
        artistName.font = UIFont.boldSystemFont(ofSize: 22)
        artistName.numberOfLines = 0
        similarArtistsCollectionView.delegate = self
        similarArtistsCollectionView.dataSource = self
        similarArtistsCollectionView.register(SimilarArtistsCollectionViewCell.self, forCellWithReuseIdentifier: SimilarArtistsCollectionViewCell.reuseIdentifier)
        similarArtistsTitle.text = "similarArtistsTitle".localized
        similarArtistsTitle.font = UIFont.boldSystemFont(ofSize: 17)
        artistStatsContainerView.backgroundColor = .brown.withAlphaComponent(0.1)
        artistStatsContainerView.layer.cornerRadius = 5
        summaryContainerView.backgroundColor = .brown.withAlphaComponent(0.1)
        summaryContainerView.layer.cornerRadius = 5
        summaryTitle.font = UIFont.boldSystemFont(ofSize: 22)
        summaryTitle.text = "summaryTitle".localized
        summaryLabel.numberOfLines = 0
        summaryLabel.textAlignment = .justified
    }
    
    private func setProperties() {
        artistImage.load(imageUrl: viewModel.artistDetails.artist.image.last?.imageUrl ?? "")
        artistName.text = viewModel.artistDetails.artist.name
        listenersCountLabel.text = "\("listenersLabel".localized): \(viewModel.artistDetails.artist.stats.listeners)"
        playcountLabel.text = "\("playcountLabel".localized): \(viewModel.artistDetails.artist.stats.playcount)"
        summaryLabel.text = viewModel.artistDetails.artist.bio.summary
    }
    
    private func setLoader() {
        view.addSubview(loadingIndicator)
        loadingIndicator.isHidden = false
        loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setConstraints() {
        setImageConstraints()
        setArtistNameConstraints()
        setSimilarArtistsConstraints()
        setStatsContraints()
        setSummaryConstraints()
    }
    
    private func setImageConstraints() {
        artistImage.translatesAutoresizingMaskIntoConstraints = false
        
        artistImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        artistImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        artistImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        artistImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func setArtistNameConstraints() {
        artistName.translatesAutoresizingMaskIntoConstraints = false
        
        artistName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        artistName.leadingAnchor.constraint(equalTo: artistImage.trailingAnchor, constant: 10).isActive = true
        artistName.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -10).isActive = true
    }
    
    private func setSimilarArtistsConstraints() {
        similarArtistsTitle.translatesAutoresizingMaskIntoConstraints = false
        similarArtistsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        similarArtistsTitle.topAnchor.constraint(equalTo: artistImage.bottomAnchor, constant: 10).isActive = true
        similarArtistsTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        
        similarArtistsCollectionView.topAnchor.constraint(equalTo: similarArtistsTitle.bottomAnchor, constant: 10).isActive = true
        similarArtistsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        similarArtistsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        similarArtistsCollectionView.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    private func setStatsContraints() {
        artistStatsContainerView.translatesAutoresizingMaskIntoConstraints = false
        listenersCountLabel.translatesAutoresizingMaskIntoConstraints = false
        playcountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        artistStatsContainerView.topAnchor.constraint(equalTo: similarArtistsCollectionView.bottomAnchor, constant: 10).isActive = true
        artistStatsContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        artistStatsContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        listenersCountLabel.topAnchor.constraint(equalTo: artistStatsContainerView.topAnchor, constant: 5).isActive = true
        listenersCountLabel.leadingAnchor.constraint(equalTo: artistStatsContainerView.leadingAnchor, constant: 5).isActive = true
        
        playcountLabel.topAnchor.constraint(equalTo: listenersCountLabel.bottomAnchor, constant: 5).isActive = true
        playcountLabel.leadingAnchor.constraint(equalTo: artistStatsContainerView.leadingAnchor, constant: 5).isActive = true
        playcountLabel.bottomAnchor.constraint(equalTo: artistStatsContainerView.bottomAnchor, constant: -5).isActive = true
    }
    
    private func setSummaryConstraints() {
        summaryContainerView.translatesAutoresizingMaskIntoConstraints = false
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        summaryTitle.translatesAutoresizingMaskIntoConstraints = false
        
        summaryContainerView.topAnchor.constraint(equalTo: artistStatsContainerView.bottomAnchor, constant: 10).isActive = true
        summaryContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        summaryContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        summaryTitle.topAnchor.constraint(equalTo: summaryContainerView.topAnchor, constant: 5).isActive = true
        summaryTitle.leadingAnchor.constraint(equalTo: summaryContainerView.leadingAnchor, constant: 5).isActive = true
        
        summaryLabel.topAnchor.constraint(equalTo: summaryTitle.bottomAnchor, constant: 10).isActive = true
        summaryLabel.leadingAnchor.constraint(equalTo: summaryContainerView.leadingAnchor, constant: 10).isActive = true
        summaryLabel.trailingAnchor.constraint(lessThanOrEqualTo: summaryContainerView.trailingAnchor, constant: -10).isActive = true
        summaryLabel.bottomAnchor.constraint(equalTo: summaryContainerView.bottomAnchor, constant: -5).isActive = true
    }
}

extension DetailsScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.artistDetails.artist.similar.artist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarArtistsCollectionViewCell.reuseIdentifier, for: indexPath) as? SimilarArtistsCollectionViewCell
        
        let similarArtist = viewModel.artistDetails.artist.similar.artist[indexPath.row]
        cell?.setProperties(artist: similarArtist)
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        loadingIndicator.isHidden = false
        viewModel.getArtistDetails(viewModel.artistDetails.artist.similar.artist[indexPath.row].name)
    }
}

extension DetailsScreenViewController: DetailsScreenViewControllerDelegate {
    
    func refreshData() {
        loadingIndicator.isHidden = true
        similarArtistsCollectionView.reloadData()
        setProperties()
    }
}
