import Foundation


let jsonData = """
{
    "title": "Optionals in Swift explained: 5 things you should know",
    "url": "https://www.avanderlee.com/swift/optionals-in-swift-explained-5-things-you-should-know/",
    "category": "swift",
    "views": 47093,
    "anotherObj": {
        "title": "Optionals in Swift explained: 5 things you should know",
        "url": "https://www.avanderlee.com/swift/optionals-in-swift-explained-5-things-you-should-know/",
        "category": "swift",
        "views": 47093
    }
}
"""


let solution = Solution()
let response = solution.parseJSON(jsonData)
var dict = solution.convertToDictionary(jsonData)!

print(dict)

class Solution {     
    struct BlogPostResponse: Decodable {
        
        enum CodingKeys: String, CodingKey {
            case category
            case title
            case views
            case httpURL = "url"

        }
        
        enum Category: String, Decodable {
            case swift, combine, debugging, xcode
        }

        let category: Category
        let title: String
        let views: Int
        let httpURL: URL
    }

    func parseJSON(_ jsonData: String) -> BlogPostResponse { 
        let decoder = JSONDecoder()
        // decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let jsonData = jsonData.data(using: .utf8)!
        let blogPostResponse: BlogPostResponse = try! decoder.decode(BlogPostResponse.self, from: jsonData)
        return blogPostResponse
    }
    
    func convertToDictionary(_ text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}


//      func parseJSONArray(jsonData: String) -> [BlogPostResponse] { 
//         let decoder = JSONDecoder()
//         // decoder.keyDecodingStrategy = .convertFromSnakeCase
         
//         let jsonData = jsonData.data(using: .utf8)!
//         let blogPostResponse: [BlogPostResponse] = try! decoder.decode([BlogPostResponse].self, from: jsonData)
//         return blogPostResponse
//     }
