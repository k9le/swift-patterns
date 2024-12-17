//
//  bridge-01.swift
//  swift-patterns
//
//  Created by Vasiliy Fedotov on 17.12.2024.
//

import Foundation

/// Написано по статье https://tproger.ru/translations/design-patterns-simple-words-2#22

private protocol Theme {
    var desription: String { get }
}

private struct LightTheme: Theme {
    var desription: String { "Светлая тема" }
}

private struct DarkTheme: Theme {
    var desription: String { "Темная тема" }
}

private protocol WebPage {
    var theme: any Theme { get }
    func showContent()
}

private struct AboutPage: WebPage {
    var theme: any Theme
    func showContent() {
        print("Контакты, \(theme.desription)")
    }
}

private struct MainPage: WebPage {
    var theme: any Theme
    func showContent() {
        print("Главная страница, \(theme.desription)")
    }
}

final class Bridge01 {
    func execute() {
        let lightTheme = LightTheme(), darkTheme = DarkTheme()
        var aboutPage = AboutPage(theme: lightTheme), mainPage = MainPage(theme: lightTheme)

        aboutPage.showContent()
        mainPage.showContent()

        aboutPage.theme = darkTheme
        mainPage.theme = darkTheme

        aboutPage.showContent()
        mainPage.showContent()
    }
}

