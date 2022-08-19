# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"


pin "orderedmap", to: "node_modules/orderedmap/dist/index.js"
pin "@tiptap/core", to: "node_modules/@tiptap/core/dist/tiptap-core.esm.js"
pin "@tiptap/starter-kit", to: "node_modules/@tiptap/starter-kit/dist/tiptap-starter-kit.esm.js"
pin "prosemirror-state", to: "node_modules/prosemirror-state/dist/index.js"
pin "prosemirror-view", to: "node_modules/prosemirror-view/dist/index.js"
pin "prosemirror-keymap", to: "node_modules/prosemirror-keymap/dist/index.js"
pin "prosemirror-model", to: "node_modules/prosemirror-model/dist/index.js"
pin "prosemirror-transform", to: "node_modules/prosemirror-transform/dist/index.js"
pin "prosemirror-commands", to: "node_modules/prosemirror-commands/dist/index.js"
pin "prosemirror-schema-list", to: "node_modules/prosemirror-schema-list/dist/index.js"
pin "w3c-keyname", to: "node_modules/w3c-keyname/index.es.js"

pin "@tiptap/extension-blockquote", to: "node_modules/@tiptap/extension-blockquote/dist/tiptap-extension-blockquote.esm.js"
pin "@tiptap/extension-bold", to: "node_modules/@tiptap/extension-bold/dist/tiptap-extension-bold.esm.js"
pin "@tiptap/extension-bullet-list", to: "node_modules/@tiptap/extension-bullet-list/dist/tiptap-extension-bullet-list.esm.js"
pin "@tiptap/extension-code", to: "node_modules/@tiptap/extension-code/dist/tiptap-extension-code.esm.js"
pin "@tiptap/extension-code-block", to: "node_modules/@tiptap/extension-code-block/dist/tiptap-extension-code-block.esm.js"
pin "@tiptap/extension-document", to: "node_modules/@tiptap/extension-document/dist/tiptap-extension-document.esm.js"
pin "@tiptap/extension-dropcursor", to: "node_modules/@tiptap/extension-dropcursor/dist/tiptap-extension-dropcursor.esm.js"
pin "@tiptap/extension-gapcursor", to: "node_modules/@tiptap/extension-gapcursor/dist/tiptap-extension-gapcursor.esm.js"
pin "@tiptap/extension-hard-break", to: "node_modules/@tiptap/extension-hard-break/dist/tiptap-extension-hard-break.esm.js"
pin "@tiptap/extension-heading", to: "node_modules/@tiptap/extension-heading/dist/tiptap-extension-heading.esm.js"
pin "@tiptap/extension-history", to: "node_modules/@tiptap/extension-history/dist/tiptap-extension-history.esm.js"
pin "@tiptap/extension-horizontal-rule", to: "node_modules/@tiptap/extension-horizontal-rule/dist/tiptap-extension-horizontal-rule.esm.js"
pin "@tiptap/extension-italic", to: "node_modules/@tiptap/extension-italic/dist/tiptap-extension-italic.esm.js"
pin "@tiptap/extension-list-item", to: "node_modules/@tiptap/extension-list-item/dist/tiptap-extension-list-item.esm.js"
pin "@tiptap/extension-ordered-list", to: "node_modules/@tiptap/extension-ordered-list/dist/tiptap-extension-ordered-list.esm.js"
pin "@tiptap/extension-paragraph", to: "node_modules/@tiptap/extension-paragraph/dist/tiptap-extension-paragraph.esm.js"
pin "@tiptap/extension-strike", to: "node_modules/@tiptap/extension-strike/dist/tiptap-extension-strike.esm.js"
pin "@tiptap/extension-text", to: "node_modules/@tiptap/extension-text/dist/tiptap-extension-text.esm.js"
pin "@tiptap/extension-link", to: "node_modules/@tiptap/extension-link/dist/tiptap-extension-link.esm.js"
pin "@tiptap/extension-image", to: "node_modules/@tiptap/extension-image/dist/tiptap-extension-image.esm.js"
pin "@tiptap/extension-placeholder", to: "node_modules/@tiptap/extension-placeholder/dist/tiptap-extension-placeholder.esm.js"
pin "linkifyjs", to: "node_modules/linkifyjs/dist/linkify.module.js"
pin "prosemirror-dropcursor", to: "node_modules/prosemirror-dropcursor/dist/index.js"
pin "prosemirror-gapcursor", to: "node_modules/prosemirror-gapcursor/dist/index.js"
pin "prosemirror-history", to: "node_modules/prosemirror-history/dist/index.js"

pin "rope-sequence", to: "node_modules/rope-sequence/dist/index.es.js"
pin "tom-select", to: "tom-select.js"


