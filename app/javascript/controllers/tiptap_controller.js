import {Controller} from "@hotwired/stimulus"

import {Editor} from '@tiptap/core'
import StarterKit from '@tiptap/starter-kit'


let textHandlers = ['bold', 'italic']

// Connects to data-controller="tiptap"
export default class extends Controller {
    static targets = ['content', 'headingmarker', 'heading', ...textHandlers]

    connect() {
        this.editor = new Editor({
            element: this.contentTarget,
            extensions: [
                StarterKit,
            ],
            content: `
            <p>Yes, this is a document.</p>
        <p>with <strong>bold</strong> and <em>italic</em> text.</p>
        <p>😬</p>
        <h2>Header 2</h2>
        <p><a href="https://google.com">https://google.com</a></p>
        <ul>
          <li>
            <p>Hello World!<br />Yes, you!</p>
          </li>
        </ul>
        <h3>Header 3</h3>
        <ol>
          <li>
            <p>item 1<br />line 2</p>
          </li>
          <li><p>item 2</p></li>
        </ol>
        <p>Great work</p>
        <blockquote>I really said this.<br />Important stuff.</blockquote>
        <div>
          <img src="https://images.unsplash.com/photo-1449034446853-66c86144b0ad?ixlib=rb-1.2.1&q=85&fm=jpg&crop=entropy&cs=srgb" />
        </div>
        <p>Good right?</p>
            `,
        })
    }

    initialize() {
        ['click','input', 'keydown', 'keypress', 'change'].forEach( evt =>
            {
                this.element.addEventListener(evt, ()=> {
                    {
                        this.checkActive()
                    }
                })
            }
        );
    }

    boldText() {
        this.editor.chain().focus().toggleBold().run()
    }

    italicText() {
        this.editor.chain().focus().toggleItalic().run()
    }

    setHeading(event) {
        let level = event.target.dataset.headingLevel;
        this.editor.chain().focus().toggleHeading({level: parseInt(level)}).run()
    }

    checkActive(event) {
        textHandlers.forEach(h => {
            let normalButton = eval(`this.${h}Target`);
            if (this.editor.isActive(h)) {
                normalButton.style.backgroundColor = "transparent";
                normalButton.style.border = "1px solid white";
            } else {
                normalButton.style.backgroundColor = null;
                normalButton.style.border = null;
            }
        })
        let numberOfInActiveHeadings = 0;
        let headerButton = eval(this.headingmarkerTarget);
        for (let i of Array(6).keys()) {
            let headingName = `h${i+1}`;
            if (!this.editor.isActive('heading', { level: i+1 })){
                numberOfInActiveHeadings += 1;
                let headingElement = this.headingTarget.querySelector(`#${headingName}`);
                headingElement.style.backgroundColor = null;
            } else {
                let headingElement = this.headingTarget.querySelector(`#${headingName}`);
                headingElement.style.backgroundColor = "purple";
            }
        }
        if (numberOfInActiveHeadings === 6) {
            headerButton.style.backgroundColor = null;
            headerButton.classList.remove('ring-1')
            headerButton.classList.remove('ring-white/50')
        } else {
            headerButton.classList.add('ring-1')
            headerButton.style.backgroundColor = "transparent";
            headerButton.classList.add('ring-white/50')
        }
    }

    // makeText(event) {
    //     let functionName = event.target.dataset.command;
    //     if (functionName) {
    //         eval("this.editor.chain().focus()." + functionName + ".run()");
    //     }
    // }
}