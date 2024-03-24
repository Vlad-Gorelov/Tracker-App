//
//  TrackerPlaceholderView.swift
//  Tracker App
//
//  Created by Владислав Горелов on 11.02.2024.
//

import UIKit

class PlaceholderView: UIView {

    func setEmptyTrackers() {
        // Создание и настройка надписи
        let emptyStateLabel = UILabel()
        emptyStateLabel.text = "Что будем отслеживать?"
        emptyStateLabel.textColor = .ypBlackDay
        emptyStateLabel.textAlignment = .center
        emptyStateLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        emptyStateLabel.translatesAutoresizingMaskIntoConstraints = false

        // Добавление надписи на экран
        addSubview(emptyStateLabel)

        // Настройка ограничений для центрирования надписи
        NSLayoutConstraint.activate([
            emptyStateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        // Создание и настройка UIImageView для изображения
        let emptyStateImageView = UIImageView(image: UIImage(named: "error1"))
        emptyStateImageView.contentMode = .scaleAspectFit
        emptyStateImageView.translatesAutoresizingMaskIntoConstraints = false

        // Добавление UIImageView на экран и установка ограничений
        addSubview(emptyStateImageView)

        NSLayoutConstraint.activate([
            emptyStateImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptyStateImageView.bottomAnchor.constraint(equalTo: emptyStateLabel.topAnchor, constant: -8), // Отступ вниз до надписи
            emptyStateImageView.widthAnchor.constraint(equalToConstant: 80), // Ширина изображения
            emptyStateImageView.heightAnchor.constraint(equalToConstant: 80) // Высота изображения
        ])
    }
}
