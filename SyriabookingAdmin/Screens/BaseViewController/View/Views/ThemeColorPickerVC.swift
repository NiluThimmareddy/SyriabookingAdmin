//
//  ThemeColorPickerVC.swift
//  SyriabookingAdmin
//
//  Created by Toqsoft on 29/07/26.

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
        .systemTeal,
        .magenta,
        .systemYellow,
        .opaqueSeparator,
        .systemIndigo,
        .systemCyan
    ]

    private let container = UIView()

    private let numberOfColumns = 5

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

    private func setupContainer() {

        container.backgroundColor = .white
        container.layer.cornerRadius = 16
        container.clipsToBounds = true

        view.addSubview(container)

        container.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            container.widthAnchor.constraint(equalToConstant: 280),

            // Height will be calculated below
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

        // Calculate number of rows automatically
        let numberOfRows = Int(
            ceil(Double(colors.count) / Double(numberOfColumns))
        )

        // Create rows automatically
        for rowIndex in 0..<numberOfRows {

            let row = UIStackView()

            row.axis = .horizontal
            row.spacing = 15
            row.distribution = .fillEqually

            for columnIndex in 0..<numberOfColumns {

                let index = (rowIndex * numberOfColumns) + columnIndex

                // Make sure we don't access colors[index]
                // when index is outside the array
                if index < colors.count {

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

                } else {

                    // Empty space for the last row
                    let emptyView = UIView()

                    row.addArrangedSubview(emptyView)
                }
            }

            stack.addArrangedSubview(row)
        }

        // Automatically calculate container height
        let rowHeight: CGFloat = 36
        let verticalSpacing: CGFloat = 15
        let verticalPadding: CGFloat = 40

        let containerHeight =
            (CGFloat(numberOfRows) * rowHeight) +
            (CGFloat(max(0, numberOfRows - 1)) * verticalSpacing) +
            verticalPadding

        container.heightAnchor.constraint(
            equalToConstant: containerHeight
        ).isActive = true
    }

    @objc
    private func colorSelected(_ sender: UIButton) {

        let color = colors[sender.tag]

        ThemeManager.shared.setThemeColor(color)

        dismiss(animated: true)
    }

    @objc
    private func close() {

        dismiss(animated: true)
    }
}
