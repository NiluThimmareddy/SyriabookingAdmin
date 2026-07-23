//
//  DescriptionVC.swift
//  SyriabookingAdmin
//
//  Created by Hitman on 21/07/26.
//

import UIKit

class DescriptionVC: UIViewController {
    
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var checkInTimeLabel: UILabel!
    @IBOutlet weak var checkInTimeTF: UITextField!
    @IBOutlet weak var checkOutTimeLabel: UILabel!
    @IBOutlet weak var checkOutTimeTF: UITextField!
    @IBOutlet weak var fullDescriptionLabel: UILabel!
    @IBOutlet weak var fulldescriptionTF: UITextView!
    @IBOutlet weak var acceptedCurrenciesLabel: UILabel!
    @IBOutlet weak var acceptedCurrenciesButton: UIButton!
    @IBOutlet weak var languageSpokenLabel: UILabel!
    @IBOutlet weak var languageSpokenButton: UIButton!
    @IBOutlet weak var covidSafetyLevelLabel: UILabel!
    @IBOutlet weak var covidSafetyLevelButton: UIButton!
    
    let currencies = ["USD", "EUR", "GBP", "INR", "AUD", "SYP"]
    let languages = ["English","Spanish","French","German","Hindi","Arabic"]
    let covidLevels = ["NotSpecified","Low","Medium","High","Certified"]
    
    var selectedCurrencies: Set<String> = []
    var selectedLanguages: Set<String> = []
    var selectedCovidLevel = "NotSpecified"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCurrenciesMenu()
        setupLanguagesMenu()
        setupCovidMenu()
    }

    func setupCurrenciesMenu() {

        let actions = currencies.map { currency in

            UIAction(
                title: currency,
                state: selectedCurrencies.contains(currency) ? .on : .off
            ) { [weak self] _ in

                guard let self = self else { return }

                if self.selectedCurrencies.contains(currency) {
                    self.selectedCurrencies.remove(currency)
                } else {
                    self.selectedCurrencies.insert(currency)
                }

                self.acceptedCurrenciesButton.setTitle(
                    self.selectedCurrencies.sorted().joined(separator: ", "),
                    for: .normal
                )

                self.setupCurrenciesMenu()
            }
        }

        acceptedCurrenciesButton.menu = UIMenu(children: actions)
        acceptedCurrenciesButton.showsMenuAsPrimaryAction = true
    }
    
    func setupLanguagesMenu() {

        let actions = languages.map { language in

            UIAction(
                title: language,
                state: selectedLanguages.contains(language) ? .on : .off
            ) { [weak self] _ in

                guard let self = self else { return }

                if self.selectedLanguages.contains(language) {
                    self.selectedLanguages.remove(language)
                } else {
                    self.selectedLanguages.insert(language)
                }

                self.languageSpokenButton.setTitle(
                    self.selectedLanguages.sorted().joined(separator: ", "),
                    for: .normal
                )

                self.setupLanguagesMenu()
            }
        }

        languageSpokenButton.menu = UIMenu(children: actions)
        languageSpokenButton.showsMenuAsPrimaryAction = true
    }
    
    func setupCovidMenu() {

        let actions = covidLevels.map { level in

            UIAction(
                title: level,
                state: selectedCovidLevel == level ? .on : .off
            ) { [weak self] _ in

                guard let self = self else { return }

                self.selectedCovidLevel = level
                self.covidSafetyLevelButton.setTitle(level, for: .normal)

                self.setupCovidMenu()
            }
        }

        covidSafetyLevelButton.menu = UIMenu(children: actions)
        covidSafetyLevelButton.showsMenuAsPrimaryAction = true
    }
}
