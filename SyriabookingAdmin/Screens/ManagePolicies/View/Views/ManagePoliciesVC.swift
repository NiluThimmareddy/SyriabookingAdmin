//
//  ManagePoliciesVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 27/08/26.
//

import UIKit

class ManagePoliciesVC: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollview: UIView!
    @IBOutlet weak var addNewPolicyButton: UIButton!
    @IBOutlet weak var policySearchBar: UISearchBar!
    @IBOutlet weak var policyTableView: UITableView!
    @IBOutlet weak var policyTableVieHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var rowsPerPageLabel: UILabel!
    @IBOutlet weak var rowsPerPageButton: UIButton!
    @IBOutlet weak var totalPagesCountLabel: UILabel!
    @IBOutlet weak var startingPageButton: UIButton!
    @IBOutlet weak var onePageBackwardButton: UIButton!
    @IBOutlet weak var onePageForwardButton: UIButton!
    @IBOutlet weak var lastPageButton: UIButton!
    
    let policyList: [PolicyModel] = [
        PolicyModel(id: "HP00012",title: "ID Policy",description: "All guests are required to present a valid ID or passport at check-in.",isActive: true),
        PolicyModel(id: "HP00013",title: "Couples Policy",description: "All couples are required to present a valid marriage certificate at check-in.",isActive: true),
        PolicyModel(id: "HP00014",title: "Children Policy",description: "Children are welcome according to their age, and an extra bed may be required at an additional cost.",isActive: false),
        PolicyModel(id: "HP00015",title: "Check-in Policy",description: "Check-in time starts from 2:00 PM and guests must provide valid identification.",isActive: true),
        PolicyModel(id: "HP00016",title: "Check-out Policy",description: "Guests are required to check out before 12:00 PM on the departure date.",isActive: true),
        PolicyModel(id: "HP00017",title: "Cancellation Policy",description: "Cancellation charges may apply depending on the booking date and room type.",isActive: true),
        PolicyModel(id: "HP00018",title: "Pet Policy",description: "Pets are not allowed inside the hotel premises.",
            isActive: false),
        PolicyModel(id: "HP00019",title: "Smoking Policy",description: "Smoking is permitted only in designated smoking areas.",isActive: true),
        PolicyModel(id: "HP00020",title: "Payment Policy",description: "Full payment or the required advance payment must be completed according to the booking terms.",isActive: true),
        PolicyModel(id: "HP00021",title: "Extra Bed Policy",description: "Extra beds are available upon request and additional charges may apply.",isActive: true)
    ]
    private var searchText = ""
    private var selectedPolicyIndexPath: IndexPath?
    
    private var rowsPerPage = 10
    private var currentPage = 1
    
    private var filteredPolicy: [PolicyModel] {
        guard !searchText.isEmpty else {
            return policyList
        }
        
        return policyList.filter { policy in
            policy.id.localizedCaseInsensitiveContains(searchText) ||
            policy.title.localizedCaseInsensitiveContains(searchText) ||
            policy.description.localizedCaseInsensitiveContains(searchText) ||
                   String(policy.isActive).localizedCaseInsensitiveContains(searchText)
        }
    }
    private var totalPages: Int {
        return max( 1,Int(ceil(Double(filteredPolicy.count) / Double(rowsPerPage))))
    }
    private var paginatedPolicy: [PolicyModel] {
        let startIndex = (currentPage - 1) * rowsPerPage
        guard startIndex < filteredPolicy.count else {
            return []
        }
        let endIndex = min(
            startIndex + rowsPerPage,
            filteredPolicy.count
        )
        return Array(filteredPolicy[startIndex..<endIndex])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    @IBAction func addNewPolicybuttonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "AddNewPoliciesVC") as! AddNewPoliciesVC
        present(storyboard, animated: true)
    }
    
    @IBAction func startingPageButtonAction(_ sender: Any) {
        currentPage = 1
        updatePagination()
    }
    
    @IBAction func onePageBackwardButtonAction(_ sender: Any) {
        guard currentPage > 1 else { return }
        currentPage -= 1
        updatePagination()
    }
    
    @IBAction func onePageFarwardButtonAction(_ sender: Any) {
        guard currentPage < totalPages else { return }
        currentPage += 1
        updatePagination()
    }
    
    @IBAction func lastPageButtonAction(_ sender: Any) {
        currentPage = totalPages
        updatePagination()
    }

}

extension ManagePoliciesVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paginatedPolicy.count
    }
    
    func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ManagePoliciesTVC",for: indexPath) as! ManagePoliciesTVC
        let policies = paginatedPolicy[indexPath.row]
        cell.configure(with: policies)
        cell.setSelected(indexPath == selectedPolicyIndexPath)
        cell.onCheckmarkTapped = { [weak self, weak tableView] in
            guard let self = self else { return }
            let previousIndexPath = self.selectedPolicyIndexPath
            self.selectedPolicyIndexPath = indexPath
            var reloadPaths = [indexPath]
            if let previousIndexPath,previousIndexPath != indexPath {reloadPaths.append(previousIndexPath)}
            tableView?.reloadRows(at: reloadPaths, with: .none)
            self.openViewPolicyScreen(with: policies)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 53.5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = Bundle.main.loadNibNamed("ManagePoliciesView", owner: self, options: nil)?.first as? ManagePoliciesView else {
            return nil
        }
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
}

extension ManagePoliciesVC {
    func setUpUI() {
        policyTableView.register(UINib(nibName: "ManagePoliciesTVC", bundle: nil), forCellReuseIdentifier: "ManagePoliciesTVC")
        policyTableView.isScrollEnabled = false
        policySearchBar.delegate = self
        setupRowsPerPageMenu()
        updatePagination()
        addNewPolicyButton.tintColor = ThemeManager.shared.currentColor
    }
    
    private func updatePagination() {
        let totalCount = filteredPolicy.count
        let startRecord = totalCount == 0 ? 0 : ((currentPage - 1) * rowsPerPage) + 1
        let endRecord = min(currentPage * rowsPerPage, totalCount)
        totalPagesCountLabel.text = "\(startRecord)-\(endRecord) of \(totalCount)"
        startingPageButton.isEnabled = currentPage > 1
        onePageBackwardButton.isEnabled = currentPage > 1
        onePageForwardButton.isEnabled = currentPage < totalPages
        lastPageButton.isEnabled = currentPage < totalPages
        policyTableView.reloadData()
        DispatchQueue.main.async {
            self.updateTableHeight()
        }
    }
    
    private func setupRowsPerPageMenu() {
        let options = [10, 20, 30, 40, 50]
        let actions = options.map { value in
            UIAction(title: "\(value)") { [weak self] _ in
                guard let self = self else { return }
                self.rowsPerPage = value
                self.currentPage = 1
                self.rowsPerPageButton.setTitle("\(value)", for: .normal)
                self.updatePagination()
            }
        }
        rowsPerPageButton.menu = UIMenu(title: "", children: actions)
        rowsPerPageButton.showsMenuAsPrimaryAction = true
        rowsPerPageButton.setTitle("10", for: .normal)
    }
    
    private func updateTableHeight() {
        let rowHeight: CGFloat = 53.5
        let headerHeight: CGFloat = 45
        let totalHeight = (CGFloat(paginatedPolicy.count) * rowHeight) + headerHeight + 20
        policyTableVieHeightConstraint.constant = totalHeight
        view.layoutIfNeeded()
    }
    
    private func openViewPolicyScreen(with policy: PolicyModel) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewPolicyVC") as! ViewPolicyVC
        vc.policy = policy
        vc.onDismiss = { [weak self] in
            guard let self = self else { return }
            if let indexPath = self.selectedPolicyIndexPath {
                self.selectedPolicyIndexPath = nil
                self.policyTableView.reloadRows(at: [indexPath], with: .none)
            }
        }
        present(vc, animated: true)
    }
}


extension ManagePoliciesVC: UISearchBarDelegate {

    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ) {

        self.searchText = searchText.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        // Always start search results from page 1
        currentPage = 1

        updatePagination()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {

        searchBar.text = ""
        searchText = ""

        currentPage = 1

        updatePagination()

        searchBar.resignFirstResponder()
    }
}
