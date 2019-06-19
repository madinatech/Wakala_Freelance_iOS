

import UIKit

class FormPopupViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tblView: UITableView!
    var wakala = WakalaList()
    class func initViewController(wakala: WakalaList) -> FormPopupViewController {
        let vc = FormPopupViewController.init(nibName: "FormPopupViewController", bundle: nil)
        vc.wakala = wakala
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.tableFooterView = UIView()
        tblView.rowHeight = UITableView.automaticDimension
        tblView.estimatedRowHeight = 44
    }
    @IBAction func closeCliicked(_ sender: Any) {
          self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "FormViewCell") as? FormViewCell
        if cell == nil {
            var nib = Bundle.main.loadNibNamed("FormViewCell", owner: self, options: nil)
            cell = nib?[0] as? FormViewCell
        }
        
        cell?.selectionStyle = .none
        
        if(indexPath.row == 0){
            cell?.lblTitle.text = "Wakala name"
            cell?.lblValue.text = wakala.name
        } else if(indexPath.row == 1){
            cell?.lblTitle.text = "Mobile number"
            cell?.lblValue.text = wakala.mobile_number
        } else if(indexPath.row == 2){
            cell?.lblTitle.text = "Email ID"
            cell?.lblValue.text = wakala.email
        } else if(indexPath.row == 3){
            cell?.lblTitle.text = "Bank name"
            cell?.lblValue.text = wakala.bank_name
        } else if(indexPath.row == 4){
            cell?.lblTitle.text = "Beneficiary name"
            cell?.lblValue.text = wakala.beneficiary_name
        } else if(indexPath.row == 5){
            cell?.lblTitle.text = "Bank account number"
            cell?.lblValue.text = wakala.bank_account_number
        } else if(indexPath.row == 6){
            cell?.lblTitle.text = "Contact person"
            cell?.lblValue.text = wakala.contact_person
        } else if(indexPath.row == 7){
            cell?.lblTitle.text = "Contact number"
            cell?.lblValue.text = wakala.contact_number
        } else if(indexPath.row == 8){
            cell?.lblTitle.text = "City"
            let city : City = City.getById(wakala.city ?? "")
            cell?.lblValue.text = city.city_name//wakala.city
        } else if(indexPath.row == 9){
            cell?.lblTitle.text = "Street address"
            cell?.lblValue.text = wakala.location
        }

        return cell!
    }
    
}
