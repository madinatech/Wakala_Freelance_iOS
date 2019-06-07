

import UIKit
import PopupDialog

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblView: UITableView!
    var wakalaListArray = [WakalaList]()
    
    class func initViewController() -> HomeViewController {
        let vc = HomeViewController.init(nibName: "HomeViewController", bundle: nil)
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.rowHeight = UITableView.automaticDimension
        tblView.estimatedRowHeight = 96
        tblView.tableFooterView = UIView()
    }
    
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
    
            wakalaListArray = WakalaList.getAll()
            tblView.reloadData()
        }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wakalaListArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as? HomeCell
        
        if cell == nil {
            var nib = Bundle.main.loadNibNamed("HomeCell", owner: self, options: nil)
            cell = nib?[0] as? HomeCell
        }
        cell?.selectionStyle = .none
        let wakalList = wakalaListArray[indexPath.row]
        cell?.lblTitle.text = wakalList.name
        cell?.btnView.tag = indexPath.row
        cell?.btnView.addTarget(self, action: #selector(viewClicked(_:)), for: .touchUpInside)
        return cell!
    }
    
    @IBAction func viewClicked(_ sender: UIButton) {
        let wakala : WakalaList = wakalaListArray[sender.tag]
        let vc = FormPopupViewController.initViewController(wakala: wakala)
        let popup = PopupDialog(viewController: vc,
                                buttonAlignment: .horizontal,
                                transitionStyle: .zoomIn,
                                tapGestureDismissal: false,
                                panGestureDismissal: false)
        
        let buttonOne = CancelButton(title: "", height: 0) {
        }
        let buttonTwo = DefaultButton(title: "", height: 0) {
        }
        popup.addButtons([buttonOne, buttonTwo])
        present(popup, animated: true, completion: nil)
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        
        let alert = UIAlertController(title: "Logout", message: "Are you sure want to logout?",         preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: { _ in
        }))
        alert.addAction(UIAlertAction(title: "Yes",
                                      style: .default,
                                      handler: {(_: UIAlertAction!) in
                                        AppDelegate.appDelegateShared().logout()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addClicked(_ sender: Any) {
        let vc = RegistrationViewController.initViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
