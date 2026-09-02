//
//  ViewImageVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 02/09/26.
//

import UIKit

class ViewImageVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var viewIconImgView: UIImageView!
    @IBOutlet weak var viewImageTitleLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var idTF: UITextField!
    @IBOutlet weak var uploadImageLabel: UILabel!
    @IBOutlet weak var onlyImageFilesButton: UIButton!
    @IBOutlet weak var uplodedImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionTF: UITextField!
    @IBOutlet weak var displayOrderLabel: UILabel!
    @IBOutlet weak var displayOrderTF: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var uploadImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    
    var images: HotelImageModel?
    var onDismiss: (() -> Void)?
    
    private var isEditingImages = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    @IBAction func onlyImageFilesButtonAction(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true)
    }
    
    @IBAction func cancelbuttonAction(_ sender: Any) {
        onDismiss?()
        dismiss(animated: true)
    }
    
    @IBAction func editButtonAction(_ sender: Any) {
        if isEditingImages {
            saveImage()
        } else {
            setupEditMode()
        }
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
    }
}


extension ViewImageVC {
    func setUpUI() {
        viewIconImgView.tintColor = ThemeManager.shared.currentColor
        setupViewMode()
        configureImagesData()
    }
    
    private func configureImagesData() {
        guard let image = images else {
            return
        }
        idTF.text = image.id
        descriptionTF.text = image.description
        displayOrderTF.text = "\(image.displayOrder)"
        uplodedImageView.image = UIImage(named: image.imageName)
    }
    
    private func setupViewMode() {
        isEditingImages = false
        idTF.isUserInteractionEnabled = false
        displayOrderTF.isUserInteractionEnabled = false
        descriptionTF.isUserInteractionEnabled = false
        deleteButton.isHidden = false
        editButton.isHidden = false
        editButton.setTitle("Edit", for: .normal)
        uploadImageViewHeightConstraint.constant = 0
        viewIconImgView.image = UIImage(systemName: "eye")
        viewImageTitleLabel.text = "View Image"
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func setupEditMode() {
        isEditingImages = true
        idTF.isUserInteractionEnabled = true
        displayOrderTF.isUserInteractionEnabled = true
        descriptionTF.isUserInteractionEnabled = true
        deleteButton.isHidden = true
        cancelButton.tintColor = UIColor(hex: "DD2525")
        editButton.setTitle("Save", for: .normal)
        uploadImageViewHeightConstraint.constant = 100
        viewIconImgView.image = UIImage(named: "ic_edit")
        viewImageTitleLabel.text = "Update Image"
        onlyImageFilesButton.backgroundColor = ThemeManager.shared.currentColor
        imageViewTopConstraint.constant = -20
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func saveImage() {
        let id = idTF.text ?? ""
        let description = descriptionTF.text ?? ""
        let displayOrder = Int(displayOrderTF.text ?? "") ?? 0
        let imageName = images?.imageName ?? ""
        cancelButton.tintColor = UIColor(hex: "252525")
        imageViewTopConstraint.constant = 0
        images = HotelImageModel(
            id: id,
            imageName: imageName,
            displayOrder: displayOrder,
            description: description,
            isSelected: true
        )

        setupViewMode()
    }
}

extension ViewImageVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            uplodedImageView.image = selectedImage
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
