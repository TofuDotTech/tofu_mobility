//
//  WebSocketStream.swift
//  Hackathon-iOS-2023
//
//  Created by Jyaru Hernandez on 30/04/23.
//

import Foundation

class WebSocketStream: AsyncSequence {
    
    private func listenForMessages() {
        socket.receive { [unowned self] result in
            switch result {
            case .success(let message):
                continuation?.yield(message)
                listenForMessages()
            case .failure(let error):
                continuation?.finish(throwing: error)
            }
        }
    }
    
    
    func makeAsyncIterator() -> AsyncIterator {
        guard let stream = stream else {
            fatalError("stream was not initialized")
        }
        socket.resume()
        listenForMessages()
        return stream.makeAsyncIterator()
    }

    typealias Element = URLSessionWebSocketTask.Message
    typealias AsyncIterator = AsyncThrowingStream<URLSessionWebSocketTask.Message, Error>.Iterator
    
    private var stream: AsyncThrowingStream<Element, Error>?
       private var continuation: AsyncThrowingStream<Element, Error>.Continuation?
       private let socket: URLSessionWebSocketTask

       init(url: String, session: URLSession = URLSession.shared) {
           socket = session.webSocketTask(with: URL(string: url)!)
           stream = AsyncThrowingStream { continuation in
               self.continuation = continuation
               self.continuation?.onTermination = { @Sendable [socket] _ in
                   socket.cancel()
               }
           }
       }
    
    

    //...
}
