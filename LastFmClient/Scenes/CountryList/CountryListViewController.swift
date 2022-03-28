import UIKit

class CountryListViewController: AppViewController<CountryListViewModel> {
    
    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupSearchController()
        setupTableView()
        setLoader()
        viewModel.getCountries()
        
        title = "countryListTitle".localized
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.restoreCurrentDataSource()
        searchController.isActive = false
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        navigationItem.searchController = searchController
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CountryListTableViewCell.self, forCellReuseIdentifier: CountryListTableViewCell.reuseIdentifier)
        
        view.addSubview(tableView)
        tableView.rowHeight = UITableView.automaticDimension
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
        loadingIndicator
            .centerYAnchor
            .constraint(equalTo: view.centerYAnchor).isActive = true
        loadingIndicator
            .centerXAnchor
            .constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

extension CountryListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryListTableViewCell.reuseIdentifier, for: indexPath) as? CountryListTableViewCell
        
        let country = viewModel.filteredCountries[indexPath.row]
        cell?.setProperties(country: country)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.goToTopArtistsByCountry(country: viewModel.filteredCountries[indexPath.row].name)
    }
}

extension CountryListViewController: CountryListViewControllerDelegate {
    
    func reloadTableView() {
        if !viewModel.isLoading {
            loadingIndicator.isHidden = true
            tableView.isHidden = false
        }
        self.tableView.reloadData()
    }
}

extension CountryListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            viewModel.filterCurrentDataSource(searchTerm: searchText)
        }
    }
}

extension CountryListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            viewModel.filterCurrentDataSource(searchTerm: searchText)
        }
        
        searchController.isActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, !searchText.isEmpty {
            viewModel.restoreCurrentDataSource()
        }
        
        searchController.isActive = false
    }
}
