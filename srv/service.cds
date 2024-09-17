using { metadata as external } from '../srv/external/metadata';

@path: '/devtoberfest'
service DevtoberService {
  entity Customers as projection on external.Customers;
}