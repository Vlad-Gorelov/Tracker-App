//
//  TrackerCellViewController.swift
//  Tracker App
//
//  Created by Владислав Горелов on 23.01.2024.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "CustomCell"

    // 1-я часть
    let coloredRectangleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.orange
        view.layer.cornerRadius = 16
        return view
    }()

    let whiteOverlay: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.red
        view.layer.cornerRadius = 68
        return view
    }()

    let emojiLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "🍏" // Пример эмодзи яблока
        label.textAlignment = .center
        return label
    }()

    let deleteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Пример текста"
        label.numberOfLines = 2
        return label
    }()

    // 2-я часть
    let nonColoredRectangleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let deleteText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Пример текста"
        return label
    }()

    let coloredCircleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.orange // Цвет как в 1-й части
        view.layer.cornerRadius = 17 // Половина размера круга
        return view
    }()

    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "addTracker")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupUI()
    }

    private func setupUI() {
        // Добавляем 1-ю часть
        contentView.addSubview(coloredRectangleView)
        NSLayoutConstraint.activate([
            coloredRectangleView.topAnchor.constraint(equalTo: contentView.topAnchor),
            coloredRectangleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            coloredRectangleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            coloredRectangleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        coloredRectangleView.addSubview(whiteOverlay)
        NSLayoutConstraint.activate([
            whiteOverlay.topAnchor.constraint(equalTo: coloredRectangleView.topAnchor, constant: 12),
            whiteOverlay.leadingAnchor.constraint(equalTo: coloredRectangleView.leadingAnchor, constant: 12),
            whiteOverlay.widthAnchor.constraint(equalToConstant: 24),
            whiteOverlay.heightAnchor.constraint(equalToConstant: 24)
        ])

        whiteOverlay.addSubview(emojiLabel)
        NSLayoutConstraint.activate([
            emojiLabel.centerXAnchor.constraint(equalTo: whiteOverlay.centerXAnchor),
            emojiLabel.centerYAnchor.constraint(equalTo: whiteOverlay.centerYAnchor)
        ])

        coloredRectangleView.addSubview(deleteLabel)
        NSLayoutConstraint.activate([
            deleteLabel.bottomAnchor.constraint(equalTo: coloredRectangleView.bottomAnchor, constant: -8),
            deleteLabel.leadingAnchor.constraint(equalTo: coloredRectangleView.leadingAnchor, constant: 12),
            deleteLabel.trailingAnchor.constraint(equalTo: coloredRectangleView.trailingAnchor, constant: -12)
        ])

        // Добавляем 2-ю часть
        contentView.addSubview(nonColoredRectangleView)
        NSLayoutConstraint.activate([
            nonColoredRectangleView.topAnchor.constraint(equalTo: coloredRectangleView.bottomAnchor),
            nonColoredRectangleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nonColoredRectangleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nonColoredRectangleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        nonColoredRectangleView.addSubview(deleteText)
        NSLayoutConstraint.activate([
            deleteText.topAnchor.constraint(equalTo: nonColoredRectangleView.topAnchor, constant: 16),
            deleteText.leadingAnchor.constraint(equalTo: nonColoredRectangleView.leadingAnchor, constant: 12),
            deleteText.trailingAnchor.constraint(equalTo: nonColoredRectangleView.trailingAnchor, constant: -12)
        ])

        nonColoredRectangleView.addSubview(coloredCircleView)
        NSLayoutConstraint.activate([
            coloredCircleView.centerYAnchor.constraint(equalTo: nonColoredRectangleView.centerYAnchor),
            coloredCircleView.trailingAnchor.constraint(equalTo: nonColoredRectangleView.trailingAnchor, constant: -12),
            coloredCircleView.widthAnchor.constraint(equalToConstant: 34),
            coloredCircleView.heightAnchor.constraint(equalToConstant: 34)
        ])

        coloredCircleView.addSubview(iconImageView)
        NSLayoutConstraint.activate([
            iconImageView.centerXAnchor.constraint(equalTo: coloredCircleView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: coloredCircleView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }


    func configure(name: String, emoji: String) {
        emojiLabel.text = emoji
        deleteText.text = name
    }
    
}
