
/*
Use an array since it supports o(1) Lookup, and deletion. 
We can swap last element with element we want to delete for o(1)
*/

class RandomizedSet {
    var arr: [Int] = []
    var map: [Int: Int] = [:] // Value to Index mapping 
    
    init() { }
    
    public func insert(_ val: Int) -> Bool {
        if let _ = map[val] { return false }// contains value
        map[val] = arr.count
        arr.append(val)
        return true
    }
    
    // index, value
    public func remove(_ val: Int) -> Bool {
        if map[val] == nil { return false }
        let index = map[val]! // get index for for value
        let lastElement = arr[arr.count-1] // Get last element in array
        arr[index] = lastElement // set value to delete to last element
        map[lastElement] = index // update last items index
        map.removeValue(forKey: val) // remove deleted vals index
        arr.removeLast() // remove last item from array
        return true
    }
    
    public func getRandom() -> Int {
        let index = Int.random(in: 0...arr.count-1)
        return arr[index]
    }
}
