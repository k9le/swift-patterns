//
//  mediator-01.swift
//  swift-patterns
//
//  Created by Vasiliy Fedotov on 26.01.2025.
//

import Foundation

/// написано по статье https://github.com/iluwatar/java-design-patterns/tree/master/mediator

private enum Action {
    case attack
    case tellStory
    case findTreasure
    case drinkWine
}

private protocol IParty {
    func addMember(_ member: IMember)
    func act(_ member: IMember, _ action: Action)
}

private protocol IMember: AnyObject {
    var party: (any IParty)? { get }
    func joinedParty(_ party: IParty)
    func reactForAction(_ action: Action)
    func applyAction(_ action: Action)
}


private class Party: IParty {
    private var members: [IMember] = []
    
    func addMember(_ member: IMember) {
        members.append(member)
        member.joinedParty(self)
    }
    
    func act(_ member: IMember, _ action: Action) {
        for m in members where m !== member {
            m.reactForAction(action)
        }
    }
}

private class Knight: IMember {
    var party: IParty?

    func joinedParty(_ party: any IParty) {
        print("Knight: <joined to party>")
        self.party = party
    }
    
    func reactForAction(_ action: Action) {
        switch action {
        case .attack:
            print("Knight: I'm ready to fight!")
        case .drinkWine:
            print("Knight: I can't drink wine!")
        case .findTreasure:
            print("Knight: Fight for the treasure!")
        case .tellStory:
            print("Knight: Ohh, so interesting!")

        }
    }
    
    func applyAction(_ action: Action) {
        switch action {
        case .attack:
            print("Knight: <start fighting>")
        default:
            break
        }
        party?.act(self, action)
    }
}

private class Hobbit: IMember {
    var party: IParty?

    func joinedParty(_ party: any IParty) {
        print("Hobbit: <joined to party>")
        self.party = party
    }

    func reactForAction(_ action: Action) {
        switch action {
        case .attack:
            print("Hobbit: <running away>")
        case .drinkWine:
            print("Hobbit: I have drunk too much today")
        case .findTreasure:
            print("Hobbit: Give me my part")
        case .tellStory:
            print("Hobbit: I know better story. Listen to me")

        }
    }

    func applyAction(_ action: Action) {
        switch action {
        case .drinkWine:
            print("Hobbit: So good wine i have!")
        default:
            break
        }
        party?.act(self, action)
    }
}

private class Wizard: IMember {
    var party: IParty?

    func joinedParty(_ party: any IParty) {
        print("Hobbit: <joined to party>")
        self.party = party
    }

    func reactForAction(_ action: Action) {
        switch action {
        case .attack:
            print("Wizard: <running away>")
        case .drinkWine:
            print("Wizard: Wine is not for wizards")
        case .findTreasure:
            print("Wizard: Take the biggest part")
        case .tellStory:
            print("Wizard: That is not true")

        }
    }

    func applyAction(_ action: Action) {
        switch action {
        case .findTreasure:
            print("Wizard: I found treasure!!!")
        default:
            break
        }
        party?.act(self, action)
    }
}

final class Mediator01 {
    func execute() {
        let party = Party()

        let hobbit = Hobbit()
        let wizard = Wizard()
        let knight = Knight()

        party.addMember(hobbit)
        party.addMember(wizard)
        party.addMember(knight)
        
        hobbit.applyAction(.drinkWine)
        knight.applyAction(.attack)
        wizard.applyAction(.findTreasure)
    }
}
