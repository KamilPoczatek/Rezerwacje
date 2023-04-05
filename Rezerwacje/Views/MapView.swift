import SwiftUI
import MapKit

struct MyAnnotationItem: Identifiable {
    var coordinate: CLLocationCoordinate2D
    let id = UUID()
}

struct MapView: View {
    var coordinate: CLLocationCoordinate2D
    @State private var region = MKCoordinateRegion()
    
    var body: some View {
        let annotationItems: [MyAnnotationItem] = [
            MyAnnotationItem(coordinate: coordinate)
        ]
        
        Map(coordinateRegion: $region,
            annotationItems: annotationItems) {item in
                MapMarker(coordinate: item.coordinate)
        }.onAppear {
            setRegion(coordinate)
        }
    }

    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)
        )
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(coordinate: CLLocationCoordinate2D(latitude: 51.117_286, longitude: 17.041_868))
    }
}
