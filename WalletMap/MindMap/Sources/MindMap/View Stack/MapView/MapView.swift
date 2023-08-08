/// Copyright (c) 2020 Razeware LLC

import SwiftUI

public struct MapView: View {
    @ObservedObject var selection: SelectionHandler
    @ObservedObject var mesh: Mesh

    @State private(set) var backgroundColor = Color.orange

    public init(selection: SelectionHandler, mesh: Mesh, backgroundColor: SwiftUI.Color = Color.orange) {
        self.selection = selection
        self.mesh = mesh
        self.backgroundColor = backgroundColor
    }

    public var body: some View {
        ZStack {
            Rectangle().fill(backgroundColor)
            EdgeMapView(edges: $mesh.links)
            NodeMapView(selection: selection, nodes: $mesh.nodes)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        let mesh = Mesh()
        let child1 = Node(position: CGPoint(x: 100, y: 200), text: "child 1")
        let child2 = Node(position: CGPoint(x: -100, y: 200), text: "child 2")
        [child1, child2].forEach {
            mesh.addNode($0)
            mesh.connect(mesh.rootNode(), to: $0)
        }
        mesh.connect(child1, to: child2)
        let selection = SelectionHandler()
        return MapView(selection: selection, mesh: mesh)
    }
}
