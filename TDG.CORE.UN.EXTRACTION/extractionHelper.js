/**
 * File contains any complicated extraction logic to help pull out required data
 * Separate functions should be created for each targeted data required to capture.
 *
 */
const _ = require('lodash')

/**
 *value of Shipping Name can be in various properties depending on how data is displayed in html table
 *
 * @returns
 */
function extractShippingName (item) {
  if (typeof item === 'string') {
    // happy path scenario value is right there for the pickings.
    return item
  } else if (item.Provision) {
    // scenario where shipping contains new lines, example: UN0339
    const items = _.flattenDeep(item.Provision.map((x) => x.Text))
    const shippingNames = []

    for (let index = 0; index < items.length; index++) {
      if (typeof items[index] === 'string') {
        shippingNames.push(items[index])
      } else {
        const tempName = []
        if (items[index].Emphasis) {
          const emphasisString = items[index].Emphasis[0]._
          tempName.push(emphasisString)
        }
        // some shipping names values are within the _ property depending on how the html as been structured i.e surrounded by additional tags.
        const shippingNameString = items[index]._
        tempName.push(shippingNameString)
        shippingNames.push(tempName.join(''))
      }
    }
    return shippingNames.join('\n')
  } else if (item._) {
    const shippingNames = []
    const tempName = []
    if (item.Emphasis) {
      const emphasisString = item.Emphasis[0]._
      tempName.push(emphasisString)
    }
    // some shipping names values are within the _ property depending on how the html as been structured i.e surrounded by additional tags.
    const shippingNameString = item._
    tempName.push(shippingNameString)
    shippingNames.push(tempName.join(''))
    return shippingNames.join('\n')
  }
}

/**
 *value of Class can be in various properties depending on how data is displayed in html table
 *
 * @returns
 */
function extractClassData (item) {
  if (typeof item === 'string') {
    // happy path scenario value is right there for the pickings.
    return [item]
  } else if (item._) {
    // scenario where columns contains multiple newlines, example: UN482
    return [item._]
  } else if (item.Provision) {
    // scenario where columns contains multiple classes, primary and secondary
    return _.flattenDeep(item.Provision.map((x) => x.Text))
  }
}

exports.extractShippingName = extractShippingName
exports.extractClassData = extractClassData
