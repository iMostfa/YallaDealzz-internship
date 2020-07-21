//
//  Youtubeable.swift
//  yallaDealz
//
//  Created by mostfa on 7/21/20.
//  Copyright © 2020 mostfaE. All rights reserved.
//

import Foundation
import Combine
/// Youtube repository,
typealias channelID = String
protocol  Youtubeable {
  func channel(for id: channelID) -> AnyPublisher<YoutubeableChannel,YoutubeErros>


}

