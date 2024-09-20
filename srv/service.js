const cds = require("@sap/cds");
const fixExtension = require("./utils/extension");
const beerUtil = require("./utils/beers");

module.exports = class DevtoberService extends cds.ApplicationService {
  async init() {
    const beers = await cds.connect.to("beershop_admin");

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

    /**
     * Handles the "READ" event for the "Beers" entity.
     *
     * @param {Object} req - The request object.
     * @param {Object} req.query - The query object from the request.
     * @returns {Promise<Object>} The result of executing the query.
     */
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

      // !!!! Now add your virtual fields and custom extension data !!!!
      const beerIds = data.map((beer) => beer.ID);
      let beerExtensions = await SELECT.from("devtoberfest.BeerExtensions")
        .columns((beer) => {
          beer`.*`;
        })
        .where({ ID: { in: beerIds } });

      data.map(async (d) => {
        const beerExtension = beerExtensions.find((e) => e.ID === d.ID);
        if (beerExtension) {
          d.strength = await beerUtil.determineStrength(d.abv);
          d.style = beerExtension.style;
          d.about = beerExtension.about;
        }
        return d;
      });

      return data;
    });

    /**
     * Handles all incoming requests for any event and any entity.
     * (This has to be last!!!)
     *
     * @param {string} event - The event name.
     * @param {string} entity - The entity name.
     * @param {Function} handler - The handler function to process the request.
     * @param {Object} handler.req - The request object.
     * @param {Object} handler.req.query - The query object from the request.
     * @returns {Promise<Object>} The result of executing the query.
     */
    this.on("*", "*", async (req) => {
      return beers.run(req.query);
    });
  }
};
