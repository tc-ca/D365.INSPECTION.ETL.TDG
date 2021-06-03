
function addRowsToFileExport (
  entityName,
  attribute,
  globalName,
  items
) {
  const rows = []
  items.forEach((x, i) => {
    // eslint-disable-next-line quote-props
    rows.push({
      Entity: entityName,
      Attribute: attribute,
      'Global Name': globalName,
      Value: i,
      'Label-English': x,
      'Label-French': x,
      'Description-English': x,
      'Description-French': x
    })
  })

  return rows
}

exports.addRowsForFileExport = addRowsToFileExport
