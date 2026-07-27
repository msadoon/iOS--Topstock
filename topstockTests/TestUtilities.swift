import Foundation

class TestUtilities {
    static let bundle = Bundle(for: TestUtilities.self)
    
    static func loadJson<T: Decodable>(filename fileName: String) -> T? {
        if let url = TestUtilities.bundle.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedData = try decoder.decode(T.self, from: data)
                
                return decodedData
            } catch {
                print("error:\(error)")
            }
        }
        
        return nil
    }
}
