/**
 * Determines the strength of the beer based on its ABV (Alcohol by Volume).
 *
 * @param {number} abv - The alcohol by volume percentage of the beer.
 * @returns {Promise<string>} A promise that resolves to the strength category of the beer.
 *                            Possible values are:
 *                            - "non_alcoholic" for ABV between 0.0% and 0.5%
 *                            - "zero" for ABV between 0.5% and 2.7%
 *                            - "low" for ABV between 2.7% and 3.5%
 *                            - "mid" for ABV between 3.5% and 4.8%
 *                            - "full" for ABV above 4.8%
 */
const determineStrength = async (abv) => {
    if (abv >= 0.0 && abv <= 0.5) {
        return "non_alcoholic";
      } else if (abv > 0.5 && abv <= 2.7) {
        return "zero";
      } else if (abv > 2.7 && abv <= 3.5) {
        return "low";
      } else if (abv > 3.5 && abv <= 4.8) {
        return "mid";
      } else {
        return "full";
      }
};

module.exports = { determineStrength: determineStrength };
