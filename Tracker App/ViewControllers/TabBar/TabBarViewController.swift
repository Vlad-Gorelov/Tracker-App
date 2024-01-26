//
//  TabBarViewController.swift
//  Tracker App
//
//  Created by Владислав Горелов on 12.01.2024.
//

import UIKit

final class TabBarViewController: UITabBarController {

    override func viewDidLoad() {

        super.viewDidLoad()

        // Создание вкладок
        let trackerVC = TrackerViewController()
        let statisticVC = StatisticViewController()

        // Установка контроллеров вкладок
        trackerVC.tabBarItem = UITabBarItem(
            title: "Трекеры",
            image: UIImage(named: "trackersIcon"),
            selectedImage: UIImage(named: "trackersIcon")
        )

        statisticVC.tabBarItem = UITabBarItem(
            title: "Статистика",
            image: UIImage(named: "statsIcon"),
            selectedImage: UIImage(named: "statsIcon")
        )

        // Установка контроллеров в таббар
        viewControllers = [createNavigationController(rootViewController: trackerVC),
                           createNavigationController(rootViewController: statisticVC)]

        // Создание и настройка UIView для полосы
        let separatorLine = UIView()
        separatorLine.backgroundColor = .ypGray // Цвет полосы
        separatorLine.translatesAutoresizingMaskIntoConstraints = false

        // Добавление UIView на таббар
        tabBar.addSubview(separatorLine)

        // Настройка ограничений для полосы
        NSLayoutConstraint.activate([
            separatorLine.topAnchor.constraint(equalTo: tabBar.topAnchor),
            separatorLine.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            separatorLine.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
            separatorLine.heightAnchor.constraint(equalToConstant: 1) // Толщина полосы
        ])
    }

    private func createNavigationController(rootViewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        return navigationController
    }
}
