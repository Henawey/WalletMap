/// Copyright (c) 2020 Razeware LLC

import Foundation
import CoreGraphics

public class Mesh: ObservableObject {
    let rootNodeID: NodeID
    @Published public var nodes: [Node] = []
    @Published var editingText: String

    public init() {
        self.editingText = ""
        let root = Node(text: "root")
        rootNodeID = root.id
        addNode(root)
    }

    var edges: [Edge] = [] {
        didSet {
            rebuildLinks()
        }
    }
    @Published var links: [EdgeProxy] = []

    func rebuildLinks() {
        links = edges.compactMap { edge in
            let snode = nodes.filter({ $0.id == edge.start }).first
            let enode = nodes.filter({ $0.id == edge.end }).first
            if let snode = snode, let enode = enode {
                return EdgeProxy(id: edge.id, start: snode.position, end: enode.position)
            }
            return nil
        }
    }

    public func rootNode() -> Node {
        guard let root = nodes.filter({ $0.id == rootNodeID }).first else {
            fatalError("mesh is invalid - no root")
        }
        return root
    }

    func nodeWithID(_ nodeID: NodeID) -> Node? {
        return nodes.filter({ $0.id == nodeID }).first
    }

    func replace(_ node: Node, with replacement: Node) {
        var newSet = nodes.filter { $0.id != node.id }
        newSet.append(replacement)
        nodes = newSet
    }
}

extension Mesh {
    public func updateNodeText(_ srcNode: Node, string: String, subtext: String) {
        var newNode = srcNode
        newNode.text = string
        newNode.subtext = subtext
        replace(srcNode, with: newNode)
    }

    func positionNode(_ node: Node, position: CGPoint) {
        var movedNode = node
        movedNode.position = position
        replace(node, with: movedNode)
        rebuildLinks()
    }

    public func processNodeTranslation(_ translation: CGSize, nodes: [DragInfo]) {
        nodes.forEach { draginfo in
            if let node = nodeWithID(draginfo.id) {
                let nextPosition = draginfo.originalPosition.translatedBy(x: translation.width, y: translation.height)
                self.positionNode(node, position: nextPosition)
            }
        }
    }
}

extension Mesh {
    func addNode(_ node: Node) {
        nodes.append(node)
    }

    func connect(_ parent: Node, to child: Node) {
        let newedge = Edge(start: parent.id, end: child.id)
        let exists = edges.contains(where: { edge in
            return newedge == edge
        })

        guard exists == false else {
            return
        }

        edges.append(newedge)
    }
}

extension Mesh {
    @discardableResult public func addChild(_ parent: Node, at point: CGPoint? = nil) -> Node {
        let target = point ?? parent.position
        let child = Node(position: target, text: "child")
        addNode(child)
        connect(parent, to: child)
        rebuildLinks()
        return child
    }

    @discardableResult func addSibling(_ node: Node) -> Node? {
        guard node.id != rootNodeID else {
            return nil
        }

        let parentedges = edges.filter({ $0.end == node.id })
        if
            let parentedge = parentedges.first,
            let parentnode = nodeWithID(parentedge.start) {
            let sibling = addChild(parentnode)
            return sibling
        }
        return nil
    }

    func deleteNodes(_ nodesToDelete: [NodeID]) {
        for id in nodesToDelete where id != rootNodeID {
            if let delete = nodes.firstIndex(where: { $0.id == id }) {
                nodes.remove(at: delete)
                let remainingEdges = edges.filter({ $0.end != id && $0.start != id })
                edges = remainingEdges
            }
        }
        rebuildLinks()
    }

    func deleteNodes(_ nodesToDelete: [Node]) {
        deleteNodes(nodesToDelete.map({ $0.id }))
    }
}

extension Mesh {
    func locateParent(_ node: Node) -> Node? {
        let parentedges = edges.filter { $0.end == node.id }
        if let parentedge = parentedges.first,
           let parentnode = nodeWithID(parentedge.start) {
            return parentnode
        }
        return nil
    }

    public func distanceFromRoot(_ node: Node, distance: Int = 0) -> Int? {
        if node.id == rootNodeID { return distance }

        if let ancestor = locateParent(node) {
            if ancestor.id == rootNodeID {
                return distance + 1
            } else {
                return distanceFromRoot(ancestor, distance: distance + 1)
            }
        }
        return nil
    }
}
