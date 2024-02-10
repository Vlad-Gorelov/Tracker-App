//
//  ViewController.swift
//  Tracker App
//
//  Created by Владислав Горелов on 12.01.2024.
//

import UIKit

final class TrackerViewController: UIViewController {
    private let searchController = UISearchController(searchResultsController: nil)
    private var trackersCollectionView: UICollectionView!

    var categories: [TrackerCategory] = []
    var completedTrackers: [TrackerRecord] = []
    //let currentDate: Date


    private var parametres: GeometricParametres

    private lazy var emptyStateImageView = {
        let image = UIImageView(image: UIImage(named: "error1"))
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var emptyStateLabel: UILabel = {
        let label = UILabel()
        label.text = "Что будем отслеживать?"
        label.font = UIFont(name: "SF Pro", size: 12)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init() {
        self.parametres = GeometricParametres(cellCount: 2, leftInsets: 16, rightInsets: 16, cellSpacing: 9)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypWhiteDay
        setEmptyTrackers()
        setNavigationBar()
        setTrackersCollectionView()
        categories = DataManager.shared.categories // вот тут моковые данные вызываются
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
            action: #selector(dateChanged(_:)),
            for: .valueChanged
        )

        // Настройка формата отображения даты
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"

        // Установка локализации для форматтера
        dateFormatter.locale = Locale(identifier: "ru_RU")

        // Устанавливаем формат даты для датапикера
        datePicker.datePickerMode = .date
        datePicker.locale = dateFormatter.locale
        datePicker.calendar = dateFormatter.calendar
        datePicker.calendar.firstWeekday = 2

        // Создаем constraint для ширины
        let widthConstraint = NSLayoutConstraint(
            item: datePicker,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: 120
        )

        // Добавляем constraint к датапикеру
        datePicker.addConstraint(widthConstraint)

        // Устанавливаем вправо на navigationItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: datePicker)

        // Устанавливаем формат года
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yy"

        let calendar = Calendar(identifier: .gregorian)
        let currentDate = Date()
        var dateComponents = DateComponents()
        dateComponents.year = -5
        let maxDate = calendar.date(byAdding: dateComponents, to: currentDate)
        dateComponents.year = 5
        let minDate = calendar.date(byAdding: dateComponents, to: currentDate)
        datePicker.minimumDate = maxDate
        datePicker.maximumDate = minDate
        datePicker.date = currentDate
        datePicker.locale = dateFormatter.locale  // Используем dateFormatter.locale, чтобы учесть формат даты
        datePicker.calendar = dateFormatter.calendar
    }




    @objc private func addTrackerButtonTapped() {
        // TODO: add logic
        let trackerTypeVC = TrackerTypeViewController()
        trackerTypeVC.modalPresentationStyle = .pageSheet
        present(trackerTypeVC, animated: true)
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

    private func setTrackersCollectionView() {



        // Создаем объект layout для UICollectionView. это все стандартное
        // UICollectionViewFlowLayout - это класс, который определяет, как элементы (ячейки, заголовки и т.д.) будут расположены внутри UICollectionView.
        let layout = UICollectionViewFlowLayout()

        // Устанавливаем вертикальное направление прокрутки для коллекции.
        layout.scrollDirection = .vertical

        // Шаг 2: Создаем UICollectionView.
        // Инициализируем trackersCollectionView, задавая ему frame (рамка, размер) и layout (расположение элементов).
        // frame: .zero означает, что позиция и размер коллекции будут установлены позже с помощью Auto Layout.
        trackersCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        // это стандатрный код его просто переписать это база она одинаковая у всех

        // Шаг 3: Задаем источник данных и делегата для UICollectionView.
        // Указываем, что наш класс будет предоставлять данные для коллекции и обрабатывать события пользователя.
        // это все тоже стандатрное и одинковое у всех
        trackersCollectionView.dataSource = self
        trackersCollectionView.delegate = self

        // Шаг 4: Регистрируем классы ячеек и заголовков.
        // Это необходимо для того, чтобы коллекция могла создавать новые экземпляры ячеек и заголовков.
        trackersCollectionView.register(TrackerCellVC.self, forCellWithReuseIdentifier: TrackerCellVC.cellIdetnifier)

        // Лейбл для категории
        trackersCollectionView.register(TrackerViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TrackerViewHeader.headerIdentifier)

        // Шаг 5: Добавляем UICollectionView в иерархию представлений.
        // Выключаем автоматическое создание констрейнтов для этого представления.
        trackersCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(trackersCollectionView)

        // Шаг 6: Устанавливаем констрейнты для UICollectionView.
        // Задаем правила для размера и позиции коллекции внутри родительского представления.
        NSLayoutConstraint.activate([
            trackersCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            trackersCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            trackersCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            trackersCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

    }
}

extension TrackerViewController: UICollectionViewDataSource {
    // Возвращает количество элементов (ячеек) в каждой секции
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories[section].trackers.count
     }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
            // Возвращаем количество категорий в массиве categories
            return categories.count
        }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: TrackerViewHeader.headerIdentifier,
            for: indexPath) as? TrackerViewHeader
        else {
            fatalError("Failed to dequeue Trackers Header")
        }

        header.titleLabel.text = categories[indexPath.section].trackerTitle

        // Настройка стиля заголовка
            header.titleLabel.font = UIFont.boldSystemFont(ofSize: 19)
        
        return header
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = trackersCollectionView.dequeueReusableCell(withReuseIdentifier: TrackerCellVC.cellIdetnifier, for: indexPath) as! TrackerCellVC
        let tracker = categories[indexPath.section].trackers[indexPath.row]
        cell.configure(with: tracker)
        return cell
    }
}

extension TrackerViewController: UISearchBarDelegate, UISearchControllerDelegate {
    func setSearchBarController() {
        searchController.delegate = self
        searchController.searchBar.delegate = self

        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

extension TrackerViewController: UICollectionViewDelegateFlowLayout {
    // Определяет размер каждой ячейки в коллекции там еще нудно будет добавить стурктуру из учебника GeometricParams она у меня в хелпере
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Вычисляем доступную ширину для ячейки, учитывая внутренние отступы.
        let avaliableWidth = trackersCollectionView.bounds.width - parametres.paddingWidth
        // Делим доступную ширину на количество ячеек в строке, чтобы получить ширину одной ячейки.
        let widthPerItem = avaliableWidth / CGFloat(parametres.cellCount)
        // Рассчитываем высоту ячейки на основе её ширины и заданных пропорций.
        let heightPerItem = widthPerItem * (148 / 167)
        // Возвращаем рассчитанный размер ячейки.
        return CGSize(width: widthPerItem, height: heightPerItem)
    }

    // Устанавливает отступы для каждой секции в коллекции
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // Задаем отступы для каждой секции, определяя расстояние между краями коллекции и ячейками.
        UIEdgeInsets(top: 12, left: parametres.leftInsets, bottom: 16, right: parametres.rightInsets)
    }

    // Определяет минимальное расстояние между элементами внутри секции
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // Возвращаем заранее заданное расстояние между ячейками.
        return parametres.cellSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        // Создаем экземпляр хедера для расчета его размера
        guard let header = self.trackersCollectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TrackerViewHeader.headerIdentifier,
            for: IndexPath(item: 0, section: section)
        ) as? TrackerViewHeader else {
            return CGSize(width: collectionView.frame.width, height: 0)
        }

        // Настраиваем хедер данными
        header.titleLabel.text = categories[section].trackerTitle

        // Расчет размера хедера
        let size = header.systemLayoutSizeFitting(CGSize(
            width: collectionView.frame.width, height: UIView.layoutFittingCompressedSize.height),
            withHorizontalFittingPriority: .required, // Ширина хедера должна соответствовать ширине коллекции
            verticalFittingPriority: .fittingSizeLevel) // Высота может быть изменена в зависимости от содержимого
        return size
    }
}

