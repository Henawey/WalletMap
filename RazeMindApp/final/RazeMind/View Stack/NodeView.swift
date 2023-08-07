/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

struct NodeView: View {
  static let width = CGFloat(100)
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
  
  var body: some View {
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
