import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="quick-tweet"
export default class extends Controller {
  connect() {
  }
  initialize() {
    console.log("hey")
  }
  addTweet(event) {
    event.preventDefault()
    event.stopPropagation()

    const tweet_section_id = event.params.body;
    const tweetSection = document.getElementById(tweet_section_id);
    tweetSection.scrollIntoView({
      behavior: 'smooth'
    });

    const form_id = event.params.id;
    const tweetTextBox = document.querySelector(`#${form_id} textarea`);
    // tweetTextBox

    setTimeout(function() {
      tweetTextBox.focus();
    }, 500);
  }
}
