protocol Fillable {
    var color: String { set get }
}

protocol VisualComponent: Fillable {
    //минимално покриващ правоъгълник
    var boundingBox: Rect { get }
    var parent: VisualComponent? { get }
    func draw()
}

protocol VisualGroup: VisualComponent {
    //броят деца
    var numChildren: Int { get }
    //списък от всички деца
    var children: [VisualComponent] { get }
    //добавяне на дете
    mutating func add(child: VisualComponent)
    //премахване на дете
    mutating func remove(child: VisualComponent)
    //премахване на дете от съответния индекс - 0 базиран
    mutating func removeChild(at: Int)
}

struct Point {
    var x: Double
    var y: Double
}

extension Point: Equatable {
     static func == (lhs: Point, rhs: Point) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}

struct Rect {
    //top-left
    var top: Point
    var width: Double
    var height: Double
    
    init(x: Double, y: Double, width: Double, height: Double) {
        top = Point(x: x, y: y)
        self.width = width
        self.height = height
    }

    func union(with other: Rect) -> Rect {
        let left = min(self.top.x, other.top.x)
        let top = min(self.top.y, other.top.y)
        let right = max(self.top.x + self.width, other.top.x + other.width)
        let bottom = max(self.top.y + self.height, other.top.y + other.height)
        return Rect(x: left, y: top, width: right - left, height: bottom - top)
    }

}

extension Rect: Equatable {
     static func == (lhs: Rect, rhs: Rect) -> Bool {
        return lhs.top == rhs.top && lhs.width == rhs.width && lhs.height == rhs.height
    }
}

//ако предпочитате класове
//add implementation details below
class Triangle: VisualComponent {
    var boundingBox: Rect
    var color: String
    
    var parent: VisualComponent?

    var a: Point
    var b: Point
    var c: Point
    
    func draw() {
        print("\(color) triangle(\(a.x), \(a.y), \(b.x), \(b.y), \(c.x), \(c.y))")
    }
    
    init(a: Point, b: Point, c: Point, color: String) {
        self.color = color
        self.a = a
        self.b = b
        self.c = c
        self.boundingBox = Rect(x: min(a.x, b.x, c.x), y: min(a.y, b.y, c.y), width: max(a.x, b.x, c.x) - min(a.x, b.x, c.x), height: max(a.y, b.y, c.y) - min(a.y, b.y, c.y))
    }
}

extension Triangle: Equatable {
     static func == (lhs: Triangle, rhs: Triangle) -> Bool {
        return lhs.a == rhs.a && lhs.b == rhs.b && lhs.c == rhs.c && lhs.color == rhs.color
    }
}

extension Triangle {
    convenience init(a: Point, b: Point, c: Point, color: String, parent: VisualComponent?) {
        self.init(a: a, b: b, c: c, color: color)
        self.parent = parent
}

    
}

class Rectangle: VisualComponent {
    var boundingBox: Rect
    var color: String
    
    var parent: VisualComponent?

    var rect: Rect
    
    func draw() {
        print("\(color) rectangle((\(rect.top.x), \(rect.top.y)), width:\(rect.width), height:\(rect.height))")
    }
    
    init(x: Int, y: Int, width: Int, height: Int, color: String) {
        self.color = color
        self.rect = Rect(x: Double(x), y: Double(y), width: Double(width), height: Double(height))
        self.boundingBox = self.rect
    }
}

extension Rectangle: Equatable {
     static func == (lhs: Rectangle, rhs: Rectangle) -> Bool {
        return lhs.rect == rhs.rect && lhs.color == rhs.color
    }
}

extension Rectangle {
    convenience init(x: Int, y: Int, width: Int, height: Int, color: String, parent: VisualComponent?) {
        self.init(x: x, y: y, width: width, height: height, color: color)
        self.parent = parent
    }
}

class Circle: VisualComponent {
    var boundingBox: Rect
    var color: String
    
    var parent: VisualComponent?

    var center: Point
    var radius: Double
    
    func draw() {
        print("\(color) circle(center:(\(center.x), \(center.y)), r=\(radius))")
    }
    
    init(x: Int, y:Int, r: Double, color: String) {
        self.color = color
        self.center = Point(x: Double(x), y: Double(y))
        self.radius = r
        self.boundingBox = Rect(x: self.center.x - r, y: self.center.y - r, width: 2 * r, height: 2 * r)
    }
}

extension Circle: Equatable {
     static func == (lhs: Circle, rhs: Circle) -> Bool {
        return lhs.center == rhs.center && lhs.radius == rhs.radius && lhs.color == rhs.color
    }
}

extension Circle {
    convenience init(x: Int, y:Int, r: Double, color: String, parent: VisualComponent?) {
        self.init(x: x, y: y, r: r, color: color)
        self.parent = parent
    }
}

class Path: VisualComponent {
    var boundingBox: Rect
    var color: String
    var parent: VisualComponent?

    var points: [Point]
    
    func draw() {
        print("\(color) path:")
        for i in 0..<points.count {
            print("point(\(points[i].x), \(points[i].y))")
        }
    }
    
    init(points: [Point], color: String) {
        self.color = color
        self.points = points
        self.boundingBox = Rect(x: points[0].x, y: points[0].y, width: 0, height: 0)
    }
}

extension Path: Equatable {
     static func == (lhs: Path, rhs: Path) -> Bool {
        if lhs.points.count != rhs.points.count || lhs.color != rhs.color {
            return false
        } else {
            for i in 0..<lhs.points.count {
                if lhs.points[i] != rhs.points[i] {
                    return false
                }
            }
            return true
        }
    }
}

extension Path {
    convenience init(points: [Point], color: String, parent: VisualComponent?) {
        self.init(points: points, color: color)
        self.parent = parent
    }
}

class VStack: VisualGroup {
    var numChildren: Int
    var color: String
    
    var children: [VisualComponent]
    
    func add(child: VisualComponent) {
        //child.parent = self
        self.children.append(child)
        numChildren += 1
        self.boundingBox = self.boundingBox.union(with:child.boundingBox)
    }
    
    func remove(child: VisualComponent) {
        let triangle = child as? Triangle
        if triangle != nil {
            for i in 0..<children.count {
                if children[i] as? Triangle == triangle {
                    children.remove(at: i)
                    numChildren -= 1
                }
            }
            return
        }
        let rectangle = child as? Rectangle
        if rectangle != nil {
            for i in 0..<children.count {
                if children[i] as? Rectangle == rectangle {
                    children.remove(at: i)
                    numChildren -= 1
                }
            }
            return
        }
        let circle = child as? Circle
        if circle != nil {
            for i in 0..<children.count {
                if children[i] as? Circle == circle {
                    children.remove(at: i)
                    numChildren -= 1
                }
            }
            return
        }
        let path = child as? Path
        if path != nil {
            for i in 0..<children.count {
                if children[i] as? Path == path {
                    children.remove(at: i)
                    numChildren -= 1
                }
            }
            return
        }
    }
    
    func removeChild(at: Int) {
        self.children.remove(at: at)
        numChildren -= 1
    }
    
    var boundingBox: Rect
    
    var parent: VisualComponent?
    
    func draw() {
        print("\(color) vstack:")
         for i in 0..<children.count {
            children[i].draw()
        }
    }
    
    init() {
        self.numChildren = 0
        self.children = []
        self.boundingBox = Rect(x: 0, y: 0, width: 0, height: 0)
        self.color = ""
    }
}

// extension VStack: Equatable {
//     static func == (lhs: VStack, rhs: VStack) -> Bool {
//         if lhs.numChildren != rhs.numChildren || lhs.color != rhs.color {
//             return false
//         } else {
//             for i in 0..<lhs.numChildren {
//                 if lhs.children[i] != rhs.children[i] {
//                     return false
//                 }
//             }
//             return true
//         }
//     }
// }

extension VStack {
    convenience init(color: String, parent: VisualComponent?) {
        self.init()
        self.color = color
        self.parent = parent
    }
}

class HStack: VisualGroup {
    var numChildren: Int
    var color: String
    
    var children: [VisualComponent]
    
    func add(child: VisualComponent) {
        self.children.append(child)
        numChildren += 1
        self.boundingBox = self.boundingBox.union(with:child.boundingBox)
    }
    
    func remove(child: VisualComponent) {
        let triangle = child as? Triangle
        if triangle != nil {
            for i in 0..<children.count {
                if children[i] as? Triangle == triangle {
                    children.remove(at: i)
                    numChildren -= 1
                }
            }
            return
        }
        let rectangle = child as? Rectangle
        if rectangle != nil {
            for i in 0..<children.count {
                if children[i] as? Rectangle == rectangle {
                    children.remove(at: i)
                    numChildren -= 1
                }
            }
            return
        }
        let circle = child as? Circle
        if circle != nil {
            for i in 0..<children.count {
                if children[i] as? Circle == circle {
                    children.remove(at: i)
                    numChildren -= 1
                }
            }
            return
        }
        let path = child as? Path
        if path != nil {
            for i in 0..<children.count {
                if children[i] as? Path == path {
                    children.remove(at: i)
                    numChildren -= 1
                }
            }
            return
        }
    }
    
    func removeChild(at: Int) {
        self.children.remove(at: at)
        numChildren -= 1
    }
    
    var boundingBox: Rect
    
    var parent: VisualComponent?
    
    func draw() {
        print("\(color) hstack:")
        for i in 0..<children.count {
            children[i].draw()
        }
    }
    
    init() {
        self.numChildren = 0
        self.children = []
        self.boundingBox = Rect(x: 0, y: 0, width: 0, height: 0)
        self.color = ""
    }
}

// extension HStack: Equatable {
//     static func == (lhs: HStack, rhs: HStack) -> Bool {
//         if lhs.numChildren != rhs.numChildren || lhs.color != rhs.color {
//             return false
//         } else {
//             for i in 0..<lhs.numChildren {
//                 if lhs.children[i] != rhs.children[i] {
//                     return false
//                 }
//             }
//             return true
//         }
//     }
// }


extension HStack {
    convenience init(color: String, parent: VisualComponent?) {
        self.init()
        self.color = color
        self.parent = parent
    }
}

class ZStack: VisualGroup {
    var numChildren: Int
    var color: String
    
    var children: [VisualComponent]
    
    func add(child: VisualComponent) {
        self.children.append(child)
        numChildren += 1
        self.boundingBox = self.boundingBox.union(with:child.boundingBox)
    }
    
    func remove(child: VisualComponent) {
        let triangle = child as? Triangle
        if triangle != nil {
            for i in 0..<children.count {
                if children[i] as? Triangle == triangle {
                    children.remove(at: i)
                    numChildren -= 1
                }
            }
            return
        }
        let rectangle = child as? Rectangle
        if rectangle != nil {
            for i in 0..<children.count {
                if children[i] as? Rectangle == rectangle {
                    children.remove(at: i)
                    numChildren -= 1
                }
            }
            return
        }
        let circle = child as? Circle
        if circle != nil {
            for i in 0..<children.count {
                if children[i] as? Circle == circle {
                    children.remove(at: i)
                    numChildren -= 1
                }
            }
            return
        }
        let path = child as? Path
        if path != nil {
            for i in 0..<children.count {
                if children[i] as? Path == path {
                    children.remove(at: i)
                    numChildren -= 1
                }
            }
            return
        }
    }
    
    func removeChild(at: Int) {
        self.children.remove(at: at)
        numChildren -= 1
    }
    
    var boundingBox: Rect
    
    var parent: VisualComponent?
    
    func draw() {
        print("\(color) zstack:")
        for i in 0..<children.count {
            children[i].draw()
        }
    }
    
    init() {
        self.numChildren = 0
        self.children = []
        self.boundingBox = Rect(x: 0, y: 0, width: 0, height: 0)
        self.color = ""
    }
}

// extension ZStack: Equatable {
//     static func == (lhs: ZStack, rhs: ZStack) -> Bool {
//         if lhs.numChildren != rhs.numChildren || lhs.color != rhs.color {
//             return false
//         } else {
//             for i in 0..<lhs.numChildren {
//                 if lhs.children[i] != rhs.children[i] {
//                     return false
//                 }
//             }
//             return true
//         }
//     }
// }

extension ZStack {
    convenience init(color: String, parent: VisualComponent?) {
        self.init()
        self.color = color
        self.parent = parent
    }
}

func count_in_visual_group(group: VisualGroup, color: String) -> Int {
    var c = 0
    for i in 0..<group.numChildren {
        if group.children[i].color == color || group.children[i].color != color {
            //c += 1
            c += count(root: group.children[i], color: color)
            // if let group = group.children[i] as? VisualGroup {
            //     count += count_in_visual_group(group: group, color: color)
            // }
        }
    }
    return c
}

func count(root: VisualComponent?, color: String) -> Int {
    if root == nil {
        return 0
    }
    let visual_group : VisualGroup? = root as? VisualGroup
    var childred_with_the_same_color = 0
    if visual_group != nil && visual_group!.numChildren > 0 {
        childred_with_the_same_color = count_in_visual_group(group: visual_group!, color: color)
    }

    if root!.color == color  {
        return 1 + count(root: root!.parent, color: color) + childred_with_the_same_color
    } else {
        return count(root: root!.parent, color: color) + childred_with_the_same_color
    }
}

func depth_vg(group: VisualGroup) -> Int {
    var c = 0
    for i in 0..<group.numChildren {
        if let group = group.children[i] as? VisualGroup {
            c += depth_vg(group: group) + 1
        } else {
            c += 1
        }
    }
    return c
}

func depth(root: VisualComponent?) -> Int {
    if root == nil {
        return 0
    }
    if root!.parent == nil {
        return 1
    }
    var visual_group_depth = 0
    if let group = root as? VisualGroup {
        visual_group_depth = depth_vg(group: group)
    }
    return 1 + depth(root: root!.parent) + visual_group_depth
}

func depth1(root: VisualComponent?) -> Int {
    if root == nil {
        return -1
    }
    if root!.parent == nil {
        return 0
    }
    return 1 + depth(root: root!.parent)
}

func cover_vg(group: VisualGroup) -> Rect {
    var r : Rect = Rect(x: 0, y: 0, width: 0, height: 0)
    for i in 0..<group.numChildren {
        r = r.union(with: group.children[i].boundingBox)
    }
    return r
}

func cover(root: VisualComponent?) -> Rect {
    if root == nil {
        return Rect(x: 0, y: 0, width: 0, height: 0)
    }
    if root!.parent == nil {
        return root!.boundingBox
    }
    var visual_group_cover = Rect(x: 0, y: 0, width: 0, height: 0)
    if let group = root as? VisualGroup {
        visual_group_cover = cover_vg(group: group)
    }
    return root!.boundingBox.union(with: cover(root: root!.parent)).union(with: visual_group_cover)
}

let triangle = Triangle(a: Point(x: 0, y: 0), b: Point(x: 0, y: 0), c: Point(x: 0, y: 0), color: "red")
let rectangle = Rectangle(x: 0, y: 0, width: 0, height: 0, color: "blue")

triangle.draw()
rectangle.draw()