//
//  ScheduleViewController.swift
//  Tracker App
//
//  Created by Владислав Горелов on 24.01.2024.
//

import UIKit

final class ScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let tableView = UITableView()
    private let daysOfWeek = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]
    private var switchStates: [Bool] = [false, false, false, false, false, false, false]

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    private func setUI() {
        view.backgroundColor = .ypWhiteDay
        setLabel()
        setTableView()

        // Создаем и добавляем первую кнопку
        let buttonDone = createButton(title: "Готово", action: #selector(buttonDoneTapped))
        view.addSubview(buttonDone)

        // Добавляем констрейнты для stackView
        NSLayoutConstraint.activate([
            buttonDone.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            buttonDone.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonDone.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }


    private func setLabel() {
        let label = UILabel()
        label.text = "Расписание"
        label.textColor = .ypBlackDay
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 27),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func setTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self

        // Устанавливаем радиус скругления углов
        tableView.layer.cornerRadius = 16
        tableView.layer.masksToBounds = true

        // Убираем разделительную полосу у последней ячейки
        tableView.tableFooterView = UIView()

        // Установка отступа разделителя от краёв ячеек
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

        // Установка стиля разделителя
        tableView.separatorStyle = .singleLine

        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 87),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20), // Отступ слева
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20), // Отступ справа
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daysOfWeek.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        configureCell(cell, at: indexPath)

        // Убираем разделительную полосу у последней ячейки
        if indexPath.row == daysOfWeek.count - 1 {
               cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: .greatestFiniteMagnitude)
           } else {
               cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
           }

        // Установка цвета фона для ячейки
        cell.backgroundColor = .ypBgDay
        return cell
    }

    func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath) {
        let dayOfWeek = daysOfWeek[indexPath.row]
        cell.textLabel?.text = dayOfWeek

        let switcher = UISwitch()
        switcher.isOn = switchStates[indexPath.row]
        switcher.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)

        cell.accessoryView = switcher
        cell.selectionStyle = .none

        // Установка цвета активного состояния свитчера
        switcher.onTintColor = .ypBlue

        // Установка размера шрифта
        cell.textLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)

        // Скругление углов для первой ячейки
        if indexPath.row == 0 {
            cell.layer.cornerRadius = 16
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }

        // Скругление углов для последней ячейки
        if indexPath.row == daysOfWeek.count - 1 {
            cell.layer.cornerRadius = 16
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
    }

    func indexPathForView(_ view: UIView) -> IndexPath? {
        let point = view.convert(CGPoint.zero, to: tableView)
        return tableView.indexPathForRow(at: point)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
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

    @objc func switchChanged(_ sender: UISwitch) {
        if let indexPath = indexPathForView(sender) {
            switchStates[indexPath.row] = sender.isOn
            // Здесь можно добавить логику обработки изменения состояния свитчера
        }
    }

    @objc private func buttonDoneTapped() {
        print("Выбрали расписание!")
    }

}
