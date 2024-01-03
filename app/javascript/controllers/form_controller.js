import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="form"
export default class extends Controller {
    static targets = ['form']

    connect() {

        if (this.hasFormTarget) {

            [...document.getElementsByClassName('field_with_errors')]
                .forEach(element => {
                    let input = element.querySelector('input');
                    let text_area = element.querySelector('textarea')
                    if (input)
                        input.classList.add('is-invalid');
                    if (text_area)
                        text_area.classList.add('is-invalid')
                })

        }
    }

    reset(){
        [...document.getElementsByClassName('is-invalid')]
            .forEach(e => {
                e.classList.remove('is-invalid');
            })
        document.querySelectorAll(".form-error").forEach(el => el.remove());
        this.element.reset()
    }
}
