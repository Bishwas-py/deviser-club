import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="dark-mode"
export default class extends Controller {
    initialize() {
        if (localStorage.theme === 'dark' || (!('theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
            document.documentElement.classList.add('dark')
        } else {
            document.documentElement.classList.remove('dark')
        }
    }

    connect() {
        this.element.addEventListener('click', this.toggleDark.bind(this))
    }

    toggleDark(event) {
        document.documentElement.classList.toggle('dark')
        if (document.documentElement.classList.contains('dark')) {
            localStorage.setItem('theme', 'dark')
        } else {
            localStorage.removeItem('theme')
        }
    }
}
