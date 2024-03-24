//
//  ViewController.swift
//  Tracker App
//
//  Created by Владислав Горелов on 12.01.2024.
//

import UIKit

final class TrackerViewController: UIViewController, UICollectionViewDelegate, UISearchBarDelegate {
    private let searchController = UISearchController(searchResultsController: nil)
    private var collectionView: UICollectionView!

    private var categories: [TrackerCategory] = []
    private var filteredCategories: [TrackerCategory] = []
    private var completedTrackers: [TrackerRecord] = []

    private var parametres: GeometricParametres

    private let dataManager = DataManager.shared

    private let placeholderView = PlaceholderView()
    private let placeholderNoFilterResults = PlaceholderNoFilterResultsView()

    private lazy var emptyStateImageView = {
        let image = UIImageView(image: UIImage(named: "error1"))
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var emptyStateLabel: UILabel = {
        let label = UILabel()
        label.text = "Что будем отслеживать?"
        label.font = UIFont.systemFont(ofSize: 12)
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

    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setTrackersCollectionView()
        view.backgroundColor = .ypWhiteDay
        setNavigationBar()
        setPlaceHolders()
        reloadData()
    }

    //MARK: - Helpers

    func setPlaceHolders() {
        // Добавляем плейсхолдеры на экран и устанавливаем их constraint'ы
          view.addSubview(placeholderView)
          view.addSubview(placeholderNoFilterResults)

          NSLayoutConstraint.activate([
              placeholderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
              placeholderView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
              placeholderNoFilterResults.centerXAnchor.constraint(equalTo: view.centerXAnchor),
              placeholderNoFilterResults.centerYAnchor.constraint(equalTo: view.centerYAnchor)
          ])
    }

    func setNavigationBar() {
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

        // Добавляем поле поиска в навигационную панель
        searchController.searchBar.placeholder = "Поиск"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true

        searchController.searchBar.delegate = self
        self.datePicker = datePicker
    }

    func setDatePickerItem() {
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.calendar.firstWeekday = 2
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.clipsToBounds = true
        datePicker.layer.cornerRadius = 8
        datePicker.tintColor = .ypBlue
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)

        // Настройка формата отображения даты
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"

        // Установка локализации для форматтера
        dateFormatter.locale = Locale(identifier: "ru_RU")

        // Устанавливаем формат даты для датапикера
        datePicker.locale = dateFormatter.locale
        datePicker.calendar = dateFormatter.calendar

        // Устанавливаем минимальную и максимальную даты
        let currentDate = Date()
        let calendar = Calendar(identifier: .gregorian)
        var dateComponents = DateComponents()
        dateComponents.year = -100
        let maxDate = calendar.date(byAdding: dateComponents, to: currentDate)
        dateComponents.year = 100
        let minDate = calendar.date(byAdding: dateComponents, to: currentDate)
        datePicker.minimumDate = maxDate
        datePicker.maximumDate = minDate

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
    }

    private func reloadData() {
        categories = dataManager.categories
        print("Loaded categories: \(categories)")
        dateChanged()
        collectionView.reloadData()
    }

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .ypLightGray
        label.font = UIFont(name: "SF Pro", size: 17)
        label.textAlignment = .center
        label.textColor = .ypBlackDay
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.layer.cornerRadius = 8
        label.layer.zPosition = 1000
        return label
    }()

    private lazy var datePicker: UIDatePicker = {
        let pickerDate = UIDatePicker()
        pickerDate.preferredDatePickerStyle = .compact
        pickerDate.datePickerMode = .date
        pickerDate.locale = Locale(identifier: "ru_RU")
        pickerDate.calendar.firstWeekday = 2
        pickerDate.translatesAutoresizingMaskIntoConstraints = false
        pickerDate.clipsToBounds = true
        pickerDate.layer.cornerRadius = 8
        pickerDate.tintColor = .ypBlue
        pickerDate.addTarget(self, action: #selector(dateChanged), for: .valueChanged)

        return pickerDate
    }()

    private lazy var searchTextField: UISearchTextField = {
        let textField = UISearchTextField()
        textField.backgroundColor = .ypBgDay
        textField.textColor = .ypBlackDay
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 10
        textField.heightAnchor.constraint(equalToConstant: 36).isActive = true

        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.ypGray
        ]

        let attributedPlaceholder = NSAttributedString(
            string: "Поиск",
            attributes: attributes
        )

        textField.attributedPlaceholder = attributedPlaceholder
        textField.delegate = self

        return textField
    }()


    @objc private func addTrackerButtonTapped() {
        let trackerTypeVC = TrackerTypeViewController()
        trackerTypeVC.modalPresentationStyle = .pageSheet
        present(trackerTypeVC, animated: true)
    }

    @objc private func selectFilter() {
        print("Filtres applied")
    }

    @objc private func dateChanged() {
        updateDateLabelTitle(with: datePicker.date)
        reloadFilteredCategories(text: searchTextField.text, date: datePicker.date)
    }

    private func formattedDate(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        return dateFormatter.string(from: date)
    }

    private func updateDateLabelTitle(with date: Date) {
        let dateString = formattedDate(from: date)
        dateLabel.text = dateString
    }

    func reloadFilteredCategories(text: String?, date: Date) {
        let calendar = Calendar.current
        let filterWeekday = calendar.component(.weekday, from: date)
        let filterText = (text ?? "").lowercased()

        filteredCategories = categories.filter { category in
            let filteredTrackers = category.trackers.filter { tracker in
                let textCondition = filterText.isEmpty || tracker.name.lowercased().contains(filterText)
                let dateCondition = tracker.schedule.contains(WeekDay(rawValue: filterWeekday))
                return textCondition && dateCondition
            }
            return !filteredTrackers.isEmpty // Проверяем, что у категории есть трекеры после фильтрации
        }

        collectionView.reloadData()
        reloadPlaceholder()
    }

    private func reloadPlaceholder() {
        placeholderView.isHidden = !filteredCategories.isEmpty
        if filteredCategories.isEmpty  {
            // Показываем плейсхолдер, когда нет отфильтрованных категорий
            placeholderNoFilterResults.isHidden = false
        } else {
            // Скрываем плейсхолдер, когда есть отфильтрованные категории
            placeholderNoFilterResults.isHidden = true
        }
    }


    // Настройка коллекции
    private func setTrackersCollectionView() {

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            TrackerCellVC.self,
            forCellWithReuseIdentifier: TrackerCellVC.cellIdentifier
        )

        // Лейбл для категории
        collectionView.register(
            TrackerViewHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TrackerViewHeader.headerIdentifier
        )

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

    }
}

// MARK: - Extensions

extension TrackerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        reloadFilteredCategories(text: searchTextField.text, date: datePicker.date)
        collectionView.reloadData()
        
        return true
    }
}

extension TrackerViewController: UICollectionViewDataSource {

    // Возвращает количество элементов (ячеек) в каждой секции
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard section < filteredCategories.count else {
            return 0 // Возвращаем 0, если запрашивается секция за пределами отфильтрованных категорий
        }
        return filteredCategories[section].trackers.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // Возвращаем количество категорий в массиве categories
        return filteredCategories.count
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: TrackerViewHeader.headerIdentifier,
            for: indexPath) as? TrackerViewHeader
        else {
            fatalError("Failed to dequeue Trackers Header")
        }

        header.titleLabel.text = filteredCategories[indexPath.section].trackerTitle

        // Настройка стиля заголовка
        header.titleLabel.font = UIFont.boldSystemFont(ofSize: 19)

        return header
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TrackerCellVC.cellIdentifier,
            for: indexPath
        ) as? TrackerCellVC else {
            return UICollectionViewCell()
        }

        // Получаем данные для текущей ячейки из отфильтрованных категорий
        let category = filteredCategories[indexPath.section]
        let tracker = category.trackers[indexPath.row]

        cell.delegate = self

        let isCompletedToday = isTrackerCompletedToday(id: tracker.id)
        let completedDays = completedTrackers.filter {
            $0.trackerID == tracker.id
        }.count

        // Конфигурируем ячейку с полученными данными
        cell.configure(
            with: tracker,
            isCompletedToday: isCompletedToday,
            completedDays: completedDays,
            indexPath: indexPath
        )
        return cell
    }


    private func isTrackerCompletedToday(id: UUID) -> Bool {
        completedTrackers.contains { trackerRecord in
            isSameTrackerRecord(trackerRecord: trackerRecord, id: id)
        }
    }

    private func isSameTrackerRecord(trackerRecord: TrackerRecord, id: UUID) -> Bool {
        let isSameDay = Calendar.current.isDate(trackerRecord.date, inSameDayAs: datePicker.date)
        return trackerRecord.trackerID == id && isSameDay
    }
}

extension TrackerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let avaliableWidth = collectionView.bounds.width - parametres.paddingWidth
        let widthPerItem = avaliableWidth / CGFloat(parametres.cellCount)
        // Рассчитываем высоту ячейки на основе её ширины и заданных пропорций.
        let heightPerItem = widthPerItem * (148 / 167)
        return CGSize(width: widthPerItem, height: heightPerItem)
    }

    // Устанавливает отступы для каждой секции в коллекции
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 12, left: parametres.leftInsets, bottom: 16, right: parametres.rightInsets)
    }

    // Определяет минимальное расстояние между элементами внутри секции
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return parametres.cellSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        // Создаем экземпляр хедера для расчета его размера
        guard let header = self.collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TrackerViewHeader.headerIdentifier,
            for: IndexPath(item: 0, section: section)
        ) as? TrackerViewHeader else {
            return CGSize(width: collectionView.frame.width, height: 0)
        }

        // Настраиваем хедер данными
        header.titleLabel.text = filteredCategories[section].trackerTitle

        // Расчет размера хедера
        let size = header.systemLayoutSizeFitting(CGSize(
            width: collectionView.frame.width, height: UIView.layoutFittingCompressedSize.height),
                                                  withHorizontalFittingPriority: .required, // Ширина хедера должна соответствовать ширине коллекции
                                                  verticalFittingPriority: .fittingSizeLevel) // Высота может быть изменена в зависимости от содержимого
        return size
    }
}

extension TrackerViewController: TrackerCellDelegate {
    func completeTracker(id: UUID, at indexPath: IndexPath) {
        let trackerRecord = TrackerRecord(trackerID: id, date: datePicker.date) //добавить ссылку на датапикер
        completedTrackers.append(trackerRecord)
        collectionView.reloadItems(at: [indexPath])
    }

    func uncompleteTracker(id: UUID, at indexPath: IndexPath) {
        completedTrackers.removeAll { trackerRecord in
            isSameTrackerRecord(trackerRecord: trackerRecord, id: id)
        }
        collectionView.reloadItems(at: [indexPath])
    }
}
