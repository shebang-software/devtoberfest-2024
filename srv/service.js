const cds = require("@sap/cds");
const fixExtension = require("./utils/extension");
//const augmentEntity = require('./utils/warranty');
 //const { getCompleteSettings } = require('./utils/config');

const bla = (l) => console.log(JSON.stringify(l, null, 2));

module.exports = class DevtoberService extends cds.ApplicationService {
  async init() {
    const beers = await cds.connect.to("beershop_admin");
    const entities = cds.entities("devtoberfest");

    // Get the original entity definition from the on-premise service. Because it's been extended, it will contain
    // the added fields from the extension aspect
    const originalEntity = beers.model.definitions["beershop_admin.Beers"];
    // Extract the added fields from the extension aspect
    const excludeFields = Object.keys(
      cds.model.definitions["devtoberfest.ExtensionAspect"].elements
    );
    // Create a list of valid fields, which is all original fields minus excluded fields.
    const validFields = Object.keys(originalEntity.elements).filter(
      (field) => !excludeFields.includes(field)
    );

    this.on("READ", "Beers", async (req) => {
      // Clone the original query and remove the extension fields
      let modifiedQuery = fixExtension(req.query, excludeFields, validFields);

      const originalSelect = req.query.SELECT;
      const { from, where, limit, count } = originalSelect;
      const { columns, orderBy } = modifiedQuery.SELECT;

      const qry = SELECT.from(from);

      // single entity vs entityset. Entityset queries have more options.
      if (originalSelect.one) {
        if (columns) qry.columns(columns);
      } else {
        if (where) qry.where(where);
        if (orderBy) qry.orderBy(orderBy);
        if (columns) qry.columns(columns);
        if (count) qry.SELECT.count = true;
        qry.limit(limit || { rows: { val: 10 }, offset: { val: 0 } });
      }

      const data = await beers.run(qry);

	  // Now add your virtual fields and custom extension data
      data.map((d) => {
        d.VirtualField = true;
        d.PersistedField = "katan";
        return d;
      });

      return data;
    });
    ///this has to be LAST.
    this.on("*", "*", async (req) => {
      return beers.run(req.query);
    });
  }
};
