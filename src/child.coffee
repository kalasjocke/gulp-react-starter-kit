React = require 'react'


{p} = React.DOM

module.exports = React.createClass
  render: ->
    p {}, "Child"
