import Foundation
import APIService

protocol ListViewModelProtocol: ViewModelProtocol {
    func goToDetails(model: CollectionDataModel)
    func search()
}

class ListViewModel: ListViewModelProtocol {
    private let coordinator : CoordinatorProtocol
    private let service: APIServieProtocol
    weak var delegate: ViewControllerDelegate?
    
    required init(coordinator: CoordinatorProtocol, service: APIServieProtocol) {
        self.coordinator = coordinator
        self.service = service
    }
    
    func goToDetails(model: CollectionDataModel) {
        coordinator.details(model: model)
    }
    
    @MainActor
    func search() {
        Task {
            let result = await service.searchPhoto("yellow+flowers")
            switch result {
            case .success( let resultModel):
                let resultList: [CollectionDataModel] = resultModel.hits.map { model in
                    CollectionDataModel(
                        pageURL: model.pageURL,
                        type: model.type,
                        tags: model.tags,
                        previewURL: model.previewURL,
                        previewWidth: CGFloat(model.previewWidth),
                        previewHeight: CGFloat(model.previewHeight),
                        webformatURL: model.webformatURL,
                        webformatWidth: CGFloat(model.webformatWidth),
                        webformatHeight: CGFloat(model.webformatHeight),
                        largeImageURL: model.largeImageURL,
                        imageWidth: model.imageWidth,
                        imageHeight: model.imageHeight,
                        imageSize: model.imageSize,
                        views: model.views,
                        downloads: model.downloads,
                        collections: model.collections,
                        likes: model.likes,
                        comments: model.comments,
                        user_id: model.user_id,
                        user: model.user,
                        userImageURL: model.userImageURL
                    )
                }
                
                delegate?.reload(resultList)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
