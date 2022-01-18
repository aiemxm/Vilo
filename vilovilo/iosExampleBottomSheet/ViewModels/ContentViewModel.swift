//
//  ContentViewModel.swift
//  iosExampleBottomSheet
//
//  Created by Apprenant 86 on 04/12/2021.
//

import Foundation
import SwiftUI
import BottomSheet
import Combine
import CoreLocation
import MapKit

protocol NavigatorProtocol: ObservableObject {
    associatedtype SheetDestination
    func sheetView2() -> AnyView
}

class SheetNavigator: NavigatorProtocol {
    // Landing BottomSheet properties:
    @Published var sheetDestination: SheetDestination = .landing
    @Published var sheetPosition: BottomSheetPosition = .middle
    // Weather BottomSheet properties:
    @Published var weatherContent: SheetDestination = .weather
    @Published var weatherPosition: BottomSheetPosition = .hidden

    var weatherView: AnyView {
        switch weatherContent {
        default:
            return WeatherMainView().eraseToAnyView()
        }
    }
    
    enum SheetDestination: String, CaseIterable {
        case landing = "landing"
        case search = "search"
        case profile = "profile"
        case weather = "weather"
        case recentSearches = "Recent searches"
        case suggestedSearches = "Suggested searches"
    }
    
    
    enum BottomSheetToDisplay {
        case landing
        case weather
    }

    
    func sheetView2() -> AnyView {
        switch self.sheetDestination {
        case .landing:
            return HomeMainView().eraseToAnyView()
        case .search:
            switch self.sheetPosition {
//            case .top:
//                return RecentsView(c).eraseToAnyView()
            default:
                sheetDestination = .landing
                return sheetView2()
            }
//            return SearchView().eraseToAnyView()
//        case .profile(name: let userName):
//            return ProfileView(name: userName).eraseToAnyView()
        case .weather:
            switch self.sheetPosition {
            case .top:
                return WeatherMainView().eraseToAnyView()
            default:
                sheetDestination = .landing
                return sheetView2()
            }
        default:
            return HomeMainView().eraseToAnyView()
        }
    }
}

extension SheetNavigator {
    static var sheetNavigator = SheetNavigator()
}

class WeatherNavigator: NavigatorProtocol {
    @Published var showSheet = false
    var sheetDestination: SheetDestination = .none {
        didSet {
            showSheet = true
        }
    }
    
    var sheetPosition: BottomSheetPosition = .hidden {
        didSet {
            showSheet = true
        }
    }
    

    
    enum SheetDestination: String, CaseIterable {
//        case landing = "landing"
//        case search = "search"
//        case profile = "profile"
        case none = "none"
        case weather = "weather"
    }
    
//    func sheetView() -> AnyView {
//        switch sheetDestination {
//        case .landing:
//            return LandingSheetView().eraseToAnyView()
//        case .search:
//            return SearchView().eraseToAnyView()
//        case .profile(name: let userName):
//            return ProfileView(name: userName).eraseToAnyView()
//        default:
//            return LandingSheetView().eraseToAnyView()
//        }
//    }
    
    func sheetView2() -> AnyView {
        switch self.sheetDestination {
//        case .landing:
//            return LandingSheetView().eraseToAnyView()
//        case .search:
//            switch self.sheetPosition {
//            case .top:
//                return SearchView().eraseToAnyView()
//            default:
//                sheetDestination = .landing
//                return sheetView2()
//            }
//            return SearchView().eraseToAnyView()
//        case .profile(name: let userName):
//            return ProfileView(name: userName).eraseToAnyView()
        case .weather:
            return DisruptionMainView().eraseToAnyView()
        default:
            return EmptyView().eraseToAnyView()
        }
    }
}
extension WeatherNavigator {
    static var weatherNavigator = WeatherNavigator()
}

extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}

class BottomSheetModel: ObservableObject, Equatable {
    static func == (lhs: BottomSheetModel, rhs: BottomSheetModel) -> Bool {
        lhs.name == rhs.name
    }
    
    var name: String
    
    @Published var position: BottomSheetPosition = .hidden {
        didSet {
            // change context back to .landing when .search BS is dragged down from .top
    
            switch self {
            case .homeBS:
                if context == .search(type: .destination) && position != .top { context = .landing }
            case .disruptionBS:
                if context == .search(type: .incident) && position != .top { context = .disruption }
            case .profileBS:
                if context == .search(type: .home) && position != .top { context = .profile }
                if context == .search(type: .office) && position != .top { context = .profile }
            default:
                break
            }
            

        }
    }
    
    @Published var options: [BottomSheet.Options] = []
    
    @Published var destination: String = "" {
        didSet{
            searchForCity(text: destination)
        }
    }
  
    @Published var lat = 43.326547
    @Published var lon = 2.33336289
    
    @Published var go = false
    
    @Published var results = [LocalSearchData]()
    
    var service: LocalSearchService
    
    @Published var context: SheetContext = .none
    
    enum SearchType {
        case source, destination, home, office, incident
    }
    
    private var cancellable: AnyCancellable?
    
    enum SheetContext: Equatable {
        case none
        case landing
        case search(type: SearchType)
        case profile
        case weather
        case recentSearches
        case suggestedSearches
        case disruption
        case tripChoice
        case tripSummary
        case tripInProgress
        case completedTrip
        case favorite
    }
    
    private func searchForCity(text: String) {
        service.searchPointOfInterests(searchText: text)
    }
    
    func headerView() -> AnyView {
        switch context {
        case .none:
            return Text("Default header").eraseToAnyView()
        case .landing:
            return SearchBar(viewModel: .homeBS).padding([.top, .bottom]).eraseToAnyView()
        case .search:
            return SearchBar(viewModel: self).padding([.top, .bottom]).eraseToAnyView()
        case .profile:
            return Text("Vos Paramètres").font(.title2).padding().eraseToAnyView()
        case .weather:
            return Text("Météo du 15ème").eraseToAnyView()
        case .recentSearches:
            return Text("Default header").eraseToAnyView()
        case .suggestedSearches:
            return Text("Default header").eraseToAnyView()
        case .disruption:
            return Text("Signaler un incident").font(.title2).eraseToAnyView()
        default:
            return Text("Default header").eraseToAnyView()

        }
    }
    
    @ViewBuilder func mainView() -> some View {
        switch self.context {
        case .landing:
            HomeMainView()
//        case .search:
//            RecentsView()
        case .profile:
            ProfileMainView()
        case .weather:
            WeatherMainView()
        case .disruption:
            DisruptionMainView()
        default:
            HomeMainView()
        }
    }
    
    init(name: String, position: BottomSheetPosition, options: [BottomSheet.Options], context: SheetContext) {
        
        self.position = position
        self.options = options
        self.context = context
        
        // set name property at last, not before:
        self.name = name
        
        
        let center = MapDetails.parisLocation
        service = LocalSearchService(in: center)
    
        cancellable = service.localSearchPublisher.sink { mapItems in
            self.results = mapItems.map({LocalSearchData(mapItem: $0) })
            
        }
    }
    
}

extension BottomSheetModel {
    static var homeBS = BottomSheetModel(name: "Home Bottom Sheet",
                                         position: .middle,
                                         options: [.allowContentDrag,
                                                   .shadow(),
                                                   .background(AnyView(EffectHelperView(effect: UIBlurEffect(style: .systemThickMaterial)))),
                                                   .animation(.easeIn)
                                                  ],
                                         context: .landing)
    
    static var weatherBS = BottomSheetModel(name: "Weather Bottom Sheet",
                                            position: .hidden,
                                            options: [.notResizeable,
                                                      .shadow(),
                                                      .background(AnyView(EffectHelperView(effect: UIBlurEffect(style: .systemThickMaterial)))),
                                                      .showCloseButton(action: { homeBS.position = .middle })
                                                     ],
                                            context: .weather)
    
    static var profileBS = BottomSheetModel(name: "Profile Bottom Sheet",
                                            position: .hidden,
                                            options: [.tapToDissmiss,
                                                      .notResizeable,
                                                      .shadow(),
                                                      .background(AnyView(EffectHelperView(effect: UIBlurEffect(style: .systemThickMaterial))))
                                                     ],
                                            context: .profile)
    
    static var disruptionBS = BottomSheetModel(name: "Disruption Bottom Sheet",
                                               position: .hidden,
                                               options: [.notResizeable,
                                                         .shadow(),
                                                         .background(AnyView(EffectHelperView(effect: UIBlurEffect(style: .systemThickMaterial)))),
                                                         .showCloseButton(action: { homeBS.position = .middle })
                                                        ],
                                               context: .disruption)
    
    static var favoriteBS = BottomSheetModel(name: "Favorite Bottom Sheet",
                                               position: .hidden,
                                               options: [.allowContentDrag,
                                                         .shadow(),
                                                         .background(AnyView(EffectHelperView(effect: UIBlurEffect(style: .systemThickMaterial)))),
                                                         .showCloseButton(action: { homeBS.position = .middle })
                                                        ],
                                               context: .favorite)
    
}

struct LocalSearchData: Identifiable {
    
    var id = UUID()
    var title: String
    var subtitle: String
    var lat: CLLocationDegrees
    var lon: CLLocationDegrees
    
    init(mapItem: MKMapItem) {
        self.title = mapItem.name ?? ""
        self.subtitle = mapItem.placemark.title ?? ""
        self.lat = mapItem.placemark.location?.coordinate.latitude ?? 0.0
        self.lon = mapItem.placemark.location?.coordinate.longitude ?? 0.0
    }
    
}
