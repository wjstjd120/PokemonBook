//
//  KoreanNamesUtil.swift
//  PokemonBook
//
//  Created by 전성진 on 8/7/24.
//

import Foundation

enum PokemonTranslator {
    private static let koreanNames: [String: String] = [
        "bulbasaur": "이상해씨",
        "ivysaur": "이상해풀",
        "venusaur": "이상해꽃",
        "charmander": "파이리",
        "charmeleon": "리자드",
        "charizard": "리자몽",
        "squirtle": "꼬부기",
        "wartortle": "어니부기",
        "blastoise": "거북왕",
        "caterpie": "캐터피",
        "metapod": "단데기",
        "butterfree": "버터플",
        "weedle": "뿔충이",
        "kakuna": "딱충이",
        "beedrill": "독침붕",
        "pidgey": "구구",
        "pidgeotto": "피죤",
        "pidgeot": "피죤투",
        "rattata": "꼬렛",
        "raticate": "레트라",
        "spearow": "깨비참",
        "fearow": "깨비드릴조",
        "ekans": "아보",
        "arbok": "아보크",
        "pikachu": "피카츄",
        "raichu": "라이츄",
        "sandshrew": "모래두지",
        "sandslash": "고지",
        "nidoran-f": "니드런♀",
        "nidorina": "니드리나",
        "nidoqueen": "니드퀸",
        "nidoran-m": "니드런♂",
        "nidorino": "니드리노",
        "nidoking": "니드킹",
        "clefairy": "삐삐",
        "clefable": "픽시",
        "vulpix": "식스테일",
        "ninetales": "나인테일",
        "jigglypuff": "푸린",
        "wigglytuff": "푸크린",
        "zubat": "주뱃",
        "golbat": "골뱃",
        "oddish": "뚜벅쵸",
        "gloom": "냄새꼬",
        "vileplume": "라플레시아",
        "paras": "파라스",
        "parasect": "파라섹트",
        "venonat": "콘팡",
        "venomoth": "도나리",
        "diglett": "디그다",
        "dugtrio": "닥트리오",
        "meowth": "나옹",
        "persian": "페르시온",
        "psyduck": "고라파덕",
        "golduck": "골덕",
        "mankey": "망키",
        "primeape": "성원숭",
        "growlithe": "가디",
        "arcanine": "윈디",
        "poliwag": "발챙이",
        "poliwhirl": "슈륙챙이",
        "poliwrath": "강챙이",
        "abra": "캐이시",
        "kadabra": "윤겔라",
        "alakazam": "후딘",
        "machop": "알통몬",
        "machoke": "근육몬",
        "machamp": "괴력몬",
        "bellsprout": "모다피",
        "weepinbell": "우츠동",
        "victreebel": "우츠보트",
        "tentacool": "왕눈해",
        "tentacruel": "독파리",
        "geodude": "꼬마돌",
        "graveler": "데구리",
        "golem": "딱구리",
        "ponyta": "포니타",
        "rapidash": "날쌩마",
        "slowpoke": "야도란",
        "slowbro": "야도킹",
        "magnemite": "코일",
        "magneton": "레어코일",
        "farfetchd": "파오리",
        "doduo": "두두",
        "dodrio": "두트리오",
        "seel": "쥬쥬",
        "dewgong": "쥬레곤",
        "grimer": "질퍽이",
        "muk": "질뻐기",
        "shellder": "셀러",
        "cloyster": "파르셀",
        "gastly": "고오스",
        "haunter": "고우스트",
        "gengar": "팬텀",
        "onix": "롱스톤",
        "drowzee": "슬리프",
        "hypno": "슬리퍼",
        "krabby": "크랩",
        "kingler": "킹크랩",
        "voltorb": "찌리리공",
        "electrode": "붐볼",
        "exeggcute": "아라리",
        "exeggutor": "나시",
        "cubone": "탕구리",
        "marowak": "텅구리",
        "hitmonlee": "시라소몬",
        "hitmonchan": "홍수몬",
        "lickitung": "내루미",
        "koffing": "또가스",
        "weezing": "또도가스",
        "rhyhorn": "뿔카노",
        "rhydon": "코뿌리",
        "chansey": "럭키",
        "tangela": "덩쿠리",
        "kangaskhan": "캥카",
        "horsea": "쏘드라",
        "seadra": "시드라",
        "goldeen": "콘치",
        "seaking": "왕콘치",
        "staryu": "별가사리",
        "starmie": "아쿠스타",
        "mr-mime": "마임맨",
        "scyther": "스라크",
        "jynx": "루주라",
        "electabuzz": "에레브",
        "magmar": "마그마",
        "pinsir": "쁘사이저",
        "tauros": "켄타로스",
        "magikarp": "잉어킹",
        "gyarados": "갸라도스",
        "lapras": "라프라스",
        "ditto": "메타몽",
        "eevee": "이브이",
        "vaporeon": "샤미드",
        "jolteon": "쥬피썬더",
        "flareon": "부스터",
        "porygon": "폴리곤",
        "omanyte": "암나이트",
        "omastar": "암스타",
        "kabuto": "투구",
        "kabutops": "투구푸스",
        "aerodactyl": "프테라",
        "snorlax": "잠만보",
        "articuno": "프리져",
        "zapdos": "썬더",
        "moltres": "파이어",
        "dratini": "미뇽",
        "dragonair": "신뇽",
        "dragonite": "망나뇽",
        "mewtwo": "뮤츠",
        "mew": "뮤"
    ]
    
    static func getKoreanName(for englishName: String) -> String {
        return koreanNames[englishName.lowercased()] ?? englishName
    }
}

enum PokemonTypeName: String, CaseIterable, Codable {
    case normal
    case fire
    case water
    case electric
    case grass
    case ice
    case fighting
    case poison
    case ground
    case flying
    case psychic
    case bug
    case rock
    case ghost
    case dragon
    case dark
    case steel
    case fairy

    var displayName: String {
        switch self {
        case .normal: return "노말"
        case .fire: return "불꽃"
        case .water: return "물"
        case .electric: return "전기"
        case .grass: return "풀"
        case .ice: return "얼음"
        case .fighting: return "격투"
        case .poison: return "독"
        case .ground: return "땅"
        case .flying: return "비행"
        case .psychic: return "에스퍼"
        case .bug: return "벌레"
        case .rock: return "바위"
        case .ghost: return "고스트"
        case .dragon: return "드래곤"
        case .dark: return "어둠"
        case .steel: return "강철"
        case .fairy: return "페어리"
        }
    }
}
