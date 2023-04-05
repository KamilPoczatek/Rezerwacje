import SwiftUI

struct MainPageView: View {
    @EnvironmentObject var network: Network

    var body: some View {
        NavigationView {
            List(network.reservations) { reservation in
                NavigationLink {
                    DetailPageView(reservation: reservation)
                } label: {
                    ReservationRow(reservation: reservation)
                }
            }
            .onAppear(){
                network.getReservations()
            }
            .navigationTitle("Rezerwacje")
            .listStyle(.grouped)
            .toolbar {
                ToolbarItem() {
                    Image(systemName: "person.crop.circle")
                }
            }
        }
    }
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
            .environmentObject(Network())
    }
}
