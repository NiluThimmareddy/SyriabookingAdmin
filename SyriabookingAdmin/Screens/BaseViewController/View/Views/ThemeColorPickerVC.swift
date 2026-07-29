//
//  ThemeColorPickerVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 29/07/26.
//


import UIKit

class ThemeColorPickerVC: UIViewController {

    let colors: [UIColor] = [
        .systemBlue,
        .systemRed,
        .systemGreen,
        .systemOrange,
        .systemPurple,
        .systemPink,
        .brown,
        .black,
        .systemTeal
    ]

    private let container = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black.withAlphaComponent(0.25)

        setupContainer()

        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(close)
        )

        view.addGestureRecognizer(tap)
    }

    func setupContainer() {

        container.backgroundColor = .white
        container.layer.cornerRadius = 16

        view.addSubview(container)

        container.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            container.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            container.widthAnchor.constraint(equalToConstant: 220),

            container.heightAnchor.constraint(equalToConstant: 180)
        ])

        let stack = UIStackView()

        stack.axis = .vertical
        stack.spacing = 15
        stack.distribution = .fillEqually

        container.addSubview(stack)

        stack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            stack.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),

            stack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),

            stack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),

            stack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20)
        ])

        var index = 0

        for _ in 0..<3 {

            let row = UIStackView()

            row.axis = .horizontal
            row.spacing = 15
            row.distribution = .fillEqually

            for _ in 0..<3 {

                let button = UIButton(type: .system)

                button.backgroundColor = colors[index]

                button.layer.cornerRadius = 18

                button.tag = index

                button.addTarget(
                    self,
                    action: #selector(colorSelected(_:)),
                    for: .touchUpInside
                )

                row.addArrangedSubview(button)

                index += 1
            }

            stack.addArrangedSubview(row)
        }
    }

    @objc
    func colorSelected(_ sender: UIButton) {

        let color = colors[sender.tag]

        ThemeManager.shared.setThemeColor(color)

        dismiss(animated: true)
    }

    @objc
    func close() {

        dismiss(animated: true)
    }
}
