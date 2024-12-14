//
//  chain-of-responsibility.swift
//  swift-patterns
//
//  Created by Vasiliy Fedotov on 14.12.2024.
//

import Foundation

/// Написано по статье https://tproger.ru/translations/design-patterns-simple-words-3#31

protocol PaymentType {
    var name: String { get }
    var balance: Int { get }
}

extension PaymentType {
    func payIfPossible(_ amount: Int) -> Bool {
        guard balance >= amount else {
            print("payment by \(name) isn't possible (\(balance) < \(amount))")
            return false
        }

        print("payment by \(name) accepted")
        return true
    }
}

final class PaymentA: PaymentType {
    var name: String { "card" }
    var balance: Int { 100 }
}

final class PaymentB: PaymentType {
    var name: String { "cash" }
    var balance: Int { 200 }
}

final class PaymentC: PaymentType {
    var name: String { "gold" }
    var balance: Int { 350 }
}

final class PaymentD: PaymentType {
    var name: String { "antimatter" }
    var balance: Int { 2000 }
}

class PaymentChainring {
    let next: PaymentChainring?
    let payment: PaymentType

    init(next: PaymentChainring? = nil, payment: any PaymentType) {
        self.next = next
        self.payment = payment
    }

    func pay(_ amount: Int) {
        guard !payment.payIfPossible(amount) else { return }
        next?.pay(amount)
    }
}

final class ChainOfResponibility {
    func execute() {
        let paymentD = PaymentChainring(next: nil, payment: PaymentD())
        let paymentC = PaymentChainring(next: paymentD, payment: PaymentC())
        let paymentB = PaymentChainring(next: paymentC, payment: PaymentB())
        let paymentA = PaymentChainring(next: paymentB, payment: PaymentA())

        for amount in [1, 100, 215, 350, 700, 4000] {
            print("try to pay \(amount)")
            paymentA.pay(amount)
            print("\n")
        }
    }
}

