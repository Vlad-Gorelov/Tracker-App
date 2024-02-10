//
//  CreateHabitViewController.swift
//  Tracker App
//
//  Created by Владислав Горелов on 08.02.2024.
//

import UIKit

final class CrateHabitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypWhiteDay
        setLabel()
        setTextField()
        setupUI()
    }

    private func setupUI() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8 // Расстояние между кнопками
        stackView.distribution = .fillEqually
        view.addSubview(stackView)

        // Создаем и добавляем первую кнопку
        let buttonCancel = createButton(title: "Отменить", action: #selector(button1Tapped))
        buttonCancel.backgroundColor = .ypWhiteDay
        buttonCancel.layer.borderWidth = 1 // Задаем толщину обводки
        buttonCancel.layer.borderColor = UIColor.ypRed.cgColor // Задаем красный цвет обводки
        buttonCancel.setTitleColor(.red, for: .normal) // Задаем красный цвет текста
        stackView.addArrangedSubview(buttonCancel)

        // Создаем и добавляем вторую кнопку
        let buttonCreate = createButton(title: "Создать", action: #selector(button2Tapped))
        buttonCreate.backgroundColor = .ypGray
        stackView.addArrangedSubview(buttonCreate)

        // Добавляем констрейнты для stackView
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20), // Отступ слева
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20), // Отступ справа
            stackView.heightAnchor.constraint(equalToConstant: 60), // Высота стека
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -34) // Отступ от нижней границы
        ])
    }


    @objc private func button1Tapped() {
        print("Отменили!")
    }

    @objc private func button2Tapped() {
        print("Создали!")
    }

    private func navigationTest() {
        let trackerTypeVC = ScheduleViewController()
        trackerTypeVC.modalPresentationStyle = .pageSheet
        present(trackerTypeVC, animated: true)
    }

    private func setTextField() {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Введите название трекера"
        textField.backgroundColor = .ypBgDay
        textField.layer.cornerRadius = 16
        textField.textAlignment = .center
        textField.textColor = .ypBlackDay
        textField.textAlignment = .left
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.heightAnchor.constraint(equalToConstant: 75).isActive = true // Устанавливаем высоту
        view.addSubview(textField)

        // Создаем UIView для левого отступа
            let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
            textField.leftView = leftPaddingView
            textField.leftViewMode = .always

            // Создаем UIView для правого отступа
            let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
            textField.rightView = rightPaddingView
            textField.rightViewMode = .always

        // Добавляем констрейнты для текстового поля
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 87), // Отступ от лейбла
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16), // Отступ слева
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16) // Отступ справа
        ])
    }

    private func setLabel() {
        // Создание и настройка надписи
        let label = UILabel()
        label.text = "Новая привычка"
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

