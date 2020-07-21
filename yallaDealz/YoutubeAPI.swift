//
//  YoutubeAPI.swift
//  yallaDealz
//
//  Created by mostfa on 7/21/20.
//  Copyright © 2020 mostfaE. All rights reserved.
//

import Foundation
import Combine

class YoutubeAPI: Youtubeable {
  private var APIkey: String = AppConstats.APIKeys.rawValue
  private let decoder = JSONDecoder()

 

  func channel(for id: channelID) -> AnyPublisher<YoutubeableChannel, YoutubeErros> {
    let youtubeAPI = "https://www.googleapis.com/youtube/v3/channels?id=\(id)&part=snippet&key=\(APIkey)"

    return URLSession
      .shared
      .dataTaskPublisher(for: URL(string: youtubeAPI)!)
      .map(\.data)
      .decode(type: YoutubeChannel.self, decoder: self.decoder)
      .mapError{YoutubeErros.networkingnError($0)}
      .flatMap {$0.items.publisher.mapError{YoutubeErros.networkingnError($0)}.eraseToAnyPublisher()}
      .first()
      .map{YoutubeableChannel(id: $0.id, url: $0.snippet.thumbnails.medium.url, title: $0.snippet.title)}
      .eraseToAnyPublisher()


  }



}



struct YoutubeChannel: Codable {

  var items: [YoutubeSnippet]

}

extension YoutubeChannel {

  struct YoutubeSnippet: Codable {
    var snippet : YouttubeItem
    var id: String

  }
  struct YouttubeItem: Codable {
    var title: String
    var thumbnails: YoutubeThmbnails
  }



  struct YoutubeThmbnails:Codable {

    var `default`: YoutubeThumbnail
    var medium: YoutubeThumbnail

    struct YoutubeThumbnail: Codable {
      var url: String
    }
  }


}
