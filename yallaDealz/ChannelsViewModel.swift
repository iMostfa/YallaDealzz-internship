//
//  ChannelsViewModel.swift
//  yallaDealz
//
//  Created by mostfa on 7/21/20.
//  Copyright © 2020 mostfaE. All rights reserved.
//

import Foundation
import Combine

class ChannelsViewModel: ObservableObject {

  @Published var channels: [YoutubeChannelViewModel] = []
  private var disposablsBag = Set<AnyCancellable>()
  var youtubeAPI: Youtubeable

  init(_ youtubeAPI: Youtubeable) {
    self.youtubeAPI = youtubeAPI
  }

  func fetchChannel(for url: String) {
    let urlString = url
    guard  let url = URL(string: urlString) else { return }
    let channelID = url.pathComponents[2]


    self.youtubeAPI
      .channel(for: channelID)
      .receive(on: RunLoop.main)
      .eraseToAnyPublisher()
      .sink(receiveCompletion: { (completion) in
        print(completion)
      }, receiveValue: { (youtubeChannel) in
        self.channels.append(.init(id: youtubeChannel.id, channelName: youtubeChannel.title, imageLink: youtubeChannel.url))
      })

  .store(in: &disposablsBag)
    
  }
}


extension ChannelsViewModel {
  struct YoutubeChannelViewModel: Identifiable {
    var id: String
    var channelName: String
    var imageLink: String
  }
}
