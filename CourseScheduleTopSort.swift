class Solution {
    func findOrder(_ numCourses: Int, _ prerequisites: [[Int]]) -> [Int] {
        /*** Build the Graph and indegree array ***/ 
        var graph = [Int: [Int]]()
        var indegree = Array(repeating: 0, count: numCourses)   
        
        for item in prerequisites {
            let course = item[0]
            let preqs = item[1]
            indegree[course] += 1
            graph[preqs, `1default: []].append(course) // Notice how this is opposite, representing the edge. 
        }
    
        var count = 0
        var queue = Queue<Int>() 
        
        /* Add all courses that do not have a preq */
        for (course, degree) in indegree.enumerated() where degree == 0 {
            queue.add(course) 
        }
        
        var result: [Int] = []
        while let course = queue.remove() {
            result.append(course)
            count += 1
            if let courses = graph[course] {
                for child in courses {
                    indegree[child] -= 1
                    if indegree[child] == 0 {
                        queue.add(child)
                    }
                }
            }
        }

        return count == numCourses ? result : []
    }
}

extension Solution { 
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
}
