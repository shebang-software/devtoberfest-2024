module.exports = async (cds, data) => {
	// create an array if it's not an array. This function like the handler works on
	// single entities and entity sets
	const d = data instanceof Array ? data : [data];

	// create a key value pair of the claim number and the claim object
	// const keys = d.reduce((acc, curr) => {
	// 	acc[curr.ClaimNo] = curr;
	// 	return acc;
	// }, {});

	// //select the added fields from the extension aspect
	// const addedFields = await SELECT.from('encollab.pp.WarrantyClaimExtensions').where({ ClaimNo: Object.keys(keys) });

	// //map the added fields to the original data
	// const mapped = d.map((d) => ({
	// 	...d,
	// 	...addedFields.find((c) => c.ClaimNo === d.ClaimNo),
	// 	IsClaimItemsEditable: true
	// }));

	//return the either the original array or the original object
	return data instanceof Array ? mapped : mapped[0];
};
