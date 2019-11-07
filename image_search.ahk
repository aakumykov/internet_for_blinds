#SingleInstance, force

F6::
; ImageSearch, OutputVarX, OutputVarY, 270, 220, 506, 280, 1.bmp
; ImageSearch, OutputVarX, OutputVarY, 4, 100, 111, 153, yandex.bmp
; ImageSearch, OutputVarX, OutputVarY, 842, 198, 874, 227, 3.bmp
; ImageSearch, OutputVarX, OutputVarY, 6, 70, 150, 94, 5.bmp
; ImageSearch, OutputVarX, OutputVarY, 72, 39, 102, 68, firefox-page-load-complete-default.bmp ; работает
; ImageSearch, OutputVarX, OutputVarY, 103, 40, 130, 67, *10 home.bmp
ImageSearch, OutputVarX, OutputVarY, 86, 46, 127, 85, 1.bmp
MsgBox %ErrorLevel%
; firefox-page-load-complete-default.bmp

; if (pageIsLoaded()) {
; ; if (is_text_reader_mode()) {
; 	MsgBox "page is loaded"
; ; 	MsgBox "text reader mode"
; }
; else {
; 	MsgBox "page is not loaded"
; ; 	MsgBox "not text reader mode"
; }

; clickTextReaderButton()
return