import Foundation
import Starscream

@available(iOS 13.0, *)
public class WebSocketManager {
    
    var socket = WebSocket(request: URLRequest(url: URL(string: "http://45.77.67.171/")!))
    var connectedModel: ConnectedModel?
    var gameConfigModel: GameConfigModel?
    var gameDataModel: GameDataModel?
    
    private var globalSettings = GlobalSettings()

    private var cellLogic: CellLogic
    

    public init(cellLogic: CellLogic){
        self.cellLogic = cellLogic
        globalSettings.clearData()
        del()
    }

    deinit {
      socket.disconnect(forceTimeout: 0)
      socket.delegate = nil
    }
    
    public func connect(roomName: String, watch: Bool) {
        socket.connect()
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            let myData: [String: Any] = ["key": "connect_to_room", "data": ["room_name": roomName, "watch": watch]]
            
            print(myData)

            let myJSON: Data

            do {
                myJSON = try JSONSerialization.data(withJSONObject: myData, options: [])
                if self.socket.isConnected {
                    self.socket.write(data: myJSON)
                }else{
                    self.socket.connect()
                }
            } catch {
                print("Error: cannot create JSON")
                return
            }
        }
   }
    
    private func del() {
        socket.onConnect = {
            print("coonect")
        }
        
        socket.onText = { [weak self] text in
            guard let data = text.data(using: .utf8) else { return }
            guard let gameData = try? JSONDecoder().decode(KeyModel.self, from: data) else { return }
            switch gameData.key {
            case Keys.connected.rawValue:
                let connectData = try? JSONDecoder().decode(ConnectedModel.self, from: data)
                self?.connectedModel = connectData
            case Keys.config.rawValue:
                guard let configData = try? JSONDecoder().decode(GameConfigModel.self, from: data) else { return }
                self?.cellLogic.configure(gameConfig: configData)
            case Keys.data.rawValue:
                guard let gameData = try? JSONDecoder().decode(GameDataModel.self, from: data) else { return }
                print(text)
                self?.dataReceived(tick: gameData.data?.tick ?? 0)
                
                self?.globalSettings.ticksOperation(gameData: gameData)
                self?.globalSettings.cellsOperation(gameData: gameData)
                self?.globalSettings.foodsOperation(gameData: gameData)
                
                self?.playerAction()
                
            default:
                print("raw")
            }
        }
    }
    
    
    private func compare() {
        
    }
    
    
    private func playerAction() {
        if let result = self.cellLogic.handleGameUpdate(mapState: UserData(food: globalSettings.food, cell: globalSettings.cell, tick: globalSettings.tick, lastResivedTick: globalSettings.lastTick)) {
            if result.isEmpty {
                print("empty")
            } else {
                let myData = PlayerAction(key: "player_action", data: PlayerData(cells: result))
                
                print(myData)

                do {
                    let jsonData = try JSONEncoder().encode(myData)
                    self.socket.write(data: jsonData)
                } catch {
                    print("Error: cannot create JSON")
                    return
                }
            }
        }
    }
    
    
    private func dataReceived(tick: Int){
        let myData: [String: Any] = ["key": "data_received", "data": ["tick": tick]]
        
        print(myData)

        let myJSON: Data

        do {
            myJSON = try JSONSerialization.data(withJSONObject: myData, options: [])
            self.socket.write(data: myJSON)
        } catch {
            print("Error: cannot create JSON")
            return
        }
    }
}
