# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
###*
* とりあえずキーボードから指が離れて500ms待つ
###
class HaronListener
  timeout_id: undefined

  start: ->
    area = $('textarea#snippet_source')
    self = this
    area.on 'keyup', (e) ->
      self.timeout_id = setTimeout ->
        (new HaronClient()).put()
      , 500
    area.on 'keydown', ->
      self = this
      clearTimeout self.timeout_id

window.HaronListener = HaronListener

###*
* APIにsourceを投げる
* 結果が{status: 'success'}だったらconvertedのDOMを書き換え、cacheする
* それ以外だったらstatus lineに失敗のメッセージを出し、convertedは触らない
###
class HaronClient
  put: ->
    self = this
    $.post location.pathname + '.json', @put_param(), (snippet) ->
      if snippet.status == 'success'
        self.update_html(snippet.converted)

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
  if $('#html-source').length > 0
    (new HaronListener()).start()
