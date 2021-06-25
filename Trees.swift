struct Stack<Element> {
    var items = [Element]()

    var isEmpty: Bool {
        return items.isEmpty
    }

    mutating func push(elements: [Element]) {
        items.append(contentsOf: elements)
    }

    mutating func push(_ element: Element) {
        items.append(element)
    }
    mutating func pop() -> Element? {
        return items.popLast()
    }

    func peek() -> Element? {
        guard let top = items.last else {
            return nil
        }
        return top
    }
}


struct Queue<Element> {
    private var items: [Element] = []
    var count: Int { return items.count }
    var isEmpty: Bool { return items.isEmpty }
    var front: Element? { return items.first }

    mutating func add(_ element: Element) {
        items.append(element)
    }

    mutating func remove() -> Element? {
        if isEmpty {
            return nil
        } else {
            return items.removeFirst()
        }
    }
}


class TreeNode {
    var left: TreeNode?
    var right: TreeNode?
    var val: Int

    init(_ val: Int, _ left: TreeNode? = nil, right: TreeNode? = nil) {
        self.left = left
        self.right = right
        self.val = val
    }
}

/* DFS */

func preOrderDFS(_ root: TreeNode?) {

    guard let root = root else {
        return
    }

    var stack = Stack<TreeNode>()
    stack.push(root)

    while !stack.isEmpty {
        guard let popped = stack.pop() else {
            return
        }
        print(popped.val)
        if let right = popped.right {
            stack.push(right)
        }

        if let left = popped.left {
            stack.push(left)
        }
    }
}

func postorderTraversal(_ root: TreeNode?) -> [Int] {
    var result: [Int] = [] // we need this since we print backwards

    guard let root = root else {
        return []
    }

    var stack = Stack<TreeNode>()
    stack.push(root)

    while !stack.isEmpty {

        guard let root = stack.pop() else {
            return []
        }

        // Notice how we insert to the front of the array
        result.insert(root.val, at: 0)

        // Left goes in before right, opposite of PreOrder
        if let left = root.left {
            stack.push(left)
        }

        if let right = root.right {
            stack.push(right)
        }
    }
    return result
}

// Best for validiating BST
func inorderTraversal(_ root: TreeNode?) {
    var stack = Stack<TreeNode>()
    var root = root

    while root != nil || !stack.isEmpty {
        if let node = root {
            stack.push(node)
            root = node.left
        } else {
            if let popped = stack.pop() {
                print(popped.val)
                root = popped.right
            }
        }
    }
}

/* BFS */

func breathFirstSearch(_ root: TreeNode?) {    
    guard let node = root else {
        return
    }
    var queue = Queue<TreeNode>()
    queue.add(node)

    while !queue.isEmpty {
        if let popped = queue.remove() {
            print(popped.val)
            if let left = popped.left {
                queue.add(left)
            }
            if let right = popped.right {
                queue.add(right)
            }
        }
    }
}
