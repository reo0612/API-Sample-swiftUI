
import Foundation

enum APIStatus<Value> {
    case idle
    case loading
    case failure(Error)
    case success(iTunesModel)
}
