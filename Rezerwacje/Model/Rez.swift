import Foundation
import CoreLocation

struct Rez: Identifiable, Decodable {
    let id_stay : Int
    let id_client : Int
    let id_worker : Int
    let reservation_date : String
    let from_date : String
    let to_date : String
    let number_of_people : Int
    let check_in : String?
    let check_out : String?
    
    var id: Int {
        id_stay
    }
    
    var name: String{
        "Aaaa Test "
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
        from_date
    }
    
    var dateTo: String {
        to_date
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
