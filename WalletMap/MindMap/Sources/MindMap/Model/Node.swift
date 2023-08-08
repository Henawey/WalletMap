/// Copyright (c) 2020 Razeware LLC

import Foundation
import CoreGraphics

public typealias NodeID = UUID

public struct Node: Identifiable {
    public var id: NodeID = NodeID()
    public var position: CGPoint = .zero
    public var text: String = ""
    public var subtext: String = ""

    var visualID: String {
        return id.uuidString
        + "\(text.hashValue)"
    }
}

extension Node {
    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.id == rhs.id
    }
}
