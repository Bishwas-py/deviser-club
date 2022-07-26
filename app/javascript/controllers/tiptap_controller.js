import {Controller} from "@hotwired/stimulus"

import {Editor} from '@tiptap/core';
import StarterKit from '@tiptap/starter-kit';
import Link from "@tiptap/extension-link";

import Code from "@tiptap/extension-code";
import CodeBlock from "@tiptap/extension-code-block";

let textHandlers = ['bold', 'italic', 'code', 'codeBlock']

// Connects to data-controller="tiptap"
export default class extends Controller {
    static targets = ['content', 'headingmarker', 'heading', 'textbox', 'audioplayer', ...textHandlers]

    connect() {
        this.textboxTarget.hidden = true;
        this.editor = new Editor({
            element: this.contentTarget,
            extensions: [
                StarterKit,
                Link.configure({
                    protocols: ['https://', 'mailto'],
                }),
                Code.configure({}),
                CodeBlock.configure({
                    languageClassPrefix: 'language-',
                    exitOnTripleEnter: true,
                })
            ],
            onUpdate: ({ editor }) => {
                const html = editor.getHTML();
                this.textboxTarget.value = html;
                console.log(this.textboxTarget.value);
            },
            content: this.textboxTarget.value,
            origcontent: `Just Gold Old Text wandering around!`,
        })

    }

    initialize() {
        let oldEditor = document.querySelector('.ProseMirror');
        if (oldEditor){
            oldEditor.outerHTML = '';
        }
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

    codeBlockText() {
        this.editor.chain().focus().toggleCodeBlock().run()
    }

    codeText() {
        this.editor.chain().focus().toggleCode().run()
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

}