@EndUserText.label: 'Projection view demo Transport requests'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZC_DEMO_TRANSPORT_REQUESTS as projection on ZI_DEMO_TRANSPORT_REQUESTS
{
    key TransportRequestUuid,
    CharmUuid,
    ProjectUuid,
    @Consumption: { valueHelpDefinition: [{ entity: { name: 'ZI_DEMO_TR_WITH_OBJECTS', element: 'TransportRequest' } }] }
    TransportRequest,
    Description,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LocalLastChangedAt,
    /* Associations */
    _Charms : redirected to parent ZC_DEMO_CHARM,
    _Projects : redirected to ZC_DEMO_S4_PROJECT_INTERFACE
}
