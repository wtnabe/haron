# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
###*
* とりあえずキーボードから指が離れて500ms待つ
###
class HaronListener


###*
* APIにsourceを投げる
* 結果が200だったらconvertedのDOMを書き換え、cacheする
* それ以外だったらstatus lineに失敗のメッセージを出し、convertedは触らない
###
class HaronClient

###*
* とりあえず直前の成功したconvert結果を押さえておく(status: success)
*
###
class HaronCache
