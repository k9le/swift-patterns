//
//  visitor-01.swift
//  swift-patterns
//
//  Created by Vasiliy Fedotov on 17.12.2024.
//

import Foundation

/// Написано по статье https://refactoring.guru/ru/design-patterns/visitor


private protocol Action {
    func applyForMonument(_ m: Monument)
    func applyForRestaurant(_ m: Restaurant)
    func applyForTheater(_ m: Theater)
}

private protocol Appliable {
    func apply(_ action: any Action)
}

private struct Monument: Appliable {
    let personName: String
    func apply(_ action: any Action) {
        action.applyForMonument(self)
    }
}

private struct Restaurant: Appliable {
    let cuisine: String
    func apply(_ action: any Action) {
        action.applyForRestaurant(self)
    }
}

private struct Theater: Appliable {
    let name: String
    func apply(_ action: any Action) {
        action.applyForTheater(self)
    }
}

private struct PrintAction: Action {
    func applyForMonument(_ m: Monument) {
        print("Памятник \(m.personName)")
    }

    func applyForRestaurant(_ m: Restaurant) {
        print("Вкусная \(m.cuisine) кухня в ресторане")
    }

    func applyForTheater(_ m: Theater) {
        print("Отвратительный \(m.name)")
    }
}

private struct ExportAction: Action {
    let filename: String
    func applyForMonument(_ m: Monument) {
        print("Памятник \(m.personName) экспортирован в \(filename)")
    }

    func applyForRestaurant(_ m: Restaurant) {
        print("\(m.cuisine) кухня экспортирована в \(filename)")
    }

    func applyForTheater(_ m: Theater) {
        print("Отвратительный \(m.name) выпилен из \(filename)")
    }
}

final class Visitor01 {
    func execute() {
        let appl: [any Appliable] = [
            Monument(personName: "Циолковский"), Monument(personName: "Гагарин"),
            Restaurant(cuisine: "мадагаскарская"), Restaurant(cuisine: "папуасская"),
            Theater(name: "МХАТ"), Theater(name: "Таганка"),
        ]

        let printAction = PrintAction(), exportAction = ExportAction(filename: "file.xml")

        appl.forEach {
            $0.apply(printAction)
        }

        appl.forEach {
            $0.apply(exportAction)
        }
    }
}

