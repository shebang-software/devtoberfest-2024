module.exports = (originalQuery, excludeFields, validFields) => {
  let query = JSON.parse(JSON.stringify(originalQuery));

  // Function to remove excluded fields from the query
  // This function is recursive and will remove any object properties that are in the excludeFields list.
  // It might be a bit overkill but the query object can be quite complex and nested (although at this point
  // we're only removing fields from the main entity set, not from any associations or sub-entities)
  const removeExcludedFields = (obj) => {
    if (Array.isArray(obj)) {
      return obj.map(removeExcludedFields).filter(Boolean);
    }
    if (typeof obj === "object" && obj !== null) {
      Object.keys(obj).forEach((key) => {
        if (key === "ref" && Array.isArray(obj[key])) {
          const fieldName = obj[key][obj[key].length - 1];
          if (excludeFields.includes(fieldName)) {
            delete obj[key];
          }
        } else {
          obj[key] = removeExcludedFields(obj[key]);
        }
      });
      return Object.keys(obj).length ? obj : null;
    }
    return obj;
  };

  const handleSelect = (query, validFields) => {
    // Apply the filtering to the entire query structure
    query = removeExcludedFields(query);

    // If no columns are explicitly requested or if all requested columns were excluded
    if (
      !query.SELECT ||
      !query.SELECT.columns ||
      query.SELECT.columns.length === 0
    ) {
      query.SELECT = query.SELECT || {};
      query.SELECT.columns = validFields.map((field) => ({ ref: [field] }));
    }

    //If part of the select is a *, IE if all columns are requested, we need to manually insert all *relevant*
    //columns. Otherwise it's going to still expand the $select to include the new fields.
    if (
      query?.SELECT?.columns.length > 0 &&
      query?.SELECT?.columns[0] === "*"
    ) {
      query.SELECT.columns.splice(
        0,
        1,
        ...validFields.map((field) => ({ ref: [field] }))
      );
    }
  };

  // Handle different types of queries
  if (query.hasOwnProperty("SELECT")) {
    handleSelect(query, validFields);
  } else if (query.hasOwnProperty("INSERT")) {
    // Remove excluded fields from the INSERT query
    query.INSERT.entries = query.INSERT.entries.map((entry) => {
      Object.keys(entry).forEach(async (key) => {
        if (excludeFields.includes(key)) {
          delete entry[key];
        }
      });
      return entry;
    });
  } else if (query.hasOwnProperty("UPDATE")) {
    // Remove excluded fields from the UPDATE query
	let data = query.UPDATE.data;
    query.UPDATE.data = Object.keys((query.UPDATE.data)).forEach(async (key) => {
      if (excludeFields.includes(key)) {
        delete data[key];
      }
    });
	query.UPDATE.data = data;
  } else {
    // Handle other types of queries or throw an error
    throw new Error("Unsupported query type");
  }

  return query;
};
