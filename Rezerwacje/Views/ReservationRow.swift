import SwiftUI

struct ReservationRow: View {
    var reservation: Reservation
    
    var body: some View {
        HStack {
            Image("krasnal")
                .resizable()
                .frame(width: 50, height: 50)
            
            VStack{
                HStack{
                    Text(reservation.name)
                        .font(.title3)
                    Spacer()
                }

                HStack{
                    Text("Rezerwacja " + reservation.status.description + "\n" +
                         reservation.dateFrom + " - " + reservation.dateTo)
                    .font(.footnote)
                    Spacer()
                }
            }
        }
    }
}

struct ReservationRow_Previews: PreviewProvider {
    static var previews: some View {
        ReservationRow(reservation: Reservation(id_stay: 1, id_client: 1, id_worker: 1, reservation_date: "01.06.2022", from_date: "01.06.2022", to_date: "01.06.2022", number_of_people: 1, check_in: nil, check_out: nil))
    }
}
