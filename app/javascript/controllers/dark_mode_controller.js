import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="dark-mode"
export default class extends Controller {
    initialize() {
    }

    connect() {
        this.element.addEventListener('click', this.toggleDark.bind(this))
    }

    toggleDark(event) {
        document.documentElement.classList.toggle('dark')
    }
}
