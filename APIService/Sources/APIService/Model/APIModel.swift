import Foundation

public struct APIRegisterRequestModel: Codable {
    let id: UUID
    let email: String
    let password: String
    let age: String
    public init(id: UUID, email: String, password: String, age: String) {
        self.id = id
        self.email = email
        self.password = password
        self.age = age
    }
}

public struct APIAuthRequestModel: Codable {
    let email: String
    let password: String
    public init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}

public struct APIAuthResponseModel: Codable {
    let email: String
    let age: String
    public init(email: String, age: String) {
        self.email = email
        self.age = age
    }
}

public struct APISearchRequestModel: Codable {
    let total: Int
    let totalHits: Int
    public let hits: [HitModel]
    
    public init(total: Int, totalHits: Int, hits: [HitModel]) {
        self.total = total
        self.totalHits = totalHits
        self.hits = hits
    }
    
    public struct HitModel: Codable {
        init(
            id: Int,
            pageURL: String,
            type: String,
            tags: String,
            previewURL: String,
            previewWidth: Int,
            previewHeight: Int,
            webformatURL: String,
            webformatWidth: Int,
            webformatHeight: Int,
            largeImageURL: String,
            imageWidth: Int,
            imageHeight: Int,
            imageSize: Int,
            views: Int,
            downloads: Int,
            collections: Int,
            likes: Int,
            comments: Int,
            user_id: Int,
            user: String,
            userImageURL: String) {
                
            self.id = id
            self.pageURL = pageURL
            self.type = type
            self.tags = tags
            self.previewURL = previewURL
            self.previewWidth = previewWidth
            self.previewHeight = previewHeight
            self.webformatURL = webformatURL
            self.webformatWidth = webformatWidth
            self.webformatHeight = webformatHeight
            self.largeImageURL = largeImageURL
            self.imageWidth = imageWidth
            self.imageHeight = imageHeight
            self.imageSize = imageSize
            self.views = views
            self.downloads = downloads
            self.collections = collections
            self.likes = likes
            self.comments = comments
            self.user_id = user_id
            self.user = user
            self.userImageURL = userImageURL
        }
        let id: Int
        public let pageURL: String
        public let type: String
        public let tags: String
        public let previewURL: String
        public let previewWidth: Int
        public let previewHeight: Int
        public let webformatURL: String
        public let webformatWidth: Int
        public let webformatHeight: Int
        public let largeImageURL: String
        public let imageWidth: Int
        public let imageHeight: Int
        public let imageSize: Int
        public let views: Int
        public let downloads: Int
        public let collections: Int
        public let likes: Int
        public let comments: Int
        public let user_id: Int
        public let user: String
        public let userImageURL: String
    }
}
