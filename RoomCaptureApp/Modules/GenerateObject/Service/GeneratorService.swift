import Foundation
import Alamofire

class NetworkService {
    
    // Perform network request
    func getTextTo3DResult(apiKey: String, modelId: String, completion: @escaping (Result<TextTo3DResponse, Error>) -> Void) {
        let urlString = "https://api.meshy.ai/v2/text-to-3d/\(modelId)"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(apiKey)"
        ]
        
        AF.request(urlString, headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(TextTo3DResponse.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func textTo3D(apiKey: String, request: TextTo3DRequest, completion: @escaping (Result<String, Error>) -> Void) {
        let urlString = "https://api.meshy.ai/v2/text-to-3d"
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let encoder = JSONEncoder()
            let requestData = try encoder.encode(request)
            urlRequest.httpBody = requestData
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(TextToTaskResponse.self, from: data)
                completion(.success(response.result))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case invalidResponse
}


// Model for task id
struct TextTo3DRequest: Codable {
    let mode: String
    let prompt: String
    let artStyle: String
    let negativePrompt: String
}

struct TextToTaskResponse: Codable {
    let result: String
}




struct TextTo3DResponse: Codable {
    // Define properties that match the structure of your data
    let id: String
    let modelUrls: ModelUrls
    let thumbnailUrl: String
    let prompt: String
    let artStyle: String
    let negativePrompt: String
    let progress: Int
    let startedAt: TimeInterval
    let createdAt: TimeInterval
    let finishedAt: TimeInterval
    let status: String
    let textureUrls: [TextureUrls]

    private enum CodingKeys: String, CodingKey {
        case id
        case modelUrls = "model_urls"
        case thumbnailUrl = "thumbnail_url"
        case prompt
        case artStyle = "art_style"
        case negativePrompt = "negative_prompt"
        case progress
        case startedAt = "started_at"
        case createdAt = "created_at"
        case finishedAt = "finished_at"
        case status
        case textureUrls = "texture_urls"
    }
}

struct ModelUrls: Codable {
    let glb: String
    let fbx: String
    let obj: String
    let mtl: String
    let usdz: String
}

struct TextureUrls: Codable {
    let baseColor: String

    private enum CodingKeys: String, CodingKey {
        case baseColor = "base_color"
    }
}


