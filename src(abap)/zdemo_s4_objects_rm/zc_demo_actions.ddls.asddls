@EndUserText.label: 'Projection view for demo actions lists'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZC_DEMO_ACTIONS as projection on ZI_DEMO_ACTIONS
{
    key ActionItemUuid,
    key ProjectUuid,
    ActionItem,
    Description,
    DateOfAction,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LocalLastChangedAt,
    /* Associations */
    _Projects : redirected to parent ZC_DEMO_S4_PROJECT_INTERFACE
}
