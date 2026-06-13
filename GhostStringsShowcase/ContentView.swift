import SwiftUI
import GhostStrings

struct ContentView: View {
    @ObservedObject var ghostStrings = GhostStrings.shared
    @State private var isAnimating = false
    @State private var isSyncing = false
    @State private var supportedLanguages: [GhostLanguage] = []
    
    private func changeLanguage(to localeId: String) {
        let langCode = localeId == "en" ? nil : localeId
        GhostStrings.shared.setLanguage(langCode) { _ in
            // Re-fetch localized strings list on change completed
        }
    }
    
    var body: some View {
        ZStack {
            // Background Gradient
            Color(red: 0.97, green: 0.98, blue: 0.99)
                .ignoresSafeArea()
            
            // Decorative Glow
            Circle()
                .fill(Color.blue.opacity(0.08))
                .frame(width: 400, height: 400)
                .offset(y: -350)
                .blur(radius: 50)
            
            ScrollView {
                VStack(spacing: 24) {
                    Spacer().frame(height: 40)
                    
                    // Live Badge
                    HStack(spacing: 8) {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 8, height: 8)
                            .opacity(isAnimating ? 0.4 : 1.0)
                        
                        Text(NSLocalizedString(GhostStringsKeys.heroBadge, comment: ""))
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.blue)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.blue.opacity(0.05))
                    .clipShape(Capsule())
                    .overlay(Capsule().stroke(Color.blue.opacity(0.1), lineWidth: 1))
                    
                    // Hero Title — Animated
                    let heroTitle = NSLocalizedString(GhostStringsKeys.heroTitle, comment: "")
                    Text(heroTitle)
                        .font(.system(size: 36, weight: .black))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .id(heroTitle) // Force transition when text changes
                        .transition(.asymmetric(insertion: .opacity.combined(with: .move(edge: .bottom)), removal: .opacity))
                    
                    // Hero Subtitle — Animated
                    let heroSubtitle = NSLocalizedString(GhostStringsKeys.heroSubtitle, comment: "")
                    Text(heroSubtitle)
                        .font(.system(size: 16))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                        .id(heroSubtitle) // Force transition when text changes
                        .transition(.opacity)
                    
                    // Stats Row
                    HStack(spacing: 0) {
                        StatItem(valueKey: GhostStringsKeys.stat1Value, labelKey: GhostStringsKeys.stat1Label, defaultVal: "∞%", defaultLabel: "Speed Increase")
                        Divider().frame(height: 40).padding(.horizontal)
                        StatItem(valueKey: GhostStringsKeys.stat2Value, labelKey: GhostStringsKeys.stat2Label, defaultVal: "1KB", defaultLabel: "SDK Footprint")
                        Divider().frame(height: 40).padding(.horizontal)
                        StatItem(valueKey: GhostStringsKeys.stat3Value, labelKey: GhostStringsKeys.stat3Label, defaultVal: "Real-time", defaultLabel: "OTA Delivery")
                    }
                    .padding(24)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: Color.black.opacity(0.03), radius: 10, x: 0, y: 5)
                    .padding(.horizontal)
                    
                    // Promo Banner
                    HStack {
                        Text(NSLocalizedString(GhostStringsKeys.promoText, comment: ""))
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.blue)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue.opacity(0.05))
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                    .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.blue.opacity(0.1), lineWidth: 1))
                    .padding(.horizontal)
                    
                    Spacer().frame(height: 20)
                    
                    // Language Selection Dropdown
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Active Language")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(.secondary)
                            .textCase(.uppercase)
                            .padding(.horizontal)
                        
                        Menu {
                            Button("English (EN)", action: {
                                changeLanguage(to: "en")
                            })
                            ForEach(supportedLanguages.filter { $0.localeId != "en" }, id: \.localeId) { langObj in
                                Button("\(langObj.label) (\(langObj.localeId.uppercased()))", action: {
                                    changeLanguage(to: langObj.localeId)
                                })
                            }
                        } label: {
                            HStack {
                                let activeLang = GhostStrings.shared.getLanguage() ?? "en"
                                let currentLangObj = supportedLanguages.first(where: { $0.localeId == activeLang })
                                Text(currentLangObj != nil ? "\(currentLangObj!.label) (\(currentLangObj!.localeId.uppercased()))" : "English (EN)")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.up.chevron.down")
                                    .foregroundColor(.secondary)
                                    .font(.system(size: 12))
                             }
                            .padding(.horizontal, 16)
                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                            .background(Color.black.opacity(0.04))
                            .cornerRadius(12)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.blue.opacity(0.1), lineWidth: 1))
                        }
                        .padding(.horizontal)
                    }
                    
                    // Manual Sync Button
                    Button(action: {
                        isSyncing = true
                        Task {
                            await GhostStrings.shared.sync()
                            let list = await GhostStrings.shared.getSupportedLanguages(force: true)
                            await MainActor.run {
                                self.supportedLanguages = list
                                self.isSyncing = false
                            }
                        }
                    }) {
                        HStack {
                            if isSyncing {
                                ProgressView()
                                    .padding(.trailing, 4)
                                Text("Checking for updates...")
                            } else {
                                Image(systemName: "arrow.triangle.2.circlepath")
                                Text("Check for Updates")
                            }
                        }
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.blue)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(Color.blue.opacity(0.1))
                        .clipShape(Capsule())
                    }
                    .disabled(isSyncing)
                    
                    // Exit Button
                    Button(action: {
                        exit(0)
                    }) {
                        Text("Exit Demo")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.red)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                            .background(Color.red.opacity(0.1))
                            .clipShape(Capsule())
                         
                    }
                    
                    Spacer().frame(height: 40)
                }
                .animation(.spring(response: 0.6, dampingFraction: 0.8), value: ghostStrings.strings)
            }
            .refreshable {
                await GhostStrings.shared.sync()
                let list = await GhostStrings.shared.getSupportedLanguages(force: true)
                await MainActor.run {
                    self.supportedLanguages = list
                }
            }
        }
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 0.9).repeatForever(autoreverses: true)) {
                isAnimating = true
            }
            Task {
                let list = await GhostStrings.shared.getSupportedLanguages()
                await MainActor.run {
                    self.supportedLanguages = list
                }
            }
        }
    }
}

struct StatItem: View {
    let valueKey: String
    let labelKey: String
    let defaultVal: String
    let defaultLabel: String
    
    var body: some View {
        let localizedValue = NSLocalizedString(valueKey, comment: "")
        let localizedLabel = NSLocalizedString(labelKey, comment: "")
        
        VStack(spacing: 4) {
            Text(localizedValue == valueKey ? defaultVal : localizedValue)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.blue)
                .id(localizedValue) // Force transition
                .transition(.asymmetric(insertion: .move(edge: .top).combined(with: .opacity), removal: .move(edge: .bottom).combined(with: .opacity)))
            
            Text(localizedLabel == labelKey ? defaultLabel : localizedLabel)
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}
