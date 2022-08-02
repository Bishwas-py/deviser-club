import {Controller} from "@hotwired/stimulus"
import TomSelect from "tom-select"


export default class extends Controller {

    connect() {
        let selects = JSON.parse(this.data.get("json-selects"));

        let newSelect = [];
        selects.map((dataField, index)=> {
            newSelect.push(
                {
                    value: dataField.name,
                    text: dataField.name
                }
            )
        })


        var settings = {
            options: newSelect,
            plugins: {
                remove_button:{
                    title:'Remove this item',
                }
            },
            create: true
        };
        new TomSelect(this.element, settings);
    }

    disconnect() {
        // if (this.select) {
        //     this.select.destroy()
        // }
    }

}