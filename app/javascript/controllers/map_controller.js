import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {x: Number, y: Number,  popupText: String}
  connect() {
    if (typeof L === "undefined") {
      console.error("Leaflet (L) is not loaded!");
      return;
    }

    let x = this.xValue
    let y = this.yValue

    if (x == 0 || y == 0) {
      x = 51.505
      y = -0.09
    }

    this.map = L.map('map').setView([x, y], 13);

    L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(this.map);

    L.marker([x, y]).addTo(this.map)
        .bindPopup(this.popupTextValue || "Default text")
        .openPopup();
  }
}
