/**
 * A Space for generic utilities
 *
 */

const fastcsv = require('fast-csv')
const fs = require('fs')

function createOptionSetFile (items, filePath) {
  try {
    const rows = []
    items.forEach((x) => {
      rows.push({ name: x })
    })

    const writeStream = fs.createWriteStream(`${filePath}.csv`)
    fastcsv.write(rows, { headers: true }).pipe(writeStream)
    console.log(`file created: ${filePath}`)
  } catch (error) {
    console.log(`file not created: ${filePath}`)
  }
}

function createFile (items, filePath) {
  try {
    const writeStream = fs.createWriteStream(`${filePath}.csv`)
    fastcsv.write(items, { headers: true }).pipe(writeStream)
    console.log(`file created: ${filePath}`)
  } catch (error) {
    console.log(`file not created: ${filePath}`)
  }
}
exports.createOptionSetFile = createOptionSetFile
exports.createFile = createFile
