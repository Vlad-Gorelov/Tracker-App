//
//  TrackerPlaceholderNoFilterResultsView.swift
//  Tracker App
//
//  Created by Владислав Горелов on 11.02.2024.
//

import UIKit

class PlaceholderNoFilterResultsView: UIView {

    private func setNoResult() {
        // Создание и настройка надписи
        let noResultsLabel = UILabel()
        noResultsLabel.text = "Ничего не найдено"
        noResultsLabel.textColor = .ypBlackDay
        noResultsLabel.textAlignment = .center
        noResultsLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        noResultsLabel.translatesAutoresizingMaskIntoConstraints = false

        // Добавление надписи на экран
        addSubview(noResultsLabel)

        // Настройка ограничений для центрирования надписи
        NSLayoutConstraint.activate([
            noResultsLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            noResultsLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        // Создание и настройка UIImageView для изображения
        let noResultsImageView = UIImageView(image: UIImage(named: "error3"))
        noResultsImageView.contentMode = .scaleAspectFit
        noResultsImageView.translatesAutoresizingMaskIntoConstraints = false

        // Добавление UIImageView на экран и установка ограничений
        addSubview(noResultsImageView)

        NSLayoutConstraint.activate([
            noResultsImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            noResultsImageView.bottomAnchor.constraint(equalTo: noResultsLabel.topAnchor, constant: -8), // Отступ вниз до надписи
            noResultsImageView.widthAnchor.constraint(equalToConstant: 80), // Ширина изображения
            noResultsImageView.heightAnchor.constraint(equalToConstant: 80) // Высота изображения
        ])
    }
}
