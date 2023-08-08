/// Copyright (c) 2020 Razeware LLC

import Foundation
import CoreGraphics
import MindMap

extension Mesh {
  static func sampleMesh() -> Mesh {
    let mesh = Mesh()
    mesh.updateNodeText(mesh.rootNode(), string: "every human has a right to", subtext: "23100")
    [(0, "shelter", "6100"),
     (120, "food", "5000"),
     (240, "education", "12000")].forEach { (angle, name, cost) in
      let point = mesh.pointWithCenter(center: .zero, radius: 200, angle: angle.radians)
      let node = mesh.addChild(mesh.rootNode(), at: point)
      mesh.updateNodeText(node, string: name, subtext: cost)
    }
    return mesh
  }

  static func sampleProceduralMesh() -> Mesh {
    let mesh = Mesh()
    //seed root node with 3 children
    [0, 1, 2, 3].forEach { index in
      let point = mesh.pointWithCenter(center: .zero, radius: 400, angle: (index * 90 + 30).radians)
      let node = mesh.addChild(mesh.rootNode(), at: point)
      mesh.updateNodeText(node, string: "A\(index + 1)", subtext: "B\(index + 1)")
      mesh.addChildrenRecursive(to: node, distance: 200, generation: 1)
    }
    return mesh
  }

  func addChildrenRecursive(to node: Node, distance: CGFloat, generation: Int) {
    let labels = ["A", "B", "C", "D", "E", "F"]
    guard generation < labels.count else {
      return
    }

    let childCount = Int.random(in: 1..<4)
    var count = 0
    while count < childCount {
      count += 1
      let position = positionForNewChild(node, length: distance)
      let child = addChild(node, at: position)
      updateNodeText(child, string: "\(labels[generation])\(count + 1)", subtext: "\(labels[generation])\(count + 1)")
      addChildrenRecursive(to: child, distance: distance + 200.0, generation: generation + 1)
    }
  }
}

extension Int {
  var radians: CGFloat {
    CGFloat(self) * CGFloat.pi/180.0
  }
}
