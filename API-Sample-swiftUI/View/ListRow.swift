
import SwiftUI
import SDWebImageSwiftUI

struct ListRow: View {
    let result: Result
    
    var body: some View {
        HStack {
            WebImage(url: URL(string: result.artworkUrl60 ?? ""))
            
            VStack(alignment: .leading) {
                Text(result.artistName ?? "No ArtistName")
                    .bold()
                Text(result.trackName ?? "No TrackName")
                    .italic()
            }
        }
    }
}
