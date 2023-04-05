import Foundation
import CoreLocation

struct Reservation: Identifiable, Decodable, Encodable {
    let id_stay : Int
    let id_client : Int
    let id_worker : Int
    var reservation_date : String
    var from_date : String
    var to_date : String
    var number_of_people : Int
    var check_in : String?
    var check_out : String?
    
    var id: Int {
        id_stay
    }
    
    var name: String{
        "Hotel \"Krasnal\""
    }
    var status: Status{
        if (check_in == nil)
        {
            return Status.pending
        }
        else
        {
            if (check_out == nil)
            {
                return Status.ongoing
            }
            else
            {
                return Status.terminated
            }
        }
    }
    
    var dateFrom: String{
        from_date.replacingOccurrences(of: "-", with: ".")
    }
    
    var dateTo: String {
        to_date.replacingOccurrences(of: "-", with: ".")
    }
    var paid: Bool {
        false
    }
    
    var hotelCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: 51.11388507454001, longitude: 17.04615402860634)
    }
    
    enum Status : CustomStringConvertible {
        case pending, ongoing, terminated

      var description : String {
        switch self {
        case .pending: return "nierozpoczęta"
        case .ongoing: return "trwająca"
        case .terminated: return "zakończona"
        }
      }
    }
}
