# zTTSDialogues
With this plugin unvoiced, or optionally all in-game dialogues, will be read with Windows Narrator.

### Default config
```
[ZTTSDIALOGUES]
VoiceVolume=-1
;
; Volume of the TTS voice: -1 = autodetect

VoiceRate=11
; 
; Speed of the text reading (min: 0, max: 20)

ReplaceAllDialogues=0
;
; Replace all original dialogues with TTS (1) or only dialogues without voice files (0)

Language=2
;
; Language of the TTS
; 0 - Other, need to specify LanguageID and CodePage
;;; To find CodePage: https://learn.microsoft.com/pl-pl/windows/win32/intl/code-page-identifiers
;;; To find LanguageID: https://documentation.help/Microsoft-Speech-Platform-SDK-11/c494fcf6-5053-42ad-9528-9948c2d93855.htm
;;; Default values for English (United States)
;;; CodePage=1252
;;; LanguageID=409
;
;
; 1 - Russian
; 2 - English (United States)
; 3 - German
; 4 - Polish
; 5 - Romanian
; 6 - Italian
; 7 - Czech
; 8 - Spanish

Gender=0
;
; Gender of the TTS
; 0 - Male
; 1 - Female
```
