import Foundation
import Starscream

@available(iOS 13.0, *)
public class WebSocketManager {
    
    var socket = WebSocket(request: URLRequest(url: URL(string: "http://45.77.67.171/")!))
    var connectedModel: ConnectedModel?
    var gameConfigModel: GameConfigModel?
    var gameDataModel: GameDataModel?

    public init(){
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
        
        socket.onText = { text in
            let data = text.data(using: .utf8)
            let gameData = try? JSONDecoder().decode(KeyModel.self, from: data!)
            switch gameData?.key {
            case Keys.connected.rawValue:
                let connectData = try? JSONDecoder().decode(ConnectedModel.self, from: data!)
                self.connectedModel = connectData
            case Keys.config.rawValue:
                let configData = try? JSONDecoder().decode(GameConfigModel.self, from: data!)
                self.gameConfigModel = configData
                print(text)
            case Keys.data.rawValue:
                let gameData = try? JSONDecoder().decode(GameDataModel.self, from: data!)
                self.gameDataModel = gameData
                print(text)
                self.dataReceived(tick: gameData?.data?.tick ?? 0)
            default:
                print("raw")
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
