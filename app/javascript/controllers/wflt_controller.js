// Write for lord text editor: controller

import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="wflt"
export default class extends Controller {
    static targets = ["textArea", "contentSection", "bold", "italic"];

    performAction(command) {
        document.execCommand(command, false, null);
        this.contentSectionTarget.focus();
    }

    connect() {
        this.textAreaTarget.style.displayName = "none"
        this.contentSectionTarget.addEventListener("click", ()=> {
            this.contentSectionTarget.style.height = "131px"
        });
        this.contentSectionTarget.addEventListener("input", ()=> {
            if (event.key === 'Enter') {
                document.execCommand('defaultParagraphSeparator', false, 'p');

                event.preventDefault()
            }
            this.textAreaTarget.value = this.contentSectionTarget.innerHTML;
        });
        this.boldTarget.addEventListener("click", (event)=>{
            event.preventDefault();
            event.stopPropagation();
            this.performAction("bold")
        })
        this.italicTarget.addEventListener("click", (event)=>{
            event.preventDefault();
            event.stopPropagation();
            this.performAction('italic');
        })
    }
    initialize() {
            console.log('hey111')

    }

}