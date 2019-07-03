
; Путь к исполняемому файлу NVDA
nvda_cmd := "C:\Program Files (x86)\NVDA\nvda.exe"

; Путь к исполняемому файлу веб-сервера (рекомендуется HTTP File Server от Rejetto)
web_server_command := "C:\Program Files (x86)\hfs.exe"

; Путь к исполняемому файлу утилиты NirCMD
nircmd := "c:\Program Files\nircmd.exe"

; Путь к исполняемому файлу mpg123.exe (консольной программы для выигрывания звука)
sound_player_command := "C:\Program Files\mpg123-1.25.10-static-x86-64\mpg123.exe"

; Координаты области адресной строки для browser_functions/search_image_in_address_bar()
address_bar_x1 := 130
address_bar_y1 := 30
address_bar_x2 := 600
address_bar_y2 := 75

; Координаты кнопки активации режима чтения Firefox
reader_mode_enable_button_x := 59
reader_mode_enable_button_y := 84

; reader_mode_disable_button_x := 
; reader_mode_disable_button_y := 

; Время на открытие браузером вкладки
tab_open_delay := 200

; Время ожидания звгрузки страницы
page_load_wait_time := 10000

; Время ожидания активации режима чтения
reader_mode_wait_time := 6000

; Картинка, по которой определяется, что страница загружена
firefox_page_is_loaded_image := "firefox-page-load-complete.bmp"
; Область поиска этой картинки
; Дом
firefox_page_is_loaded_x1 := 76
firefox_page_is_loaded_y1 := 47
firefox_page_is_loaded_x2 := 100
firefox_page_is_loaded_y2 := 72
; Работа
;firefox_page_is_loaded_x1 := 67
;firefox_page_is_loaded_y1 := 38
;firefox_page_is_loaded_x2 := 102
;firefox_page_is_loaded_y2 := 68

; Картинка, по которой определяется режим чтения
reader_mode_image_pattern := "reader-mode-letter-ingeneer.bmp"
; Область поиска этой картинки
; Дом
reader_mode_serch_area_x1 := 0
reader_mode_serch_area_y1 := 164
reader_mode_serch_area_x2 := 38
reader_mode_serch_area_y2 := 202
; Работа