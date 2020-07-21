//
//  ContentView.swift
//  yallaDealz
//
//  Created by mostfa on 7/21/20.
//  Copyright © 2020 mostfaE. All rights reserved.
//

import SwiftUI
import URLImage

struct ContentView: View {
  @ObservedObject var viewModel = ChannelsViewModel(YoutubeAPI())

  var body: some View {
    NavigationView {
      List(self.viewModel.channels) { channel in
        HStack {
          URLImage(URL(string:channel.imageLink)!) { proxy in
            proxy.image
              .resizable()                     // Make image resizable
              .aspectRatio(contentMode: .fill) // Fill the frame
              .clipped()                       // Clip overlaping parts
              .cornerRadius(10)
              .shadow(color: Color.black.opacity(0.4), radius: 14, x: 0, y: 0)
          }
          .frame(width: 50, height: 50)
          .padding()
          Text(channel.channelName)
          Spacer()
          Button(action: { })
          {

            Text("Subscribe")
              .font(.system(size: 10, weight: .semibold, design: .rounded))
              .foregroundColor(Color.white)
              .padding(.horizontal, 20)
              .padding(.vertical, 10)
              .background(Color.red.cornerRadius(10))


          }
        }
      .padding()
      }
      .onAppear {
        withAnimation{
          self.viewModel.fetchChannel(for: " //https://www.youtube.com/channel/UCW0q_FZnJxmNTVoD7inGh4A")
          self.viewModel.fetchChannel(for: "https://www.youtube.com/channel/UC_x5XG1OV2P6uZZ5FSM9Ttw/")
          self.viewModel.fetchChannel(for: "https://www.youtube.com/channel/UCsP3Clx2qtH2mNZ6KolVoZQ/")
          self.viewModel.fetchChannel(for: "https://www.youtube.com/channel/UCUsN5ZwHx2kILm84-jPDeXw")
          self.viewModel.fetchChannel(for: "https://www.youtube.com/channel/UCSxuIT_QDCCiGp07IgDEPtg")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
          self.viewModel.fetchChannel(for: "https://www.youtube.com/channel/UChx2KJtQ332gWHZDYSC0oVg")


        }

      }
    .navigationBarTitle("Youtube channels")
    }
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
