; ============= ГЛАВНЫЕ НАСТРОЙКИ ==========

; Картинка, по которой определяется, что страница загружена
page_is_loaded_image_pattern := "firefox-page-load-complete-default.bmp"

; Область поиска этой картинки 86, 46, 127, 85
page_is_loaded_search_area_x1 := 86
page_is_loaded_search_area_y1 := 46
page_is_loaded_search_area_x2 := 127
page_is_loaded_search_area_y2 := 85

; Координаты кнопки перехода в режим чтения Firefox
reader_mode_enable_button_x := 150
reader_mode_enable_button_y := 50

; Картинка, по которой определяется режим чтения
reader_mode_image_pattern := "reader-mode-image-pattern.bmp"

; Область поиска этой картинки
; reader_mode_serch_area_x1 := 0 
; reader_mode_serch_area_y1 := 164 
; reader_mode_serch_area_x2 := 38
; reader_mode_serch_area_y2 := 202 

reader_mode_serch_area_x1 := 1
reader_mode_serch_area_y1 := 98 
reader_mode_serch_area_x2 := 37
reader_mode_serch_area_y2 := 161 

; Картинка для определения отсутствия читабельной версии
no_readable_version_image_pattern := "no-readable-vertion-image-pattern.bmp"
no_readable_version_x1 := 500 
no_readable_version_y1 := 200 
no_readable_version_x2 := 930 
no_readable_version_y2 := 250

; Координаты "пустого места" на странице открытого видео на Youtube
youtube_empty_place_x := 177
youtube_empty_place_y := 104

; Координаты кнопки "Играть/Остановить" видео на Youtube
youtube_play_button_x := 713
youtube_play_button_y := 457

; Кнопки управления чтением в режиме Чтеца
reader_main_button_x := 22
reader_main_button_y := 239

reader_prev_button_x := 100
reader_prev_button_y := 214

reader_next_button_x := 300
reader_next_button_y := 214

reader_play_pause_button_x := 195
reader_play_pause_button_y := 216



; ============= ВСПОМОГАТЕЛЬНЫЕ ПРОГРАММЫ ==========

; Путь к исполняемому файлу NVDA
;nvda_cmd := "C:\Program Files\NVDA\nvda.exe"
; nvda_cmd := %A_ScriptDir%\..\NVDA\nvda.exe"
nvda_cmd := "C:\INTERNET_READER_FOR_BLINDS\NVDA\nvda.exe"

; Путь к исполняемому файлу веб-сервера (рекомендуется HTTP File Server от Rejetto)
web_server_command := "C:\Program Files\hfs.exe"
; web_server_command := %A_ScriptDir%\..\hfs.exe

; Путь к исполняемому файлу утилиты NirCMD
nircmd := "C:\Program Files\nircmd.exe"
; nircmd := %A_ScriptDir%\..\nircmd.exe

; Путь к исполняемому файлу mpg123.exe (консольной программы для выигрывания звука)
sound_player_command := "C:\Program Files\mpg123.exe"
; sound_player_command := %A_ScriptDir%\..\mpg123.exe


; ============= ВРЕМЕННЫЕ ЗАДЕРЖКИ (в миллисекундах) ==========

; Время на создание браузером новой вкладки
tab_creation_delay := 200

; Время ожидания звгрузки страницы
page_load_wait_time := 30000

; Время ожидания активации режима чтения
reader_mode_wait_time := 6000
