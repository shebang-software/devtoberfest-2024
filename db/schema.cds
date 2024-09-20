using {beershop_admin as external} from '../srv/external/beershop-admin';

namespace devtoberfest;


type Strength : String enum {
  non_alcoholic = 'non-alcoholic';
  zero           = '0%';
  low;
  mid;
  full;
}

/**
 * Extensions for the Beers Service. It is important to use an aspect for this purpose.
 * The aspect will be reused later to read added fields vs original fields so we don't have to
 * change the code in multiple places.
 */
aspect ExtensionAspect {
  virtual strength : Strength;
  style            : String;
  about            : String;
}

extend external.Beers with ExtensionAspect;

entity BeerExtensions : ExtensionAspect {
  key ID : String;
}
