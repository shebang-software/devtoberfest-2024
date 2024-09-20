using { beershop_admin as external } from '../srv/external/beershop-admin';

@path: '/devtoberfest'
service DevtoberService {
  entity Beers as projection on external.Beers;
}