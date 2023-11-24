//
//  Created by Arinjoy Biswas on 24/11/2023.
//

import Foundation

extension Resource {

    public static func nowPlayingList() -> Resource<NowPlayingMusicListResponse> {
        let targetURL = ApiConstants.baseURL.appending(path: "nowplaying.json")
        return Resource<NowPlayingMusicListResponse>(url: targetURL)
    }

}
