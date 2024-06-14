import SwiftUI

struct Test: View {
    @State private var images: [String] = []

    var body: some View {
        List(images, id: \.self) { imageURL in
            AsyncImage(url: URL(string: imageURL)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .frame(height: 200) // Set desired height for images
        }
        .onAppear {
            fetchImages()
        }
    }

    func fetchImages() {
        guard let url = URL(string: "https://api.agios.co/occasions/get/27cg54wfacn5836") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let result = try JSONDecoder().decode(Response.self, from: data)
                DispatchQueue.main.async {
                    self.images = result.data.icons.map { $0.image }
                }
            } catch {
                print("Failed to decode JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
}

struct Response: Decodable {
    let data: DataModel
}

struct DataModel: Decodable {
    let icons: [IconModel]
}

struct IconModel: Decodable {
    let image: String
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
