//
//  File.swift
//  SSC2025
//
//  Created by aplle on 1/11/25.
//

import SwiftUI
fileprivate extension String {
    subscript(i: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: i)]
    }
}

class Vigenere {
    let alphabet: String
    let alphabetSize: Int
    let key: String
    let keySize: Int

    init(alphabet: String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ", key: String) {
        self.alphabet = alphabet.uppercased()
        self.alphabetSize = alphabet.count
        self.key = key.uppercased()
        self.keySize = key.count
    }

    func encrypt(plainText: String) -> String {
        var encryptedText = ""
        var index = 0

        for character in plainText.uppercased() {
            let indexInAlphabet = indexOfAlphabet(forCharacter: character)

            if indexInAlphabet == -1 {
                encryptedText.append(character)
                continue
            }

            let keyToEncryptWith = key[index % keySize]
            let keyIndexInAlphabet = indexOfAlphabet(forCharacter: keyToEncryptWith)
            let encryptedLetterIndex = (indexInAlphabet + keyIndexInAlphabet + alphabetSize) % alphabetSize
            encryptedText.append(alphabet[encryptedLetterIndex])
            index += 1
        }

        return encryptedText
    }

    func decrypt(encryptedText: String) -> String {
        var decryptedText = ""
        var index = 0

        for character in encryptedText.uppercased() {
            let indexInAlphabet = indexOfAlphabet(forCharacter: character)

            if indexInAlphabet == -1 {
                decryptedText.append(character)
                continue
            }

            let keyToEncryptWith = key[index % keySize]
            let keyIndexInAlphabet = indexOfAlphabet(forCharacter: keyToEncryptWith)
            let encryptedLetterIndex = (indexInAlphabet - keyIndexInAlphabet + alphabetSize) % alphabetSize
            decryptedText.append(alphabet[encryptedLetterIndex])
            index += 1
        }

        return decryptedText
    }

    private func indexOfAlphabet(forCharacter character: Character) -> Int {
        var index = 0

        for chr in alphabet {
            if chr == character {
                return index
            }
            index += 1
        }

        return -1
    }
}
