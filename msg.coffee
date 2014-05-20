Config = require './config.coffee'

class MSG extends Config
  instance = null
  port:null
  constructor: ->
    super
    @port = chrome.runtime.connect @EXT_ID 

  @get: () ->
    instance ?= new MSG

  @createPort: () ->


  Local: (message, respond) ->
    (show "== MESSAGE #{ _key } ==>") for _key of message
    chrome.runtime.sendMessage message, respond
  Ext: (message, respond) ->
    (show "== MESSAGE EXTERNAL #{ _key } ==>") for _key of message
    chrome.runtime.sendMessage @EXT_ID, message, respond
  ExtPort: (message) ->
    try
      @port.postMessage message
    catch
      @port = chrome.runtime.connect @EXT_ID 
      @port.postMessage message

module.exports = MSG