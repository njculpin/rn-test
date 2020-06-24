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

    // construct a url from string to be queried
    if var urlComponents = URLComponents(string: "https://itunes.apple.com/search") {
        
      urlComponents.query = "media=music&entity=song&term=\(searchTerm)"

      guard let url = urlComponents.url else {
        return
      }

      // download data from the url, using weak self because
      // we might have a network failure and makes our response optional
      dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
        defer {
          self?.dataTask = nil
        }

        if let error = error {
            
          // return errors
          self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
            
        } else if
          let data = data,
          let response = response as? HTTPURLResponse,
          response.statusCode == 200 {
          // our query was successful, we can move on to serialize the data and get the parts we need
          self?.updateSearchResults(data)

          // return any errors and the serialized response to the view controller request
          DispatchQueue.main.async {
            completion(self?.album, self?.errorMessage ?? "")
          }
        }
      }

      dataTask?.resume()
    }
  }
  
    // helper method to seralize the json response
  private func updateSearchResults(_ data: Data) {
    // serialized json from string
    var response: JSONDictionary?
    // if we are conducting a new search, be sure the list is empty
    album.removeAll()
    
    do {
        // serialize
      response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
    } catch let parseError as NSError {
        // record errors
      errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
      return
    }
    
    // unwrap the serialized data
    guard let array = response!["results"] as? [Any] else {
        // record errors
      errorMessage += "Dictionary does not contain results key\n"
      return
    }
    
    // iterate through the array
    for trackDictionary in array {
        
        // construct the found data and apply it to the album model
      if let trackDictionary = trackDictionary as? JSONDictionary,
        let imageURL = trackDictionary["artworkUrl100"] as? String,
        let name = trackDictionary["trackName"] as? String,
        let albumName = trackDictionary["collectionName"] as? String,
        let artist = trackDictionary["artistName"] as? String {
        
        album.append(Album(name: name, artist: artist, album: albumName, image: imageURL))
        
      } else {
        errorMessage += "Problem parsing trackDictionary\n"
      }
    }
  }
}
