//
//  GenerateViewModel.swift
//  RoomCaptureApp
//
//  Created by Maharjan on 20/04/2024.
//

import Foundation

class GenerateViewModel {
    
    let apiKey = "msy_MGXHBw7V1JLGxirhLKX1DtZD23NoEq9ZTCQ4"
    
    func fetchObject(promt: String, style: String) {
        let apiKey = apiKey
        let request = TextTo3DRequest(
            mode: "preview",
            prompt: "a monster mask",
            artStyle: "realistic",
            negativePrompt: "low quality, low resolution, low poly, ugly"
        )

        NetworkService.textTo3D(apiKey: apiKey, request: request) { result in
            switch result {
            case .success(let response):
                print("Response: \(response)")
                self.fetch3dObject(modelId: response)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func fetch3dObject(modelId: String) {
        let apiKey = apiKey
        let modelId = modelId

            NetworkService().getTextTo3DResult(apiKey: apiKey, modelId: modelId) { result in
            switch result {
            case .success(let response):
                print("TextTo3D response:")
                print(response)
                // Access the decoded response here
            case .failure(let error):
                print("Error fetching TextTo3D response:", error)
            }
        }    }
    
    
    
    
}
