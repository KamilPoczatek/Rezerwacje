import SwiftUI

class Network: ObservableObject {
    @Published var users: [User] = []
    @Published var reservations: [Reservation] = []
    let today: String = "2023-01-27"
    //let adress: String = "http://25.59.178.185"
    //let adress: String = "http://25.71.117.211"
    let adress: String = "http://25.72.207.91"

    func getUsers() {
        guard let url = URL(string: adress + ":8002/users") else { fatalError("Missing URL") }

        let urlRequest = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse else { return }

            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedUsers = try JSONDecoder().decode([User].self, from: data)
                        self.users = decodedUsers
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }

        dataTask.resume()
    }
    
    func getReservations() {
        guard let url = URL(string: adress + ":8001/reservations/stayreservation") else { fatalError("Missing URL") }

        let urlRequest = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }

            guard let response = response as? HTTPURLResponse else { return }

            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedReservations = try JSONDecoder().decode([Reservation].self, from: data)
                        self.reservations = decodedReservations
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }

        dataTask.resume()
    }
    
    func reservationCheckIn(reservationId: Int) {
        guard let url = URL(string: adress + ":8001/reservations/stayreservation/update/" + String(reservationId) + "/") else {
                print("Error: cannot create URL")
                return
            }
            
            // Create model
            struct UploadData: Codable {
                let check_in: String
            }
            
            // Add data to the model
            let uploadDataModel = UploadData(check_in: today)
            
            // Convert model to JSON data
            guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
                print("Error: Trying to convert model to JSON data")
                return
            }
            
            // Create the request
            var request = URLRequest(url: url)
            request.httpMethod = "PATCH" //"PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    print("Error: error calling PUT")
                    print(error!)
                    return
                }
                guard let data = data else {
                    print("Error: Did not receive data")
                    return
                }
                guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                    print("Error: HTTP request failed")
                    return
                }
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }
                    guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                        print("Error: Cannot convert JSON object to Pretty JSON data")
                        return
                    }
                    guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                        print("Error: Could print JSON in String")
                        return
                    }
                    
                    print(prettyPrintedJson)
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }.resume()
        }
    
    func reservationCheckOut(reservationId: Int) {
        guard let url = URL(string: adress + ":8001/reservations/stayreservation/update/" + String(reservationId) + "/") else {
                print("Error: cannot create URL")
                return
            }
            
            // Create model
            struct UploadData: Codable {
                let check_out: String
            }
            
            // Add data to the model
            let uploadDataModel = UploadData(check_out: today)
            
            // Convert model to JSON data
            guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
                print("Error: Trying to convert model to JSON data")
                return
            }
            
            // Create the request
            var request = URLRequest(url: url)
            request.httpMethod = "PATCH" //"PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    print("Error: error calling PUT")
                    print(error!)
                    return
                }
                guard let data = data else {
                    print("Error: Did not receive data")
                    return
                }
                guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                    print("Error: HTTP request failed")
                    return
                }
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }
                    guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                        print("Error: Cannot convert JSON object to Pretty JSON data")
                        return
                    }
                    guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                        print("Error: Could print JSON in String")
                        return
                    }
                    
                    print(prettyPrintedJson)
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }.resume()
        }
    
    
    
}
