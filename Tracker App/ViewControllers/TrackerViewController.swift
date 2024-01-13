//
//  ViewController.swift
//  Tracker App
//
//  Created by Владислав Горелов on 12.01.2024.
//

import UIKit

class TrackerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Установка цвета фона
        view.backgroundColor = .white

        // Создание и настройка надписи
        let label = UILabel()
        label.text = "Что будем отслеживать?"
        label.textColor = .ypBlackDay
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false

        // Добавление надписи на экран
        view.addSubview(label)

        // Настройка ограничений для центрирования надписи
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        // Создание и настройка UIImageView для изображения
                let imageView = UIImageView(image: UIImage(named: "error1"))
                imageView.contentMode = .scaleAspectFit
                imageView.translatesAutoresizingMaskIntoConstraints = false

                // Добавление UIImageView на экран и установка ограничений
                view.addSubview(imageView)

        NSLayoutConstraint.activate([
                    imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    imageView.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -8), // Отступ вниз до надписи
                    imageView.widthAnchor.constraint(equalToConstant: 80), // Ширина изображения
                    imageView.heightAnchor.constraint(equalToConstant: 80) // Высота изображения
                ])
    }
}
