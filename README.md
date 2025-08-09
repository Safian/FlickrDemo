# FlickrDemo

**FlickrDemo** egy modern SwiftUI alapú iOS alkalmazás, amely a Flickr API-t használva böngészhetővé teszi a Flickr fotóit kulcsszavas kereséssel, galéria- és részletező nézettel. A projekt célja modern iOS architektúra, DI és tiszta kód bemutatása.

---

## Fő funkciók

- **Képek keresése** a Flickr nyilvános API-ján keresztül, kulcsszó alapján
- **Lista nézet**: 2 oszlopos grid, 20 elem/lapozva, végtelen görgetéssel
- **Első indításkor**: alapértelmezett szóval (“dog”) keresés
- **Legutóbbi keresés**: minden újabb app indításnál a legutolsó kulcsszóval indul
- **Részlet nézet**: fénykép nagyítás (pinch zoom, drag), cím, adatok
- **Dependency Injection**: Swinject konténer
- **Testelhetőség**: Mock rétegek, 100% code coverage a core-on

---

## Technológiák

- **Swift 5+, SwiftUI**
- **Combine** (aszinkron API hívások)
- **Swinject** (Dependency Injection)
- **Flickr API**
- **ViewInspector** tesztekhez

---

## Elindítás/Xcode build

1. **Klónozd a repót:**
    ```
    git clone git@github.com:Safian/FlickrDemo.git
    ```
    vagy
    ```
    git clone https://github.com/Safian/FlickrDemo.git
    ```
2. **Nyisd meg Xcode-dal** (ajánlott: Xcode 16+)
3. **Telepítsd a kötelező fejlesztői toolokat:**
    - [SwiftLint](https://github.com/realm/SwiftLint):  
      Ha van Homebrew-öd:
      ```sh
      brew install swiftlint
      ```
    - [SwiftFormat](https://github.com/nicklockwood/SwiftFormat):
      ```sh
      brew install swiftformat
      ```
4. **Szükséges SPM package-k:** 
   - Swinject
   - ViewInspector (**csak test targetre**!)
5. **Futtasd a projektet** iOS 18.5 vagy újabb szimulátoron vagy eszközön.

---

## Tesztelés

- Xcode-ban:  
  “Test” (Cmd+U)

---

## Konfiguráció

- **Flickr API kulcs**: `Core/API/FlickrConstants.swift` fájlban találod.
- Szükséges SPM package-k automatikusan letöltődnek projekt megnyitáskor.

---

## Képernyőképek

**Készítette:**  
*Sáfián Szabolcs*  
(GitHub: [safian-github](https://github.com/Safian?tab=repositories))


