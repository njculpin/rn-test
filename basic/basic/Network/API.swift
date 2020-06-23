import Foundation

class API {
    
  let defaultSession = URLSession(configuration: .default)

  var dataTask: URLSessionDataTask?
  var errorMessage = ""
  var album: [Album] = []
  
  typealias JSONDictionary = [String: Any]
  typealias QueryResult = ([Album]?, String) -> Void
  

  func download(searchTerm: String, completion: @escaping QueryResult) {

    dataTask?.cancel()

    if var urlComponents = URLComponents(string: "https://itunes.apple.com/search") {
      urlComponents.query = "media=music&entity=song&term=\(searchTerm)"

      guard let url = urlComponents.url else {
        return
      }

      dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
        defer {
          self?.dataTask = nil
        }

        if let error = error {
          self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
        } else if
          let data = data,
          let response = response as? HTTPURLResponse,
          response.statusCode == 200 {
          
          self?.updateSearchResults(data)

          DispatchQueue.main.async {
            completion(self?.album, self?.errorMessage ?? "")
          }
        }
      }

      dataTask?.resume()
    }
  }
  
  private func updateSearchResults(_ data: Data) {
    var response: JSONDictionary?
    album.removeAll()
    
    do {
      response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
    } catch let parseError as NSError {
      errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
      return
    }
    
    guard let array = response!["results"] as? [Any] else {
      errorMessage += "Dictionary does not contain results key\n"
      return
    }
    
    var index = 0
    
    for trackDictionary in array {
      if let trackDictionary = trackDictionary as? JSONDictionary,
        let previewURLString = trackDictionary["previewUrl"] as? String,
        let previewURL = URL(string: previewURLString),
        let name = trackDictionary["trackName"] as? String,
        let artist = trackDictionary["artistName"] as? String {
          album.append(Album(name: name, artist: artist, previewURL: previewURL, index: index))
          index += 1
      } else {
        errorMessage += "Problem parsing trackDictionary\n"
      }
    }
  }
}
