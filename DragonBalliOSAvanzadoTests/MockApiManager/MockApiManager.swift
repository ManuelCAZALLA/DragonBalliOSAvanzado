//
//  MockApiManager.swift
//  DragonBalliOSAvanzadoTests
//
//  Created by Manuel Cazalla Colmenero on 29/10/24.
//

import Foundation
import DragonBalliOSAvanzado

class MockApiManager: ApiManagerProtocol {
    let responseDataLocations: [[String: Any]] = [
        [
            "id": "B93A51C8-C92C-44AE-B1D1-9AFE9BA0BCCC",
            "dateShow": "2022-02-20T00:00:00Z",
            "hero": [
                "id": "D13A40E5-4418-4223-9CE6-D2F9A28EBE94"
            ],
            "latitud": "35.71867899343361",
            "longitud": "139.8202084625344"
        ],
        [
            "id": "2D83941D-3F84-458C-8A24-704E59D5FAEB",
            "dateShow": "2023-01-07T00:00:00Z",
            "hero": [
                "id": "D13A40E5-4418-4223-9CE6-D2F9A28EBE94"
            ],
            "latitud": "139.8202084625344",
            "longitud": "35.71867899343361"
        ]
    ]
    
    let responseDataHeroes: [[String: Any]] = [
        [
            "description": "Es un maestro de artes marciales que tiene una escuela, donde entrenará a Goku y Krilin para los Torneos de Artes Marciales. Aún en los primeros episodios había un toque de tradición y disciplina, muy bien representada por el maestro. Pero Muten Roshi es un anciano extremadamente pervertido con las chicas jóvenes, una actitud que se utilizaba en escenas divertidas en los años 80. En su faceta de experto en artes marciales, fue quien le enseñó a Goku técnicas como el Kame Hame Ha",
            "name": "Maestro Roshi",
            "favorite": false,
            "photo": "https://cdn.alfabetajuega.com/alfabetajuega/2020/06/Roshi.jpg?width=300",
            "id": "14BB8E98-6586-4EA7-B4D7-35D6A63F5AA3"
        ],
        [
            "description": "Mr. Satán es un charlatán fanfarrón, capaz de manipular a las masas. Pero en realidad es cobarde cuando se da cuenta que no puede contra su adversario como ocurrió con Androide 18 o Célula. Siempre habla más de la cuenta, pero en algún momento del combate empieza a suplicar. Androide 18 le ayuda a fingir su victoria a cambio de mucho dinero. Él acepta el trato porque no podría soportar que todo el mundo le diera la espalda por ser un fraude.",
            "name": "Mr. Satán",
            "favorite": false,
            "photo": "https://cdn.alfabetajuega.com/alfabetajuega/2020/06/dragon-ball-satan.jpg?width=300",
            "id": "1985A353-157F-4C0B-A789-FD5B4F8DABDB"
        ],
        [
            "description": "Krilin lo tiene todo. Cuando aún no existían los 'memes', Krilin ya los protagonizaba. Junto a Yamcha ha sido objeto de burla por sus desafortunadas batallas en Dragon Ball Z. Inicialmente, Krilin era el mejor amigo de Goku siendo sólo dos niños que querían aprender artes marciales. El Maestro Roshi les entrena para ser dos grandes luchadores, pero la diferencia entre ambos cada vez es más evidente. Krilin era ambicioso y se ablanda con el tiempo. Es un personaje que acepta un papel secundario para apoyar el éxito de su mejor amigo Goku de una forma totalmente altruista.",
            "name": "Krilin",
            "favorite": false,
            "photo": "https://cdn.alfabetajuega.com/alfabetajuega/2020/08/Krilin.jpg?width=300",
            "id": "ID_DE_KRILIN_AQUI"
        ]
    ]
    
    
    
    func login(user: String, password: String, completion: ((Result<String, DragonBalliOSAvanzado.ApiError>) -> Void)?) {
        let token = "TokenApiDragonBall"
        completion?(.success(token))
    }
    
    func getHeroes(by name: String?, token: String, completion: ((Result<DragonBalliOSAvanzado.Heroes, DragonBalliOSAvanzado.ApiError>) -> Void)?) {
        do {
            let data = try JSONSerialization.data(withJSONObject: responseDataHeroes)
            var heroes = try JSONDecoder().decode([Hero].self, from: data)
            
            if let heroName = name {
                heroes = heroes.filter { $0.name == heroName }
            }
            
            completion?(.success(heroes))
        } catch {
            completion?(.failure(.decodingFailed))
        }
    }
    
    func getLocations(by idHero: String?, token: String, completion: ((Result<DragonBalliOSAvanzado.HeroLocations, DragonBalliOSAvanzado.ApiError>) -> Void)?) {
        do {
            let data = try JSONSerialization.data(withJSONObject: responseDataLocations)
            var locations = try JSONDecoder().decode([HeroLocation].self, from: data)
            
            if let heroId = idHero {
                locations = locations.filter { $0.hero?.id == heroId }
            }
            
            completion?(.success(locations))
        } catch {
            completion?(.failure(.decodingFailed))
        }
    }
    
}


