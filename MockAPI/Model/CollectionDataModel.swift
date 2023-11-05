import Foundation

struct CollectionDataModel: Identifiable {
    var id: UUID = .init()
    
    let pageURL: String
    let type: String
    let tags: String
    let previewURL: String
    let previewWidth: CGFloat
    let previewHeight: CGFloat
    let webformatURL: String
    let webformatWidth: CGFloat
    let webformatHeight: CGFloat
    let largeImageURL: String
    let imageWidth: Int
    let imageHeight: Int
    let imageSize: Int
    let views: Int
    let downloads: Int
    let collections: Int
    let likes: Int
    let comments: Int
    let user_id: Int
    let user: String
    let userImageURL: String
    
}
