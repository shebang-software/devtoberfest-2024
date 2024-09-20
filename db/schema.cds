using { beershop_admin as external } from '../srv/external/beershop-admin';

namespace devtoberfest;

/**
 * Extensions for the warranty claims. It is important to use an aspect for this purpose.
 * The aspect will be reused later to read added fields vs original fields so we don't have to
 * change the code in multiple places.
 */
aspect ExtensionAspect {
  virtual VirtualField         : Boolean;
  PersistedField                  : String;
}

extend external.Beers with ExtensionAspect;

entity CustomerExtensions : ExtensionAspect {
  key ID : String;
}
