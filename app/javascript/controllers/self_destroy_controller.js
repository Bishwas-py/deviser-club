import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="self-destroy"
export default class extends Controller {
    connect() {

    }

    initialize() {
        this.element.addEventListener('click', () => {
            this.element.outerHTML = "";
        });
    }
}
