React = require 'react'

child = require './child'


{h1, h2, div} = React.DOM

App = React.createClass
  render: ->
    div {},
      h1 {}, "Foo"
      h2 {}, "Bar"
      child()

React.renderComponent App(), document.getElementById('app')
