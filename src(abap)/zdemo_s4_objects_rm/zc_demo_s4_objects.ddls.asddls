@EndUserText.label: 'Projection View for S4 Objects'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.semanticKey: ['ObjectName']
@Metadata.allowExtensions: true
define view entity ZC_DEMO_S4_OBJECTS
  as projection on ZI_DEMO_S4_OBJECTS

{
  key ObjectUUID,
      ProjectUUID,
      ProjectName,
      ObjectName,
      ObjectLineItem,
      ObjectType,
      TransportRequest,
      ObjectPackage,
      ObjectOwner,
      ObjectOwnerLastChangedAt,
      CreatedBy,
      CreatedAt,
      LocalLastChangedAt,
      /* Associations */
      _Projects : redirected to parent ZC_DEMO_S4_PROJECT_INTERFACE
}
