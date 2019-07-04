; ============= ГЛАВНЫЕ НАСТРОЙКИ ==========

; Картинка, по которой определяется, что страница загружена
firefox_page_is_loaded_image := "firefox-page-load-complete.bmp"

; Область поиска этой картинки
firefox_page_is_loaded_x1 := 70
firefox_page_is_loaded_y1 := 60
firefox_page_is_loaded_x2 := 100
firefox_page_is_loaded_y2 := 90

; Картинка, по которой определяется режим чтения
reader_mode_image_pattern := "reader-mode-letter-default-home.bmp"

; Область поиска этой картинки
reader_mode_serch_area_x1 := 0
reader_mode_serch_area_y1 := 162
reader_mode_serch_area_x2 := 38
reader_mode_serch_area_y2 := 200

; Координаты кнопки перехода в режим чтения Firefox
reader_mode_enable_button_x := 150
reader_mode_enable_button_y := 73


; ============= ВСПОМОГАТЕЛЬНЫЕ ПРОГРАММЫ ==========

; Путь к исполняемому файлу NVDA
nvda_cmd := "C:\Program Files (x86)\NVDA\nvda.exe"

; Путь к исполняемому файлу веб-сервера (рекомендуется HTTP File Server от Rejetto)
web_server_command := "C:\Program Files (x86)\hfs.exe"

; Путь к исполняемому файлу утилиты NirCMD
nircmd := "c:\Program Files\nircmd.exe"

; Путь к исполняемому файлу mpg123.exe (консольной программы для выигрывания звука)
sound_player_command := "C:\Program Files\mpg123-1.25.10-static-x86-64\mpg123.exe"


; ============= ВРЕМЕННЫЕ ЗАДЕРЖКИ (в миллисекундах) ==========

; Время на создание браузером новой вкладки
tab_creation_delay := 200

; Время ожидания звгрузки страницы
page_load_wait_time := 10000

; Время ожидания активации режима чтения
reader_mode_wait_time := 6000
