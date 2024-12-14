//
//  fabric-method.swift
//  swift-patterns
//
//  Created by Vasiliy Fedotov on 14.12.2024.
//

import Foundation

/// Написано по статье https://tproger.ru/translations/design-patterns-simple-words-1#12

/// Допустим, мы HRы и нам нужно проинтервьюить нового кандидата.
/// Кандидаты могут быть разных профессий. Для каждой профессии свой набор интервьюеров.
/// HR-менеджер использует разные фабрики интервьюеров для каждого из кандидатов
class Candidate {
    private let name: String

    init(withName name: String) {
        self.name = name
    }

    func sayHello() {
        print("Привет, я \(name)")
    }
}

protocol Interviewer {
    func interviewCandidate(_ candidate: Candidate)
}

class LanguageInterviewer: Interviewer {
    func interviewCandidate(_ candidate: Candidate) {
        print("Проверка на знание языка")
    }
}

final class AlgoInterviewer: Interviewer {
    func interviewCandidate(_ candidate: Candidate) {
        print("Проверка на знание алгоритмов")
    }
}

final class SoftSkillInterviewer: Interviewer {
    func interviewCandidate(_ candidate: Candidate) {
        print("Проверка на софт-скиллы")
    }
}

final class Manager: Interviewer {
    func interviewCandidate(_ candidate: Candidate) {
        print("Собеседование с менеджером")
    }
}

final class InterviewerComposite: Interviewer {
    private let interviewers: [any Interviewer]

    init(interviewers: [any Interviewer]) {
        self.interviewers = interviewers
    }

    func interviewCandidate(_ candidate: Candidate) {
        interviewers.forEach {
            $0.interviewCandidate(candidate)
        }
    }
}

protocol InterviewerFactory {
    func makeInterviewer() -> Interviewer
}

final class LinguistInterviewerFactory: InterviewerFactory {
    func makeInterviewer() -> Interviewer {
        return InterviewerComposite(
            interviewers: [
                LanguageInterviewer(),
                SoftSkillInterviewer(),
                Manager(),
            ]
        )
    }
}

final class AlgoritmistInterviewerFactory: InterviewerFactory {
    func makeInterviewer() -> Interviewer {
        return InterviewerComposite(
            interviewers: [
                AlgoInterviewer(),
                Manager(),
            ]
        )
    }
}

final class CoderInterviewerFactory: InterviewerFactory {
    func makeInterviewer() -> Interviewer {
        return InterviewerComposite(
            interviewers: [
                LanguageInterviewer(),
                AlgoInterviewer(),
                SoftSkillInterviewer(),
                Manager(),
            ]
        )
    }
}

class HiringManager {
    var interviewerFactory: InterviewerFactory!

    func makeInterview(_ candidate: Candidate) {
        candidate.sayHello()

        let interviewer = interviewerFactory.makeInterviewer()
        interviewer.interviewCandidate(candidate)

        print("\n")
    }
}


final class AbstractFactory {
    func execute() {

        let hr = HiringManager()

        let linguistCandidate = Candidate(withName: "лингвист")
        hr.interviewerFactory = LinguistInterviewerFactory()
        hr.makeInterview(linguistCandidate)

        let algoritmistCandidate = Candidate(withName: "алгоритмист")
        hr.interviewerFactory = AlgoritmistInterviewerFactory()
        hr.makeInterview(algoritmistCandidate)

        let coderCandidate = Candidate(withName: "программист")
        hr.interviewerFactory = CoderInterviewerFactory()
        hr.makeInterview(coderCandidate)
    }
}

