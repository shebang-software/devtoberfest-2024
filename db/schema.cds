using { metadata as external } from '../srv/external/metadata';

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

extend external.Customers with ExtensionAspect;

entity CustomerExtensions : ExtensionAspect {
  key CustomerID : String;
}
