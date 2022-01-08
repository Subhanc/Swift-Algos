class HashMap {
    typealias Pair = (key: Int, value: Int)
    var map: [[Pair]] = []
    var size: Int { return map.count }
    
    func put(_ key: Int, _ value: Int) {
        let bucket = key % size
        if let pairs = map[bucket] {
            for pair in pairs {
                if pair.key == key {
                    pair.val = value
                    return
                }
            }
            pairs.append((key, value))
        } else {
            map[bucket, default: []].append((key, value))
        }
    }
    
    func get(_ key: Int) -> Int? {
        let bucket = key % size
        
        if let pairs = map[bucket] {
            for pair in pairs {
                if pair.key == key { return pair.value }
            }
        } else {
            return nil
        }
    }
    
    func remove(_ key: Int) -> Bool {
        let bucket = key % size

        if let pairs = map[bucket] {
            for pair in pairs {
                if pair.key == key {
                    pairs.remove(key)
                    return true
                }
            }
        }
        return false
    }
    
    private func hash(_ key: Int) -> Int {
        return key % self.size
    }
}
