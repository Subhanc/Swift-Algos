class Solution {
  enum APIError: Error {
    case networkError(Error)
    case dataNotFound
    case jsonParsingError(Error)
    case invalidStatusCode(Int)
  }
  //Result enum to show success or failure
  enum Result<T> {
    case success(T)
    case failure(APIError)
  }
  enum Path: String {
    case toDos = "todos/"
  }

  func request<T: Codable>(url: String = "", objectType: T.Type, completion: @escaping (Result<T>) -> Void) {
    guard let url = URL(string: url + Path.toDos.rawValue + "1") else {
      return
    }
    // Create the session object
    let session = URLSession.shared
    // Now create the URLRequest object using the url object
    let request = URLRequest(url: url)
    // Ceate dataTask using the session object to send data to the server
    let task = session.dataTask(
      with: request,
      completionHandler: {
        data,
        response, error in
        guard let data = data, error == nil else {
          completion(Result.failure(APIError.networkError(error!)))
          return
        }
        do {
          if let json = try JSONSerialization.jsonObject(
            with: data,
            options: .mutableContainers) as? [String: Any]
          {
            print(json)
          }
          let decodedObject = try JSONDecoder().decode(
            objectType.self,
            from: data)
          completion(Result.success(decodedObject))
        } catch let error {
          completion(Result.failure(APIError.jsonParsingError(error)))
        }
      })
    task.resume()
  }
}
