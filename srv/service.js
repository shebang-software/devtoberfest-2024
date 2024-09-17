const cds = require('@sap/cds');
const fixExtension = require('./utils/extension');
// const augmentEntity = require('./utils/warranty');
// const { getCompleteSettings } = require('./utils/config');

const bla = (l) => console.log(JSON.stringify(l, null, 2));

module.exports = class DevtoberService extends cds.ApplicationService {
	async init() {
		const northwinds = await cds.connect.to('metadata');
		const entities = cds.entities('devtoberfest');

		// Get the original entity definition from the on-premise service. Because it's been extended, it will contain
		// the added fields from the extension aspect
		const originalEntity = northwinds.model.definitions['metadata.Customers'];
		// Extract the added fields from the extension aspect
		const excludeFields = Object.keys(cds.model.definitions['devtoberfest.ExtensionAspect'].elements);
		// Create a list of valid fields, which is all original fields minus excluded fields.
		const validFields = Object.keys(originalEntity.elements).filter((field) => !excludeFields.includes(field));

		// this.on('READ', 'Customers', async (req) => {
		// 	// Clone the original query and remove the extension fields
		// 	let modifiedQuery = fixExtension(req.query, excludeFields, validFields);

    //   const originalSelect = req.query.SELECT;
		// 	const { from, where, limit, count } = originalSelect;
		// 	const { columns, orderBy } = modifiedQuery.SELECT;

		// 	const qry = SELECT.from(from);

		// 	// single entity vs entityset. Entityset queries have more options.
		// 	if (originalSelect.one) {
		// 		if (columns) qry.columns(columns);
		// 	} else {
		// 		if (where) qry.where(where);
		// 		if (orderBy) qry.orderBy(orderBy);
		// 		if (columns) qry.columns(columns);
		// 		if (count) qry.SELECT.count = true;
		// 		qry.limit(limit || { rows: { val: 10 }, offset: { val: 0 } });
		// 	}

		// 	const data = await northwinds.run(qry);

		// 	return data;
		// });
		// this has to be LAST.
		this.on('*', '*', async (req) => {
			return northwinds.run(req.query);
		});
	}
};
