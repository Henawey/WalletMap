import Foundation
import CoreGraphics

public struct DragInfo {
    var id: NodeID
    var originalPosition: CGPoint
}

public class SelectionHandler: ObservableObject {
    @Published public private(set) var draggingNodes: [DragInfo] = []
    @Published private(set) var selectedNodeIDs: [NodeID] = []

    @Published public var editingText: String = ""

    public init() {}

    public func selectNode(_ node: Node) {
        selectedNodeIDs = [node.id]
        editingText = node.text
    }

    func isNodeSelected(_ node: Node) -> Bool {
        return selectedNodeIDs.contains(node.id)
    }

    func selectedNodes(in mesh: Mesh) -> [Node] {
        return selectedNodeIDs.compactMap { mesh.nodeWithID($0) }
    }

    public func onlySelectedNode(in mesh: Mesh) -> Node? {
        let selectedNodes = self.selectedNodes(in: mesh)
        if selectedNodes.count == 1 {
            return selectedNodes.first
        }
        return nil
    }

    public func startDragging(_ mesh: Mesh) {
        draggingNodes = selectedNodes(in: mesh)
            .map { DragInfo(id: $0.id, originalPosition: $0.position) }
    }

    public func stopDragging(_ mesh: Mesh) {
        draggingNodes = []
    }
}
