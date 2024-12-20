//
//  composite-01.swift
//  swift-patterns
//
//  Created by Vasiliy Fedotov on 20.12.2024.
//

import Foundation

/// написано по https://tproger.ru/translations/design-patterns-simple-words-2#23

private protocol IWork {}

private class Work: IWork {}

private protocol Assignee {
    func canHandle(_ work: IWork)
    func doWork(_ work: IWork)
}

private struct Developer: Assignee {
    func canHandle(_ work: IWork) {}
    func doWork(_ work: IWork) {}
}

private struct Tester: Assignee {
    func canHandle(_ work: IWork) {}
    func doWork(_ work: IWork) {}
}

private struct Manager: Assignee {
    func canHandle(_ work: IWork) {}
    func doWork(_ work: IWork) {}
}

private struct Team: Assignee {
    let members: [Assignee]
    func canHandle(_ work: IWork) {}
    func doWork(_ work: IWork) {}
}

final class Composite01 {
    func execute() {
        let dev1 = Developer(), dev2 = Developer()
        let tester1 = Tester(), tester2 = Tester()
        let m1 = Manager(), m2 = Manager()
        let team1 = Team(members: [dev1, tester1, tester2, m1])
        let team2 = Team(members: [dev2, tester1, tester2, m2])
        let arr: [Assignee] = [
            dev1,
            dev2,
            tester1,
            tester2,
            m1,
            m2,
            team1,
            team2
        ]

        let work = Work()
        for i in arr {
            i.doWork(work)
        }
    }
}

