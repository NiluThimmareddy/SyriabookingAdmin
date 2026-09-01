//
//  ManageReviewsVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 18/08/26.
//

import UIKit

class ManageReviewsVC: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var addNewReviewsButton: UIButton!
    @IBOutlet weak var reviewsSearchBar: UISearchBar!
    @IBOutlet weak var reviewsListTableView: UITableView!
    @IBOutlet weak var reviewsListTableViewHeightConstraint: NSLayoutConstraint!
    
    
    let reviews: [ReviewModel] = [
        ReviewModel(id: "HR00012",reviewer: "Ashif",rating: 4,review: "Excellent Stay",created: "7/29/2025 3:10:49 PM"),
        ReviewModel(id: "HR00018",reviewer: "Jayanth",rating: 4,review: "Wonderful Stay",created: "9/4/2025 9:52:34 AM"),
        ReviewModel(id: "HR00019",reviewer: "Rajesh",rating: 4,review: "Comfortable stay",created: "9/4/2025 12:43:06 PM"),
        ReviewModel(id: "HR00021",reviewer: "Nilu",rating: 5,review: "Excellent",created: "9/7/2025 7:04:32 PM"),
        ReviewModel(id: "HR00023",reviewer: "Abhinithi",rating: 5,review: "Excellent",created: "9/7/2025 7:14:05 PM"),
        ReviewModel(id: "HR00026",reviewer: "Muthu",rating: 4,review: "Good",created: "9/12/2025 1:10:11 PM"),
        ReviewModel(id: "HR00028",reviewer: "Ragav",rating: 4,review: "Great Stay!",created: "9/12/2025 1:38:11 PM"),
        ReviewModel(id: "HR00078",reviewer: "Touqueir",rating: 4,review: "My review",created: "10/17/2025 3:41:33 PM"),
        ReviewModel(id: "HR00080",reviewer: "Ram kumar",rating: 5,review: "Good",created: "11/11/2025 6:58:24 AM")
    ]
    
    var selectedIndex = 0
    private var searchText = ""
    private var selectedBookingIndexPath: IndexPath?
    
    private var filteredReviews: [ReviewModel] {
        guard !searchText.isEmpty else{
            return reviews
        }
        
        return reviews.filter { review in
            review.id.localizedCaseInsensitiveContains(searchText) ||
            review.reviewer.localizedCaseInsensitiveContains(searchText) ||
            String(review.rating).localizedCaseInsensitiveContains(searchText) ||
            review.review.localizedCaseInsensitiveContains(searchText) ||
            review.created.localizedCaseInsensitiveContains(searchText)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addNewReviewsButton.tintColor = ThemeManager.shared.currentColor
        reviewsSearchBar.delegate = self
        reviewsListTableView.register(UINib(nibName: "ManageReviewsTVC", bundle: nil), forCellReuseIdentifier: "ManageReviewsTVC")
        reviewsListTableView.isScrollEnabled = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateTableViewHeight()
    }
    
    private func updateTableViewHeight() {
        
        reviewsListTableView.layoutIfNeeded()
        reviewsListTableViewHeightConstraint.constant = reviewsListTableView.contentSize.height
    }
    
    @IBAction func addNewReviewsButtonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "AddReviewVC") as! AddReviewVC
        present(storyboard, animated: true)
    }
    
}

extension ManageReviewsVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredReviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ManageReviewsTVC") as! ManageReviewsTVC
        let review = filteredReviews[indexPath.row]
        cell.configure(_with: review)
        cell.setSelected(indexPath == selectedBookingIndexPath)
        cell.onCheckmarkTapped = { [weak self, weak tableView] in
            guard let self = self else { return }
            let previousIndexPath = self.selectedBookingIndexPath
            self.selectedBookingIndexPath = indexPath
            var reloadPaths = [indexPath]
            if let previousIndexPath,previousIndexPath != indexPath {reloadPaths.append(previousIndexPath)}
            tableView?.reloadRows(at: reloadPaths, with: .none)
            self.openViewBookingScreen(with: review)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = Bundle.main.loadNibNamed("ManageReviewsView", owner: self, options: nil)?.first as? ManageReviewsView else {
            return nil
        }
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    private func openViewBookingScreen(with review: ReviewModel) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewReviewVC") as! ViewReviewVC
        vc.review = review
        vc.onDismiss = { [weak self] in
            guard let self = self else { return }
            if let indexPath = self.selectedBookingIndexPath {
                self.selectedBookingIndexPath = nil
                self.reviewsListTableView.reloadRows(at: [indexPath], with: .none)
            }
        }
        present(vc, animated: true)
    }
}

extension ManageReviewsVC : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        reviewsListTableView.reloadData()
        
        DispatchQueue.main.async{
            self.updateTableViewHeight()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchText = ""
        
        reviewsListTableView.reloadData()
        
        DispatchQueue.main.async{
            self.updateTableViewHeight()
        }
        
        searchBar.resignFirstResponder()
    }
}
