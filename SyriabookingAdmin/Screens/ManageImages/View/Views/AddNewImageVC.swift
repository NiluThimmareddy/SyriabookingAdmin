//
//  AddNewImageVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 01/09/26.
//

import UIKit

class AddNewImageVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var insideScrollView: UIView!
    @IBOutlet weak var addNewImageLabel: UILabel!
    @IBOutlet weak var uploadImageLabel: UILabel!
    @IBOutlet weak var onlyImageFileButton: UIButton!
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var hotelImgView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionTF: UITextField!
    @IBOutlet weak var displayOrderLabel: UILabel!
    @IBOutlet weak var displayOrderTF: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var viewImageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var addNewIconImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewImageHeightConstraint.constant = 0
        onlyImageFileButton.backgroundColor = ThemeManager.shared.currentColor
        addNewIconImageView.tintColor = ThemeManager.shared.currentColor
    }
    
    @IBAction func onlyImageFilesButtonAction(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true)
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
    }

}

extension AddNewImageVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            hotelImgView.image = selectedImage
            viewImageHeightConstraint.constant = 100
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
