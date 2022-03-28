import UIKit

class TopArtistsByCountryViewController: AppViewController<TopArtistsByCountryViewModel> {
    
    private let tableView = UITableView()
    
    private lazy var spinnerFooter: UIView = {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100))
        let spinner = UIActivityIndicatorView()
        footerView.addSubview(spinner)
        spinner.startAnimating()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: footerView.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true

        return footerView
    }()
    
    private lazy var noArtistsMessageView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width,
                                        height: UIScreen.main.bounds.height - (navigationController?.navigationBar.frame.size.height)! - 100))
        let label = UILabel()
        label.text = "noArtistsMessageLabel".localized
        label.numberOfLines = 0
        
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        setupTableView()
        setLoader()
        viewModel.getTopArtists()
        title = "topArtistsTitle".localized
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TopArtistsTableViewCell.self, forCellReuseIdentifier: TopArtistsTableViewCell.reuseIdentifier)
        tableView.tableFooterView = viewModel.isPaginating ? spinnerFooter : UIView()
        
        view.addSubview(tableView)
        tableView.rowHeight = 100
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func setLoader() {
        view.addSubview(loadingIndicator)
        loadingIndicator.isHidden = false
        tableView.isHidden = true
        loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

extension TopArtistsByCountryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.topArtists.topArtists.artist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TopArtistsTableViewCell.reuseIdentifier, for: indexPath) as? TopArtistsTableViewCell
        
        let artist = viewModel.topArtists.topArtists.artist[indexPath.row]
        cell?.setProperties(artist: artist)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.goToDetailsScreen(artist: viewModel.topArtists.topArtists.artist[indexPath.row].name)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let positionFormatted = scrollView.contentOffset.y
        let heightFormatted = tableView.contentSize.height - scrollView.frame.size.height
        if positionFormatted >= heightFormatted &&
            viewModel.currentPage < Int(viewModel.topArtists.topArtists.meta.totalPages) ?? 2 &&
            !viewModel.isPaginating {
            tableView.tableFooterView = spinnerFooter
            viewModel.getTopArtists()
        }
    }
}

extension TopArtistsByCountryViewController: TopArtistsByCountryViewControllerDelegate {
    
    func reloadTableView() {
        loadingIndicator.isHidden = true
        tableView.isHidden = false
        tableView.reloadData()
        tableView.tableFooterView = viewModel.topArtists.topArtists.artist.count == 0 ? noArtistsMessageView : UIView()
    }
}
