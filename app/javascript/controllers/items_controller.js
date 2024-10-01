import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  constructor() {
    super()
    this.item_ids = []
    // id => {name: '', prices: []}
    this.item_data = new Object()
  }

  static targets = []

  // listen to onchange event on the multiselect to update the chart
  connect() {
    var select = document.getElementById('form_item_ids')

    // Create a MutationObserver to listen for changes to the select element
    const observer = new MutationObserver(async (mutationsList, observer) => {
      for (let mutation of mutationsList) {
        if (mutation.type === 'childList') {
          await this.update_local_data(select.values)
          this.update_chart()
          break;  // for some reason executed multple times
        }
      }
    });
    observer.observe(select, { childList: true });
  }

  // Update instance data and query additional data if needed
  async update_local_data(new_ids) {
    const new_item = new_ids > this.item_ids
    this.item_ids = new_ids

    if (new_item) {
      // this works since newly added item is always the last one
      var id = new_ids[new_ids.length - 1]
      // check first if prices are not saved already
      if (!(id in this.item_data)) {
        // query the api and save the result
        const response = await fetch('/items/' + id);
        const data = await response.json();
        this.item_data[id] = { 'prices': data['prices'], 'name': data['name'] }
      }
    }
  }

  // Update lines based on local data
  update_chart() {
    // first step is to gather all dates of the prices, to mark them as labels
    const data = Object.values(this.item_data)
    const dates = data.map(o => o.prices).flat().map(o => o.date).sort().filter((v, i, a) => a.indexOf(v) === i);
    chart.data.labels = dates

    // Clean the chart
    chart.data.datasets = []

    // then, for each selected item, build the price array
    this.item_ids.forEach(id => {
      var prices = dates.map(date => {
        var price = this.item_data[id].prices.find(o => o.date === date)
        return price === undefined ? null : price.value
      })
      this.addData(id, this.item_data[id].name, prices)
    })

    // finally trigger redraw
    chart.update();
  }

  // add one line to the grph dataset
  addData(id, label, prices) {
    chart.data.datasets.push({
      data: prices,
      label: label,
      id: id,
      spanGaps: true
    });
  }

  // unused for now
  // removeData(id) {
  //   var index = 0;
  //   for (let dataset of chart.data.datasets) {
  //     if (dataset.id === id) {
  //       break;
  //     }
  //     index += 1;
  //   }
  //   chart.data.datasets.splice(index, 1);
  // }
}
