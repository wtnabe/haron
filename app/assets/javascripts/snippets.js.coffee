# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
###*
* とりあえずキーボードから指が離れて500ms待つ
###
class HaronListener


###*
* APIにsourceを投げる
* 結果が{status: 'success'}だったらconvertedのDOMを書き換え、cacheする
* それ以外だったらstatus lineに失敗のメッセージを出し、convertedは触らない
###
class HaronClient
  start: ->
    self = this
    if $('#html-source').length > 0
      setTimeout ->
        self.put()
      , 1000

  put: ->
    self = this
    $.post location.pathname + '.json', @put_param(), (snippet) ->
      if snippet.status == 'success'
        self.update_html(snippet.converted)
    @start()

  put_param: ->
    { '_method': 'put', 'snippet': {'source': @source()} }

  source: ->
    $('textarea#snippet_source').val()

  update_html: (html) ->
    $('#html-source').text(html)

window.HaronClient = HaronClient

###*
* とりあえず直前の成功したconvert結果を押さえておく(status: success)
*
###
class HaronCache

jQuery ->
  (new HaronClient()).start()
