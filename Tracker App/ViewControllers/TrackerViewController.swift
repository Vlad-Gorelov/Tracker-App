//
//  ViewController.swift
//  Tracker App
//
//  Created by Владислав Горелов on 12.01.2024.
//

import UIKit

final class TrackerViewController: UIViewController, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating {

    var searchController: UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypWhiteDay
        setEmptyTrackers()
        setNavigationBar()
    }

    func  setNavigationBar() {
        // Настройка navigationBar с largeTitle

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        title = "Трекеры"

        let addButton = UIButton(type: .custom)
        if let iconImage = UIImage(named: "addTracker")?.withRenderingMode(.alwaysOriginal) {
            addButton.setImage(iconImage, for: .normal)
        }
        addButton.titleLabel?.font = UIFont(name: "SF Pro", size: 34)
        addButton.addTarget(
            self,
            action: #selector(addTrackerButtonTapped),
            for: .touchUpInside
        )

        addButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)

        let addButtonItem = UIBarButtonItem(customView: addButton)
        navigationItem.leftBarButtonItem = addButtonItem

        setDatePickerItem()
        setSearchBarController()
    }

    private func setDatePickerItem() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.addTarget(
            self,
            action: #selector(dateChanged(_ :)),
            for: .valueChanged
        )

        let datePickerItem = UIBarButtonItem(customView: datePicker)
        navigationItem.rightBarButtonItem = datePickerItem
    }

    func setSearchBarController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self

        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    @objc private func addTrackerButtonTapped() {
        // TODO: add logic
    }

    @objc func dateChanged(_ datePicker: UIDatePicker) {
        //TODO: add date picker logic
    }

    func setEmptyTrackers() {
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

    // MARK: - UISearchBarDelegate

    func searchBarSearchClicked(_ searchBar: UISearchBar) {
        // Обработка события поиска
        print("Идёт поиск")
    }

    // MARK: - UISearchResultsUpdating

    func updateSearchResults(for searchController: UISearchController) {
        // Обновление результатов поиска
        // Этот метод вызывается при изменении текста в поле поиска
    }
}
