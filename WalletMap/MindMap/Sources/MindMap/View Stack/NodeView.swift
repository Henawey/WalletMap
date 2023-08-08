/// Copyright (c) 2020 Razeware LLC

import SwiftUI

public struct NodeView: View {
    public static let width = CGFloat(100)
    // 1
    @State var node: Node
    //2
    @ObservedObject var selection: SelectionHandler
    //3
    var isSelected: Bool {
        return selection.isNodeSelected(node)
    }
    
    @State private(set) var fillColor = Color.green
    @State private(set) var selectedColor = Color.red
    @State private(set) var frameColor = Color.black
    
    public var body: some View {
        Capsule(style: .continuous)
            .fill(fillColor)
            .overlay(Capsule(style: .continuous)
                .stroke(isSelected ? selectedColor : frameColor, lineWidth: isSelected ? 5 : 3))
            .overlay(VStack {
                Text(node.text)
                Text(node.subtext)
            }
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)))
            .frame(width: NodeView.width * 2, height: NodeView.width, alignment: .center)
    }
}

struct NodeView_Previews: PreviewProvider {
    static var previews: some View {
        let selection1 = SelectionHandler()
        let node1 = Node(text: "hello world", subtext: "subtext")
        let selection2 = SelectionHandler()
        let node2 = Node(text: "I'm selected, look at me", subtext: "subtext 2")
        selection2.selectNode(node2)
        
        return VStack {
            NodeView(node: node1, selection: selection1)
            NodeView(node: node2, selection: selection2)
        }
    }
}
