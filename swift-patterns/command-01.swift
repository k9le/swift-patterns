//
//  command-01.swift
//  swift-patterns
//
//  Created by Vasiliy Fedotov on 16.12.2024.
//

import Foundation

/// Написано по статье https://tproger.ru/translations/design-patterns-simple-words-3#32

private struct TVState {
    let isOn: Bool
    let channel: Int
}

private class TV {
    var isOn = false
    var channel: Int = 1

    var state: TVState {
        TVState(isOn: isOn, channel: channel)
    }

    func setState(_ state: TVState) {
        isOn = state.isOn
        channel = state.channel
        printState()
    }

    func printState() {
        isOn ? print("Телевизор включен, канал \(channel)") : print("Телевизор выключен")
    }

    func turnOn() {
        isOn = true
        printState()
    }

    func turnOff() {
        isOn = false
        printState()
    }

    func setChannel(_ i: Int) {
        channel = i
        print("Включен \(i) канал")
    }
}

private protocol ICommand {
    func execute() -> Bool
    func undo()
    func redo()
}

private final class TurnTVOnCommand: ICommand {
    let tv: TV
    var previosState: TVState?

    init(tv: TV) {
        self.tv = tv
    }

    func execute() -> Bool {
        guard !tv.isOn else { return true }
        previosState = tv.state
        tv.turnOn()
        return true
    }

    func undo() {
        guard let previosState else { return }
        tv.setState(previosState)
    }

    func redo() {
        let _ = execute()
    }
}

private final class TurnTVOffCommand: ICommand {
    let tv: TV
    var previosState: TVState?

    init(tv: TV) {
        self.tv = tv
    }

    func execute() -> Bool {
        guard tv.isOn else { return true }
        previosState = tv.state
        tv.turnOff()
        return true
    }

    func undo() {
        guard let previosState else { return }
        tv.setState(previosState)
    }

    func redo() {
        let _ = execute()
    }
}

private final class TurnTVChannelCommand: ICommand {
    let tv: TV
    var previosState: TVState?
    let channel: Int

    init(tv: TV, channel: Int) {
        self.tv = tv
        self.channel = channel
    }

    func execute() -> Bool {
        guard tv.isOn else {
            print("Невозможно переключить канал, телевизор выключен")
            return false
        }
        guard channel != tv.channel else { return true }
        previosState = tv.state
        tv.setChannel(channel)
        return true
    }

    func undo() {
        guard let previosState else { return }
        tv.setState(previosState)
    }

    func redo() {
        let _ = execute()
    }
}


private final class Receiver {
    func submit(_ command: any ICommand) -> Bool {
        command.execute()
    }

    func redo(_ command: any ICommand) {
        command.redo()
    }

    func undo(_ command: any ICommand) {
        command.undo()
    }
}

final class Command01 {
    func execute() {

        let tv = TV()
        let commands = [0,1,3,6,4,5,-1,3,9,10].map { (val) -> ICommand in
            switch val {
            case 0: return TurnTVOnCommand(tv: tv)
            case -1: return TurnTVOffCommand(tv: tv)
            default: return TurnTVChannelCommand(tv: tv, channel: val)
            }
        }

        let receiver = Receiver()

        for ci in 0..<commands.count where !receiver.submit(commands[ci]) {
            for i in stride(from: ci - 1, to: -1, by: -1) {
                receiver.undo(commands[i])
            }
            break
        }
    }
}

