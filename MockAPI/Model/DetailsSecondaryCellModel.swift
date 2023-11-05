import Foundation

struct DetailsSecondaryCellModel: Hashable {
    var id: String
    
    let user: String
    let views: Int
    let downloads: Int
    let collections: Int
    let likes: Int
    let comments: Int
}
