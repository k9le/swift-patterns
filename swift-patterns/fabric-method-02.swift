//
//  fabric-method-02.swift
//  swift-patterns
//
//  Created by Vasiliy Fedotov on 18.12.2024.
//

import Foundation

/// Написано по статье https://github.com/iluwatar/java-design-patterns/tree/master/factory-method

private protocol IDelivery {
    var name: String { get }
    func handleByParcel()
}

private struct StandardDelivery: IDelivery {
    var name: String { "StandardDelivery" }
    func handleByParcel() {
        print("This is handle of standard delivery")
    }
}

private struct ExpressDelivery: IDelivery {
    var name: String { "ExpressDelivery" }
    func handleByParcel() {
        print("Express delivery is very fast")
    }
}

private struct OversizedDelivery: IDelivery {
    var name: String { "OversizedDelivery" }
    func handleByParcel() {
        print("Oversized delivery costs overprice")
    }
}

private protocol IDeliveryFactory {
    func make() -> IDelivery
}

private struct StandardDeliveryFactory: IDeliveryFactory {
    func make() -> IDelivery { StandardDelivery() }
}

private struct ExpressDeliveryFactory: IDeliveryFactory {
    func make() -> IDelivery { ExpressDelivery() }
}

private struct OversizedDeliveryFactory: IDeliveryFactory {
    func make() -> IDelivery { OversizedDelivery() }
}

final class FabricMethod02 {
    func execute() {

        var deliveryFactory: IDeliveryFactory
        if /*standard*/ true {
            deliveryFactory = StandardDeliveryFactory()
        } else if /* is it overweight */ false {
            deliveryFactory = OversizedDeliveryFactory()
        }

        let delivery = deliveryFactory.make()

        delivery.handleByParcel()
    }
}
