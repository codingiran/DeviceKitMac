# Device Model Updates

Last checked: **2026-09-23**. This update adds 11 identifiers for released Macs.
Existing display names and the raw-identifier fallback remain unchanged.

## Added mappings

| Identifier | Display name | References |
| --- | --- | --- |
| `Mac18,5` | Mac Mini M6 2026 | [Apple Mac mini][mini], [AppleDB][db-mini-m6] |
| `Mac17,16` | Mac Mini M5 Pro 2026 | [AppleDB][db-mini-pro], [IPSW device directory][ipsw]; see discrepancy below |
| `Mac17,3` | MacBook Air M5 2026 13inch | [Apple MacBook Air][air] |
| `Mac17,4` | MacBook Air M5 2026 15inch | [Apple MacBook Air][air] |
| `Mac17,5` | MacBook Neo A18 Pro 2026 | [Apple specifications][neo], [AppleDB][db-neo], [IPSW device directory][ipsw] |
| `Mac17,9` | MacBook Pro 14inch M5 Pro | [Apple MacBook Pro][pro], [AppleDB][db-pro], [IPSW device directory][ipsw] |
| `Mac17,7` | MacBook Pro 14inch M5 Max | [Apple MacBook Pro][pro], [AppleDB][db-pro], [IPSW device directory][ipsw] |
| `Mac17,8` | MacBook Pro 16inch M5 Pro | [Apple MacBook Pro][pro], [AppleDB][db-pro], [IPSW device directory][ipsw] |
| `Mac17,6` | MacBook Pro 16inch M5 Max | [Apple MacBook Pro][pro], [AppleDB][db-pro], [IPSW device directory][ipsw] |
| `Mac17,14` | Mac Studio M5 Max 2026 | [Apple Mac Studio][studio], [AppleDB][db-studio] |
| `Mac17,15` | Mac Studio M5 Ultra 2026 | [Apple Mac Studio][studio], [AppleDB][db-studio], [IPSW device directory][ipsw] |

Apple's MacBook Pro identification page groups the Pro and Max configurations by
screen size. AppleDB and IPSW distinguish the chip associated with each identifier;
do not infer the chip from the order of identifiers on Apple's page.

The existing table already includes the 2025 base M5 MacBook Pro (`Mac17,2`).
The [iMac][imac] and [Mac Pro][mac-pro] identification pages list no newer models
than those already represented in the table.

## Source discrepancy: Mac mini and Mac Studio

At the check date, Apple's Mac mini identification article lists `Mac17,15` for
the M5 Pro model, while its Mac Studio article lists the same identifier for M5
Ultra. The [Mac mini specifications][mini-specs] confirm the M5 Pro configuration
but do not resolve the identifier conflict.

This table uses the mutually consistent AppleDB and IPSW records:

- `Mac17,16`: Mac mini M5 Pro, board `J873sAP`, board ID `0x02`.
- `Mac17,15`: Mac Studio M5 Ultra, board `J775dAP`, board ID `0x12`.

The Studio mapping also agrees with Apple's Studio identification article.
Both mappings have separate regression cases. Recheck these sources during the
next model update; do not alias `Mac17,15` to Mac mini.

## Maintaining the table

Confirm the released model, identifier, chip, and screen size against the sources
above. Add its mapping under the matching family in `DeviceKitMac.swift` and an
explicit identifier/display-name pair in `DeviceModelTests.swift`. Run
`swift test`; tests use local fixtures and do not fetch these websites.

[mini]: https://support.apple.com/en-us/102852
[mini-specs]: https://support.apple.com/en-us/128108
[air]: https://support.apple.com/en-us/102869
[pro]: https://support.apple.com/en-us/108052
[studio]: https://support.apple.com/en-us/102231
[neo]: https://www.apple.com/macbook-neo/specs/
[imac]: https://support.apple.com/en-us/108054
[mac-pro]: https://support.apple.com/en-us/102887
[ipsw]: https://api.ipsw.me/v4/devices
[db-mini-m6]: https://github.com/littlebyteorg/appledb/blob/main/deviceFiles/Mac%20mini/Mac18%2C5.json
[db-mini-pro]: https://github.com/littlebyteorg/appledb/blob/main/deviceFiles/Mac%20mini/Mac17%2C16.json
[db-neo]: https://github.com/littlebyteorg/appledb/blob/main/deviceFiles/Macbook%20Neo/Mac17%2C5.json
[db-pro]: https://github.com/littlebyteorg/appledb/tree/main/deviceFiles/Macbook%20Pro
[db-studio]: https://github.com/littlebyteorg/appledb/tree/main/deviceFiles/Mac%20Studio
