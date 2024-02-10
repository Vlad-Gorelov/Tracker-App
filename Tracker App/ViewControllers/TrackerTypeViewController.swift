//
//  TrackerTypeViewController.swift
//  Tracker App
//
//  Created by Владислав Горелов on 24.01.2024.
//

import UIKit

final class TrackerTypeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypWhiteDay
        setLabel()
        setupUI()
    }

    private func setupUI() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        view.addSubview(stackView)

        // Создаем и добавляем первую кнопку
        let buttonHabbit = createButton(title: "Привычка", action: #selector(button1Tapped))
        stackView.addArrangedSubview(buttonHabbit)

        // Создаем и добавляем вторую кнопку
        let buttonOneEvent = createButton(title: "Нерегулярное событие", action: #selector(button2Tapped))
        stackView.addArrangedSubview(buttonOneEvent)

        // Добавляем констрейнты для stackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 140) // Высота стека (60 + 20 + 60)
        ])
    }

    @objc private func button1Tapped() {
        navigationTest()
        print("Создали привычку!")
    }

    @objc private func button2Tapped() {
        navigationTest2()
        print("Создали нерегулярное событие!")
    }

    private func navigationTest() {
        let trackerTypeVC = CrateHabitViewController()
        trackerTypeVC.modalPresentationStyle = .pageSheet
        present(trackerTypeVC, animated: true)
    }

    private func navigationTest2() {
        let trackerTypeVC = ScheduleViewController()
        trackerTypeVC.modalPresentationStyle = .pageSheet
        present(trackerTypeVC, animated: true)
    }

    private func setLabel() {
        // Создание и настройка надписи
        let label = UILabel()
        label.text = "Создание трекера"
        label.textColor = .ypBlackDay
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false

        // Добавление надписи на экран
        view.addSubview(label)

        // Настройка ограничений для центрирования надписи
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 27),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func createButton(title: String, action: Selector) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .ypBlackDay
        button.layer.cornerRadius = 16
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        
        // Установка начертания текста и размера шрифта
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)

        // Добавляем констрейнты для высоты кнопки
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true

        return button
    }
}

