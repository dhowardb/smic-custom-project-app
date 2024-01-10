@EndUserText.label: 'Projection view  for S4 Charms'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: ['CharmNumber']
define view entity ZC_DEMO_CHARM as projection on ZI_DEMO_CHARM
{
    key CharmUuid,
    ProjectUuid,
    CharmNumber,
    TransportRequest,
    Description,
    DateCreated,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LocalLastChangedAt,
    /* Associations */
    
    _TransportRequests : redirected to composition child ZC_DEMO_TRANSPORT_REQUESTS,
    _Projects : redirected to parent ZC_DEMO_S4_PROJECT_INTERFACE
}
