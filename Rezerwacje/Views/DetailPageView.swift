import SwiftUI

struct DetailPageView: View {
    var reservation: Reservation
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var network: Network
    @State private var allertMessage = ""
    @State private var showingAlert = false


    var body: some View {
        NavigationView {
            VStack(alignment: .trailing, spacing: 6) {
                MapView(coordinate: reservation.hotelCoordinate)
                    .ignoresSafeArea(edges: .top)
                    .frame(height: 150)
                
                Text(reservation.name)
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20.0)

                Text(reservation.dateFrom + " - " + reservation.dateTo)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20.0)
                                
                Text("Status: " + reservation.status.description)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20.0)
                
                Text("Opłacona: " + (reservation.paid ? "tak" : "nie"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20.0)
                
                Text("\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas vel viverra dui, ut lacinia magna. Etiam eget felis vitae tortor condimentum finibus eget semper nunc. Nunc eu elit rhoncus, ultrices purus ut, molestie dolor. Sed non tincidunt augue. Pellentesque molestie nisi lacus, quis ullamcorper tortor dapibus ac.")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20.0)
                
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.size.width)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    
                    if (reservation.status == .pending)
                    {
                        Spacer()
                        
                        VStack{
                            Image(systemName: "person.fill.badge.plus")
                            Spacer()
                            Text("Zamelduj")
                                .font(.footnote)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            network.reservationCheckIn(reservationId: reservation.id_stay)
                            
                            allertMessage = "Zameldowano"
                            showingAlert = true
                            
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                    
                    else if (reservation.status == .ongoing){
                        Spacer()
                        
                        VStack{
                            Image(systemName: "person.fill.badge.minus")
                            Spacer()
                            Text("Wymelduj")
                                .font(.footnote)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            network.reservationCheckOut(reservationId: reservation.id_stay)
                            
                            allertMessage = "Wymeldowano!"
                            showingAlert = true
                            
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        
                        Spacer()
                        
                        VStack{
                            Image(systemName: "key.fill")
                            Spacer()
                            Text("Otwórz")
                                .font(.footnote)
                        }
                    }
            
                    Spacer()
                    
                    VStack{
                        Image(systemName: "phone.fill")
                        Spacer()
                        Text("Kontakt")
                            .font(.footnote)
                    }
                    
                    Spacer()
                }
            }
        }
        .alert(allertMessage, isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}

struct DetailPageView_Previews: PreviewProvider {
    static var previews: some View {
        DetailPageView(reservation: Reservation(id_stay: 1, id_client: 1, id_worker: 1, reservation_date: "01.06.2022", from_date: "01.06.2022", to_date: "01.06.2022", number_of_people: 1, check_in: nil, check_out: nil))
    }
}
