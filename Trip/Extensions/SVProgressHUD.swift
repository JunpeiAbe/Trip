import SVProgressHUD

extension SVProgressHUD {
    static func showLoading() {
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show()
    }
    
    static func dismissLoading() {
        SVProgressHUD.dismiss()
    }
}
