//
//  ManageImagesVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 01/09/26.
//

import UIKit

class ManageImagesVC: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var uploadImageButton: UIButton!
    @IBOutlet weak var imagesSearchbar: UISearchBar!
    @IBOutlet weak var imagesListTableView: UITableView!
    @IBOutlet weak var imagesListTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var rowsPerPageLabel: UILabel!
    @IBOutlet weak var rowsPerPageButton: UIButton!
    @IBOutlet weak var totalPagesCountLabel: UILabel!
    @IBOutlet weak var startingPageButton: UIButton!
    @IBOutlet weak var onePageBackwardButton: UIButton!
    @IBOutlet weak var onePageForwardButton: UIButton!
    @IBOutlet weak var lastPageButton: UIButton!
    
    let hotelImageList: [HotelImageModel] = [
        HotelImageModel(id: "HI00282",imageName: "ic_hotelImg",displayOrder: 1, description: "",isSelected: true),
        HotelImageModel(id: "HI00283",imageName: "ic_hotelImg",displayOrder: 2, description: "",isSelected: false),
        HotelImageModel(id: "HI00284",imageName: "ic_hotelImg",displayOrder: 3, description: "",isSelected: false),
        HotelImageModel(id: "HI00431",imageName: "ic_hotelImg",displayOrder: 4, description: "",isSelected: false)
    ]
    
    private var searchText = ""
    private var selectedImagesIndexPath: IndexPath?
    
    private var rowsPerPage = 10
    private var currentPage = 1
    
    
    private var filteredImagesList: [HotelImageModel] {
        guard !searchText.isEmpty else {
            return hotelImageList
        }
        return hotelImageList.filter { image in
            image.id.localizedCaseInsensitiveContains(searchText) ||
            image.imageName.localizedCaseInsensitiveContains(searchText) ||
            String(image.displayOrder).localizedCaseInsensitiveContains(searchText)
        }
    }
    
    private var totalPages: Int {
        return max( 1,Int(ceil(Double(filteredImagesList.count) / Double(rowsPerPage))))
    }
    private var paginatedImages: [HotelImageModel] {
        let startIndex = (currentPage - 1) * rowsPerPage
        guard startIndex < filteredImagesList.count else {
            return []
        }
        let endIndex = min(
            startIndex + rowsPerPage,
            filteredImagesList.count
        )
        return Array(filteredImagesList[startIndex..<endIndex])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    @IBAction func uploadImageButtonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "AddNewImageVC") as! AddNewImageVC
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

extension ManageImagesVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paginatedImages.count
    }
    
    func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ManageImagesTVC",for: indexPath) as! ManageImagesTVC
        let images = paginatedImages[indexPath.row]
        cell.configure(_with: images)
        cell.setSelected(indexPath == selectedImagesIndexPath)
        cell.onCheckmarkTapped = { [weak self, weak tableView] in
            guard let self = self else { return }
            let previousIndexPath = self.selectedImagesIndexPath
            self.selectedImagesIndexPath = indexPath
            var reloadPaths = [indexPath]
            if let previousIndexPath,previousIndexPath != indexPath {reloadPaths.append(previousIndexPath)}
            tableView?.reloadRows(at: reloadPaths, with: .none)
            self.openViewImagesScreen(with: images)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = Bundle.main.loadNibNamed("ManageImagesView", owner: self, options: nil)?.first as? ManageImagesView else {
            return nil
        }
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
}

extension ManageImagesVC {
    func setUpUI() {
        uploadImageButton.tintColor = ThemeManager.shared.currentColor
        imagesSearchbar.delegate = self
        imagesListTableView.register(UINib(nibName: "ManageImagesTVC", bundle: nil), forCellReuseIdentifier: "ManageImagesTVC")
        imagesListTableView.isScrollEnabled = false
        
        setupRowsPerPageMenu()
        updatePagination()
    }
    
    private func updatePagination() {
        let totalCount = filteredImagesList.count
        let startRecord = totalCount == 0 ? 0 : ((currentPage - 1) * rowsPerPage) + 1
        let endRecord = min(currentPage * rowsPerPage, totalCount)
        totalPagesCountLabel.text = "\(startRecord)-\(endRecord) of \(totalCount)"
        startingPageButton.isEnabled = currentPage > 1
        onePageBackwardButton.isEnabled = currentPage > 1
        onePageForwardButton.isEnabled = currentPage < totalPages
        lastPageButton.isEnabled = currentPage < totalPages
        imagesListTableView.reloadData()
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
        let rowHeight: CGFloat = 96
        let headerHeight: CGFloat = 45
        let totalHeight = (CGFloat(paginatedImages.count) * rowHeight) + headerHeight + 25
        imagesListTableViewHeightConstraint.constant = totalHeight
        view.layoutIfNeeded()
    }
    
    private func openViewImagesScreen(with image: HotelImageModel) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewImageVC") as! ViewImageVC
        vc.images = image
        vc.onDismiss = { [weak self] in
            guard let self = self else { return }
            if let indexPath = self.selectedImagesIndexPath {
                self.selectedImagesIndexPath = nil
                self.imagesListTableView.reloadRows(at: [indexPath], with: .none)
            }
        }
        present(vc, animated: true)
    }
}

extension ManageImagesVC: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar,textDidChange searchText: String) {
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
