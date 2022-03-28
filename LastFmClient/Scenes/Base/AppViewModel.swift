import Foundation

protocol AppViewControllerDelegate: AnyObject {
    func handleInfoView(statusCode: Int, text: String)
}

class AppViewModel {
    
    weak var appViewModelInfoViewDelegate: AppViewControllerDelegate?
    var isLoading = true
    
    func handleApiError(_ error: ApiError) {
        
        if let errorMessage = error.errorBody?.message {
            appViewModelInfoViewDelegate?.handleInfoView(statusCode: error.statusCodeValue, text: errorMessage)
        } else {
            if error.statusCodeValue == 999 {
                appViewModelInfoViewDelegate?.handleInfoView(statusCode: error.statusCodeValue, text: "offlineError".localized)
            } else {
                appViewModelInfoViewDelegate?.handleInfoView(statusCode: error.statusCodeValue, text: "genericErrorLabel".localized)
            }
        }
    }
}
