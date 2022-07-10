//fill the missing implementation
class List<T:Equatable> : Equatable {
    var value: T
    var next: List<T>?
    
    init(_ items: Any...) {
        self.value = items[0] as! T
        var previous = self
        for i in 1..<items.count {
            let item = items[i] as! T
            let list = List<T>(item)
            previous.next = list
            //self.next = list
            previous = list
        }
    }
}

extension List {
    subscript(index: Int) -> T? {
        if index < 0 {
            return nil
        }
        var count = 0
        var current = self
        while count < index {
            if current.next == nil {
                return nil
            }
            current = current.next!
            count += 1
        }
        return current.value
    }

    static func ==(lhs: List, rhs: List) -> Bool {
        if lhs.value != rhs.value {
            return false
        }
        for i in 0..<lhs.length {
            if lhs[i] != rhs[i] {
                return false
            }
        }
        return true
    }
}

extension List {
    var length: Int {
        var count = 1
        var current = self
        while current.next != nil {
            current = current.next!
            count += 1
        }
        return count
    }
}

extension List {
    func reverse() {
        if let result = reverse_rec(list : self) {
            self.value = result.value
            self.next = result.next
        } else {
        }
    }

    func append(_ item: T) {
        var current = self
        while current.next != nil {
            current = current.next!
        }
        current.next = List<T>(item)
    }

    func reverse_rec(list : List<T>?) -> List<T>? {
        if list == nil {
            return nil
        }
        if list!.next == nil {
            return list
        }
        let newList = reverse_rec(list: list!.next)
        list!.next = nil
        newList!.append(list!.value)
        return newList
    }
}

extension List {
    func contains(_ item: T) -> Bool {
        var current = self
        while current.next != nil {
            if current.value == item {
                return true
            }
            current = current.next!
        }
        return current.value == item
    }

    func toSet() {
        let setList = List<T>(self.value)
        for i in 1..<self.length {
            let item = self[i]
            if !setList.contains(item!) {
                setList.append(item!)
            }
        }
        self.value = setList.value
        self.next = setList.next
    }
}

 extension List {
        func flatten() -> List {
            return flatten_rec(list: self)!
        }
 }

 func flatten_rec<T>(list : List<T>?) -> List<T>? {
            if list == nil {
                return nil
            }
            let item = list!.value
            
            if let list = item as? List<T> {
                let head = flatten_rec(list: item as? List<T>)
                let tail = flatten_rec(list: list.next)
                let result = List<T>()
                for i in 0..<head!.length {
                    result.append(head![i]!)
                }
                for j in 0..<tail!.length {
                    result.append(tail![j]!)
                }
                return result
            } else {
                let rest = flatten_rec(list: list!.next)
                let result = List<T>(item)
                result.next = rest
                return result
            }
}

let result = List<Any>(List<Int>(2, 2), 21, List<Any>(3, List<Int>(5, 8))).flatten()
 for i in 0..<result.length {
     print(result[i] as! Int)
 }
    