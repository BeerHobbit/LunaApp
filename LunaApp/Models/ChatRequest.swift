struct ChatRequest: APIRequest {
    typealias DTO = MessagesDTO
    
    static let method: HTTPMethod = .post
    let path: String = "chat"
    let headers: [String : String]? = ["Content-Type": "application/json"]
    let bodyDTO: DTO?
    
    init(messages: [Message]) {
        self.bodyDTO = MessagesDTO(messages: messages)
    }
}
