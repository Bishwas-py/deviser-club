import {Controller} from "@hotwired/stimulus"

import {Editor} from '@tiptap/core';
import StarterKit from '@tiptap/starter-kit';
import Link from "@tiptap/extension-link";

import Code from "@tiptap/extension-code";
import Placeholder from "@tiptap/extension-placeholder";
import CodeBlock from "@tiptap/extension-code-block";
import Dropcursor from "@tiptap/extension-dropcursor";

import Image from '@tiptap/extension-image'

let textHandlers = ['bold', 'italic', 'code', 'codeBlock']

// Connects to data-controller="tiptap"
export default class extends Controller {
    static targets = ['content', 'headingmarker', 'heading', 'textbox', 'audioplayer', 'placeholder', ...textHandlers]

    connect() {
        this.textboxTarget.hidden = true;
        this.editor = new Editor({
            element: this.contentTarget,
            extensions: [
                StarterKit,
                Link.configure({
                    protocols: ['https://', 'mailto'],
                }),
                Image.configure({
                    inline: true,
                }),
                Code.configure({}),
                CodeBlock.configure({
                    languageClassPrefix: 'language-',
                    exitOnTripleEnter: true,
                }),
                Placeholder.configure({
                    placeholder: this.data.get("placeholder"),
                    emptyNodeClass: 'tiptap-placeholder',
                }),
                Dropcursor.configure({
                    color: 'green',
                    width: 5,
                })
            ],
            onUpdate: ({editor}) => {
                this.textboxTarget.value = editor.getHTML();
                if (this.textboxTarget.getAttribute('is_draft') === 'true') {
                    this.textboxTarget.form.requestSubmit();
                }
            },
            content: this.textboxTarget.value,
            origcontent: `Just Gold Old Text wandering around!`,
        })
        // console.log(this.editor.view.dom);
        // this.editor.view.dom.addEventListener('dragenter', ()=> {console.log('drag')})
        // this.editor.view.dom.addEventListener("input", function() {
        //     console.log("input event fired");
        // }, false);

        ;['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
            this.editor.view.dom.addEventListener(eventName, (e)=>{
                e.preventDefault()
                e.stopPropagation()
                console.log("hey");
            }, false)
        })

    }

    initialize() {
        let oldEditor = document.querySelector('.ProseMirror');
        if (oldEditor) {
            oldEditor.outerHTML = '';
        }
        ['click', 'input', 'keydown', 'keypress', 'change'].forEach(evt => {
                this.element.addEventListener(evt, () => {
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
                normalButton.style.backgroundColor = "rgb(1,2,2,0.9)";
                normalButton.style.border = "1px solid rgb(128, 0, 255, 0.5)";
                normalButton.style.color = "white";
            } else {
                normalButton.style.color = null;
                normalButton.style.backgroundColor = null;
                normalButton.style.border = null;
            }
        })
        let numberOfInActiveHeadings = 0;

        let headerButton = eval(this.headingmarkerTarget);
        for (let i of Array(6).keys()) {
            let headingName = `h${i + 1}`;
            if (!this.editor.isActive('heading', {level: i + 1})) {
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
            headerButton.classList.remove('ring-slate/50')
        } else {
            headerButton.classList.add('ring-1')
            headerButton.style.backgroundColor = "rgb(1,2,2,0.7)";

            headerButton.classList.add('ring-slate/50 dark:text-slate-300')
        }
    }

}