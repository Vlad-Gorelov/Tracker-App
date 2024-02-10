//
//  TrackerCellViewController.swift
//  Tracker App
//
//  Created by Владислав Горелов on 23.01.2024.
//

import UIKit

final class TrackerCellVC: UICollectionViewCell {
    static let cellIdetnifier = "TrackersCell"
    var daysCounter = 0

    // Верхний прямоугольник
    let coloredRectangleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .colorSelection1
        return view
    }()

    // Иконка эмодзи
    private lazy var emojiLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "🍏" // Пример эмодзи яблока
        label.textAlignment = .center
        return label
    }()

    // Задний фон за эмодзи
    let whiteEmojiBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white.withAlphaComponent(0.3)
        return view
    }()


    // Заголовок в ячейке
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Выпить пива после пробежки"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white

        return label
    }()

    // Фон нижней части ячейки
    let nonColoredRectangleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    // Счётчик дней
    private lazy var daysCounterLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "\(daysCounter) день"
        return label
    }()

    // Круглая кнопка
    private lazy var coloredCircleButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "addTracker"), for: .normal) // ?
        button.backgroundColor = .colorSelection1
        let image = UIImage(named: "addTracker")?
            .withTintColor(UIColor(ciColor: .white), renderingMode: .alwaysOriginal)
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 12))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(coloredCircleButtonTapped), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("Нет инициализации")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        coloredRectangleView.layer.cornerRadius = 16
        coloredRectangleView.layer.masksToBounds = true

        whiteEmojiBackground.layer.cornerRadius = 12
        whiteEmojiBackground.clipsToBounds = true

        coloredCircleButton.layer.cornerRadius = 17
        coloredCircleButton.clipsToBounds = true
    }

    @objc private func coloredCircleButtonTapped() {
        daysCounter += 1
        daysCounterLabel.text = "\(daysCounter) \(daysCounter == 1 ? "день" : "дней")"

        // Изменение цвета кнопки
        UIView.animate(withDuration: 0.3) {
            self.coloredCircleButton.backgroundColor = self.coloredCircleButton.backgroundColor?.withAlphaComponent(0.3)
        } completion: { (_) in
            // Восстановление исходного цвета
            UIView.animate(withDuration: 0.3) {
                self.coloredCircleButton.backgroundColor = self.coloredCircleButton.backgroundColor?.withAlphaComponent(1.0)
            }
        }

        // Изменение иконки кнопки
        UIView.transition(with: coloredCircleButton, duration: 0.3, options: .transitionCrossDissolve, animations: {
            let doneImage = UIImage(named: "Done")?.withTintColor(UIColor(ciColor: .white), renderingMode: .alwaysOriginal)
            self.coloredCircleButton.setImage(doneImage, for: .normal)
        }) { (_) in
            // Задержка для смены обратно на исходную иконку
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                let addTrackerImage = UIImage(named: "addTracker")?.withTintColor(UIColor(ciColor: .white), renderingMode: .alwaysOriginal)
                self.coloredCircleButton.setImage(addTrackerImage, for: .normal)
            }
        }
    }




    private func setupUI() {
        contentView.addSubview(coloredRectangleView)
        contentView.addSubview(emojiLabel)
        contentView.addSubview(whiteEmojiBackground)
        contentView.addSubview(mainLabel)
        contentView.addSubview(nonColoredRectangleView)
        contentView.addSubview(daysCounterLabel)
        contentView.addSubview(coloredCircleButton)

        NSLayoutConstraint.activate([
            coloredRectangleView.topAnchor.constraint(equalTo: contentView.topAnchor),
            coloredRectangleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            coloredRectangleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            coloredRectangleView.heightAnchor.constraint(equalToConstant: 90),

            emojiLabel.centerXAnchor.constraint(equalTo: whiteEmojiBackground.centerXAnchor),
            emojiLabel.centerYAnchor.constraint(equalTo: whiteEmojiBackground.centerYAnchor),

            whiteEmojiBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            whiteEmojiBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            whiteEmojiBackground.widthAnchor.constraint(equalToConstant: 24),
            whiteEmojiBackground.heightAnchor.constraint(equalToConstant: 24),

            mainLabel.leadingAnchor.constraint(equalTo: coloredRectangleView.leadingAnchor, constant: 12),
            mainLabel.trailingAnchor.constraint(equalTo: coloredRectangleView.trailingAnchor, constant: -12),
            mainLabel.heightAnchor.constraint(equalToConstant: 34),
            mainLabel.bottomAnchor.constraint(equalTo: coloredRectangleView.bottomAnchor, constant: -12),

            nonColoredRectangleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nonColoredRectangleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nonColoredRectangleView.topAnchor.constraint(equalTo: coloredRectangleView.bottomAnchor),
            nonColoredRectangleView.heightAnchor.constraint(equalToConstant: 58),

            coloredCircleButton.trailingAnchor.constraint(equalTo: nonColoredRectangleView.trailingAnchor, constant: -12),
            coloredCircleButton.bottomAnchor.constraint(equalTo: nonColoredRectangleView.bottomAnchor, constant: -16),
            coloredCircleButton.widthAnchor.constraint(equalToConstant: 34),
            coloredCircleButton.heightAnchor.constraint(equalToConstant: 34),

            daysCounterLabel.centerYAnchor.constraint(equalTo: coloredCircleButton.centerYAnchor),
            daysCounterLabel.leadingAnchor.constraint(equalTo: nonColoredRectangleView.leadingAnchor, constant: 12)
        ])
    }

    // добавляем метод configure
    func configure(with tracker: Tracker) {
        mainLabel.text = tracker.name
        emojiLabel.text = tracker.emoji
        coloredRectangleView.backgroundColor = tracker.color // Устанавливаем цвет прямо из tracker
        coloredCircleButton.backgroundColor = coloredRectangleView.backgroundColor

        // Предполагается, что daysCounter будет как-то учитываться или обновляться вне этого метода
        //  updateDaysCounterLabel()
    }
}
