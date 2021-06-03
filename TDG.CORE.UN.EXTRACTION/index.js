// data from https://laws-lois.justice.gc.ca/eng/regulations/SOR-2001-286/page-46.html#docCont
const dataEnglish = require('./SOR-2001-286-ENGLISH.json')
const dataFrench = require('./SOR-2001-286-FRENCH.json')

const _ = require('lodash')
const utils = require('./utils')
const optionSetFileHelper = require('./optionSetFileHelper')

const { createFile } = utils
const extractionHelper = require('./extractionHelper')

console.log('application starting execution')

// get targeted data from json
const unTableEnglish =
  dataEnglish.Regulation.Schedule[0].TableGroup[1].table[0].tgroup[0].tbody[0].row.filter(
    (x) => x.entry[0].$ !== undefined
  )

const unTableFrench =
  dataFrench.Regulation.Schedule[0].TableGroup[1].table[0].tgroup[0].tbody[0].row.filter(
    (x) => x.entry[0].$ !== undefined
  )

// const english = []
// unTableEnglish.forEach((row, i) => {
//   const un = row.entry[0]._
//   if (un) {
//     english.push({
//       un: un,
//       name: extractionHelper.extractShippingName(row.entry[1])
//     })
//   }
// })
// createFile(english, 'data/entities/un-numbers-english')

// const englishGroupBy = _.countBy(english, 'un')

// const groupAArray = []
// for (const property in englishGroupBy) {
//   groupAArray.push({ un: `${property}${englishGroupBy[property]}` })
// }

// const french = []
// unTableFrench.forEach((row, i) => {
//   const un = row.entry[0]._
//   if (un) {
//     french.push({
//       un: un,
//       name: extractionHelper.extractShippingName(row.entry[1])
//     })
//   }
// })
// createFile(french, 'data/entities/un-numbers-french')

// const frenchGroupBy = _.countBy(french, 'un')
// const groupBArray = []
// for (const property in frenchGroupBy) {
//   groupBArray.push({ un: `${property}${frenchGroupBy[property]}` })
// }
// const grouptest = _.differenceBy(englishGroupBy, frenchGroupBy, 'un')

// console.log(grouptest)
// const test = _.differenceBy(unTableEnglish, unTableFrench, 'un')
// console.log(test)

const dangerousGood = []
// loop through table and get un numbers
unTableEnglish.forEach((row, i) => {
  const un = row.entry[0]._
  // some rows are undefined as the html table rows are merged on the website for example UN UN2260, can safely ignore
  if (un) {
    const rowFrench = unTableFrench[i]
    // construct object matching dynamics 365 entity/table importation
    const englishShippingName = extractionHelper.extractShippingName(row.entry[1])
    const frenchShippingName = extractionHelper.extractShippingName(rowFrench.entry[1])
    const classes = extractionHelper.extractClassData(row.entry[2])
    const primaryClass = classes[0]
    const secondaryClass = classes.slice(1).join('; ').replace(/[{()}]/g, '')
    const packingGroup = typeof row.entry[3] === 'string' ? row.entry[3] : row.entry[3]._ // value in the "_" property when shipping name contains multiple lines in the html, example UN0482
    const specialProvisions = (typeof row.entry[4] === 'string' ? row.entry[4] : row.entry[4]._ === undefined ? '' : row.entry[4]._).replace(/,/g, ';') // value in the "_" property when shipping name contains multiple lines in the html, example UN0482
    const explosiveLimitQuantityIndex = typeof row.entry[5] === 'string' ? row.entry[5] : row.entry[5]._
    const exceptedQuantities = typeof row.entry[6] === 'string' ? row.entry[6] : row.entry[6]._
    const erapIndex = typeof row.entry[7] === 'string' ? row.entry[7] : row.entry[7]._
    const passengerCarryingVesselIndex = typeof row.entry[8] === 'string' ? row.entry[8] : row.entry[8]._
    const passengerCarryingRoadRailIndex = typeof row.entry[9] === 'string' ? row.entry[9] : row.entry[9]._

    dangerousGood.push({
      // eslint-disable-next-line quote-props
      'UN Number': un, // string
      'Shipping Name and Description': `${englishShippingName}::${frenchShippingName}`, // string
      'English Shipping Name': englishShippingName, // string
      'French Shipping Name': frenchShippingName, // string
      'Primary Class': primaryClass, // option set
      'Secondary Class': secondaryClass, // option set
      'Packing Group': packingGroup, // option set
      'Special Provisions': specialProvisions, // option set
      '6 (a) Explosive Limit and Limited Quantity Index': explosiveLimitQuantityIndex, // string
      '6 (b) Excepted Quantities': exceptedQuantities, // option set
      'ERAP Index': erapIndex, // string
      'Passenger Carrying Vessel Index': passengerCarryingVesselIndex, // string
      'Road or Railway Passenger Carrying Vehicle Index': passengerCarryingRoadRailIndex // string
    })
  } else {
    console.log(JSON.stringify(row))
  }
})

let options = []

const primaryClassOptionSet = _.uniqBy(dangerousGood, 'Primary Class')
  .map(x => x['Primary Class'])
  .filter(x => x !== '')

options = options.concat(
  optionSetFileHelper.addRowsForFileExport(
    'tdg_unnumber',
    'tdg_primaryclasscd',
    'tdg_primaryclass',
    [...new Set(primaryClassOptionSet.sort())]
  )
)

const secondaryClassOptionSet = _.flattenDeep(dangerousGood
  .map(x => x['Secondary Class']))
secondaryClassOptionSet.forEach((x, index) => { secondaryClassOptionSet[index] = x.replace('(', '').replace(')', '') })

options = options.concat(optionSetFileHelper.addRowsForFileExport(
  'tdg_unnumber',
  'tdg_secondaryclasscd',
  'tdg_secondaryclass',
  [...new Set(secondaryClassOptionSet.sort())]
))

const packingGroupOptionSet = _.uniqBy(dangerousGood, 'Packing Group')
  .map(x => x['Packing Group'])
  .filter(x => x !== '')

options = options.concat(
  optionSetFileHelper.addRowsForFileExport(
    'tdg_unnumber',
    'tdg_packinggroupcd',
    'tdg_packinggroup',
    [...new Set(packingGroupOptionSet.sort())]
  )
)

let specialProvisionsOptionSet = []
_.uniqBy(dangerousGood, 'Special Provisions')
  .map(x => x['Special Provisions'])
  .forEach(x => {
    specialProvisionsOptionSet = specialProvisionsOptionSet.concat(
      x.split(' ')
    )
  })

specialProvisionsOptionSet.forEach((x, i) => {
  specialProvisionsOptionSet[i] = x.replace(',', '')
})
options = options.concat(
  optionSetFileHelper.addRowsForFileExport(
    'tdg_unnumber',
    'tdg_specialprovisionscd',
    'tdg_specialprovisions',
    [...new Set(specialProvisionsOptionSet.sort())].filter(x => x !== '')
  )
)

const exceptedQuantitiesOptionSet = _.uniqBy(
  dangerousGood,
  '6 (b) Excepted Quantities'
)
  .map((x) => x['6 (b) Excepted Quantities'])
  .filter((x) => x !== '')

options = options.concat(
  optionSetFileHelper.addRowsForFileExport(
    'tdg_unnumber',
    'tdg_exceptedquantitiestxt',
    'tdg_exceptedquantities',
    [...new Set(exceptedQuantitiesOptionSet.sort())]
  )
)

createFile(options, 'data/option-sets/un-option-sets-import')

createFile(dangerousGood, 'data/entities/un-numbers')

console.log('application finished execution')
