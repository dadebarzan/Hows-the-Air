//
//  ContentView.swift
//  How's the air?
//
//  Created by Davide Barzan on 18/02/26.
//

import SwiftUI

// Modello dati per il mockup
struct CityAQI: Identifiable {
    let id = UUID()
    let name: String
    let value: Int
    
    // Logica colore base AQI
    var color: Color {
        switch value {
        case 0...50: return .green
        case 51...100: return .yellow
        case 101...150: return .orange
        default: return .red
        }
    }
}

struct ContentView: View {
    // Dati fittizi per riempire la lista
    let cities: [CityAQI] = [
        CityAQI(name: "Milano", value: 112),
        CityAQI(name: "Roma", value: 45),
        CityAQI(name: "Torino", value: 155),
        CityAQI(name: "Napoli", value: 88),
        CityAQI(name: "Firenze", value: 52),
        CityAQI(name: "Venezia", value: 25),
        CityAQI(name: "Bologna", value: 95),
        CityAQI(name: "Bari", value: 60),
        CityAQI(name: "Palermo", value: 30),
        CityAQI(name: "Genova", value: 75)
    ]
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            // 1. Background
            LinearGradient(
                colors: [Color.orange.opacity(0.2), Color.blue.opacity(0.2)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // 2. Main Layout
            ZStack(alignment: .top) {
                
                // --- SCROLLABLE CONTENT ---
                ScrollView {
                    VStack(spacing: 20) {
                        
                        // Prima Card: Placeholder -> Mostrare stats città preferita / avvisi relativi alla qualità dell'aria di città preferita
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.white)
                            .aspectRatio(1.0, contentMode: .fit)
                            .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
                        
                        // Seconda Card: Lista città + AQI (palceholder)
                        VStack(spacing: 0) {
                            ForEach(cities) { city in
                                HStack {
                                    Text(city.name)
                                        .font(.body.weight(.medium))
                                    
                                    Spacer()
                                    
                                    Text("\(city.value)")
                                        .font(.headline)
                                        .foregroundStyle(city.color)
                                }
                                .padding()
                                
                                // Aggiungo divisore tranne per l'ultimo elemento
                                if city.id != cities.last?.id {
                                    Divider()
                                        .padding(.leading)
                                }
                            }
                        }
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
                        
                        // Spazio extra in fondo
                        Spacer()
                            .frame(height: 80)
                    }
                    .padding(.horizontal) // Padding laterale
                    .padding(.top, 80)    // Padding superiore per non finire sotto l'header all'inizio
                }
                // Maschera sfumata in alto E in basso
                .mask(
                    LinearGradient(
                        stops: [
                            .init(color: .clear, location: 0),      // Inizio trasparente (top)
                            .init(color: .clear, location: 0.05),   // Leggermente più giù per l'header
                            .init(color: .black, location: 0.15),   // Inizio visibilità piena
                            .init(color: .black, location: 0.85),   // Fine visibilità piena
                            .init(color: .clear, location: 1),   // Inizio sfumatura bottom
                            .init(color: .clear, location: 1)       // Fine trasparente (bottom)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                
                // --- FIXED HEADER ---
                HStack {
                    Text(Date.now, format: .dateTime.weekday().day().month(.wide))
                        .font(.title.bold())
                        .foregroundStyle(.primary)
                    
                    Spacer()
                    
                    Button {
                        // TODO: Action per aggiungere città
                    } label: {
                        Image(systemName: "plus")
                            .font(.title2.weight(.medium))
                            .foregroundStyle(.white)
                            .frame(width: 50, height: 50)
                            .background(Color.blue.opacity(0.7), in: Circle())
                            .background(.ultraThinMaterial, in: Circle())
                            .overlay(
                                Circle()
                                    .stroke(.white.opacity(0.3), lineWidth: 1)
                            )
                            .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 5)
                    }
                }
                .padding() // Padding esterno
                // Nessun background qui, così è trasparente
            }
            
            // 3. Floating Search Button
            Button {
                // TODO: Ricerca città
            } label: {
                Image(systemName: "magnifyingglass")
                    .font(.title2.weight(.medium))
                    .foregroundStyle(.black)
                    .frame(width: 60, height: 60)
                    .background(.ultraThinMaterial, in: Circle())
                    .overlay(
                        Circle()
                            .stroke(.white.opacity(0.3), lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
