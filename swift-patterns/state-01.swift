//
//  state-01.swift
//  swift-patterns
//
//  Created by Vasiliy Fedotov on 22.01.2025.
//

import Foundation

private protocol IWritingState {
    func write(_ string: String) 
}

private struct UppercaseWritingState: IWritingState {
    func write(_ string: String) {
        print(string.uppercased())
    }
}

private struct LowercasedWritingState: IWritingState {
    func write(_ string: String) {
        print(string.lowercased())
    }
}

private struct CamelcasedWritingState: IWritingState {
    func write(_ string: String) {
        print(string.split(separator: " ").map(\.capitalized).joined(separator: " "))
    }
}

private final class TextEditor {
    private var writingState: IWritingState = LowercasedWritingState()
    func setWritingState(_ state: IWritingState) {
        self.writingState = state
    }

    func write(_ string: String) {
        writingState.write(string)
    }
}


final class State01 {
    func execute() {
        let textEditor = TextEditor()
        let states: [any IWritingState] = [LowercasedWritingState(), UppercaseWritingState(), CamelcasedWritingState(), LowercasedWritingState()]
        for i in states {
            textEditor.setWritingState(i)
            textEditor.write("one two there")
        }
    }
}
