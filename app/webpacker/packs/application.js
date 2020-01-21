import "../stylesheets/application"

const images = require.context('../images', true)
const imagePath = (name) => images(name, true)

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")
require("bootstrap/dist/js/bootstrap")
require("game_form")
require("cocoon")
require("trix")
require("@rails/actiontext")
