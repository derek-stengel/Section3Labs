import UIKit

// The fully-qualified URL must have the following format: https://itunes.apple.com/search?parameterkeyvalue
// in the url: key1 = value1 & key2 = value ... (without white spaces)

// To search for all Jack Johnson audio and video content (movies, podcasts, music, music videos, audiobooks, short films, and tv shows), your URL would look like the following:
// https://itunes.apple.com/search?term=jack+johnson
// To search for all Jack Johnson audio and video content and return only the first 25 items, your URL would look like the following:
// https://itunes.apple.com/search?term=jack+johnson&limit=25
// To search for only Jack Johnson music videos, your URL would look like the following:
// https://itunes.apple.com/search?term=jack+johnson&entity=musicVideo
// To search for all Jim Jones audio and video content and return only the results from the Canada iTunes Store, your URL would look like the following:
// https://itunes.apple.com/search?term=jim+jones&country=ca

let url = URL(string: "https://itunes.apple.com/search")!

let queryDictionary: [String: String] = [
    "term": "Interstellar",
    "media": "movie",
    "limit": "5"
]

var urlComponents = URLComponents(string: "https://itunes.apple.com/search")!
urlComponents.queryItems = [
    "term": "Interstellar",
    "media": "movie",
    "limit": "5"
].map { URLQueryItem(name: $0.key, value: $0.value) }

Task {
    let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
    
    if let httpResponse = response as? HTTPURLResponse,
       httpResponse.statusCode == 200,
       let string = String(data: data, encoding: .utf8) {
        print(string)
    }
}
