class TrieNode<Element: Hashable> {
    var value: Element
    var children: [Element: TrieNode] = [:]
    var parent: TrieNode?
    
    var repeats: Int = 0 // Keep track of duplicates
    var isWordFormed: Bool = false
    var totalPrefixWords: Int = 0

    var isLeaf: Bool {
        return children.isEmpty
    }

    init(value: Element, parentNode: TrieNode? = nil) {
        self.value = value
        self.parent = parentNode
    }

    // Adds to child
    func add(value: Element)  {
        // If the letter already exist, return.
        if let _ = children[value] {
            return
        } else {
            children[value] = TrieNode(value: value, parentNode: self)
        }
    }
}

class Trie {
    let root: TrieNode<Character>

    init() {
        self.root = TrieNode<Character>(value: "/")
    }

    // Inserts a word into the trie
    func insert(_ word: String) {
        if word.isEmpty {
            return
        }
        var node = root
        for character in word.lowercased() {
            // Trie has the word.
            if let child = node.children[character] {
                node = child
            } else {
                node.add(value: character)
                node = node.children[character]!
            }
            node.totalPrefixWords += 1
        }

        node.repeats += 1 // add to total words count
        node.isWordFormed = true   // Set word formed.
    }
    // Returns true if a word exists. 
    func search(_ word: String, _ matchPrefix: Bool = false) -> Bool {
        if word.isEmpty {
            return false
        }
        var node = root
        for character in word.lowercased() {
            guard let child = node.children[character] else {
                return false
            }
            node = child
        }
        // Match prefix is it is a prefixed word.
        return node.isWordFormed || matchPrefix
    }
    
    // Returns all words that contain the prefix. 
    func findWordsWithPrefix(_ prefix: String) -> [String] {
        var node = root
        var words: [String] = []
        
        // Go to last word in prefix.
        for character in prefix.lowercased() {
            if let child = node.children[character] {
                print(child.value)
                node = child
            } else {
                return [] // none exist.
            }
        }

        if node.isWordFormed {
            words.append(prefix)
        }
        
        for child in node.children.values {
            let childWords = wordsInSubtrie(node: child, prefix: prefix)
            words.append(contentsOf: childWords)
        }
        return words
    }
     // Returns all words in the tree given a node
     func wordsInSubtrie(node: TrieNode<Character>, prefix: String = "") -> [String] {
        var words: [String] = []
        var newPrefix = prefix
        
        if node.value != "/" {
            newPrefix.append(node.value)
        }
        
        if node.isWordFormed {
            words.append(newPrefix)
        }
        
        for child in node.children.values {
            let childWords = wordsInSubtrie(node: child, prefix: newPrefix)
            words.append(contentsOf: childWords)
        }
        return words
    }
    
    func delete(_ word: String) {
        guard !word.isEmpty else {
          return
        }
        var node = root

        // iterate to last character in the word.
        for character in word.lowercased() {
          if let child = node.children[character] {
            node = child
            node.totalPrefixWords -= 1
          } else {
            return
          }
        }
                
        if !node.isWordFormed { // Isn't a word.
            return
        }
        
        /*
         
         Two cases,
         - If the last node has children then just decrement its prefix count and label it as a false word.
         - If not, delete the nodes up the ladder until you find a node that has children or creates a isWordFormed.
         */
        
        node.isWordFormed = false
        
        if node.isLeaf {
            var character = node.value
            while node.isLeaf, !node.isWordFormed, let parent = node.parent {
                node = parent
                node.children.removeValue(forKey: character)
                character = node.value
            }
        } else {
            node.totalPrefixWords -= 1
        }
    }
}

extension Trie {
  func numberOfWordsWithPrefix(_ prefix: String) -> Int {
       var node = root
       for character in prefix.lowercased() {
         if let child = node.children[character] {
           node = child
         } else {
           return 0
         }
       }
       return node.totalPrefixWords
    } 
}
