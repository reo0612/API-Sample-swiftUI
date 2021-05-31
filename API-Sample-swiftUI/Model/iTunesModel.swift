
import Foundation

struct iTunesModel: Codable {
    var results: [Result]
}
struct Result: Codable {
    var trackId: Int // 書籍データのID
    var trackName: String? // 曲名
    var artistName: String? //アーティスト名
    var artworkUrl60: String? //アルバム画像
}
