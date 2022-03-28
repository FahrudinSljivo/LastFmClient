import UIKit

class AppViewController<TViewModel: AppViewModel>: UIViewController {
    
    var viewModel: TViewModel!
    let loadingIndicator: ActivityIndicatorContainer = {
        let loader = ActivityIndicatorContainer(frame: .zero)
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.appViewModelInfoViewDelegate = self
    }
}

extension AppViewController: AppViewControllerDelegate {
    
    func handleInfoView(statusCode: Int, text: String) {
        let errorAlert = UIAlertController(title: "\("errorLabel".localized) \(statusCode)", message: text, preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "okLabel".localized, style: .default))
        self.present(errorAlert, animated: true, completion: nil)
    }
}
