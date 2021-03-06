
is_search_start_mode() {
	return testClipboardWithRegex("^https://ya.ru/?$")
}

is_text_search_results_mode() {
	return testClipboardWithRegex("^https://yandex\.ru/search/\?")
}

is_mail_list_mode() {
	return testClipboardWithRegex("^https://mail\.yandex\.ru/lite/?$")
}

is_mail_message_mode(){
	; https://mail.yandex.ru/lite/message/170010885933238302
	; https://mail.yandex.ru/lite/message/170010885933238302/new
	return testClipboardWithRegex("^https://mail\.yandex\.ru/lite/message/\d+")
}

is_yandex_video_mode() {
	return testClipboardWithRegex("^https://yandex\.ru/video/search\?")
}

yandexVideoPlayPause() {
	Click, 724, 594
}