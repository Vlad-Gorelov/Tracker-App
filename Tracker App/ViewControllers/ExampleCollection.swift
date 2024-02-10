//
//  ExampleCollection.swift
//  Tracker App
//
//  Created by Владислав Горелов on 27.01.2024.
//

import UIKit

final class ExampleCollection: UIViewController {

    // MARK: - Collections

    let collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
            return collectionView
        }()

    func setupCollectionConstraint() {
        // Добавим collectionView как подпредставление
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        collectionView.dataSource = self

        // Настройка ограничений для ширины ячейки
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let itemSpacing: CGFloat = 8  // Отступ между ячейками
            let collectionViewWidth = collectionView.bounds.width
            let itemWidth = (collectionViewWidth - itemSpacing * 3) / 2
            let itemSize = CGSize(width: max(0, itemWidth), height: max(0, itemWidth))  // Используйте max(0, ...) для избежания отрицательных значений
            layout.itemSize = itemSize
            layout.minimumInteritemSpacing = itemSpacing
            layout.minimumLineSpacing = itemSpacing
        }
    }


        override func viewDidLoad() {
            super.viewDidLoad()
            setupUIStatistic()
            setupCollectionConstraint()
        }

    func setupUIStatistic() {
        // Установка цвета фона
        view.backgroundColor = .ypWhiteDay

        // Настройка navigationBar с largeTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Пример"

        // Создание и настройка надписи
        let label = UILabel()
        label.text = "Анализировать пока нечего"
        label.textColor = .black
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
        let imageView = UIImageView(image: UIImage(named: "error3"))
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

extension ExampleCollection: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        configureCell(cell, at: indexPath)
        return cell
    }

    func configureCell(_ cell: UICollectionViewCell, at indexPath: IndexPath) {
        // Настройка внешнего вида ячейки
        cell.contentView.backgroundColor = .red

        // Добавьте другие настройки ячейки здесь, например, текст или изображение
    }
}




