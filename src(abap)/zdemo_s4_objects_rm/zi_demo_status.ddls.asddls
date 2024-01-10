@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View for Demo status'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZI_DEMO_STATUS
  as select from zdt_demo_status
{
  @ObjectModel.text.element: ['Description']
  @EndUserText.label: 'Status'
  key cast( status as abap.char( 2 ) ) as Status,
  @EndUserText.label: 'Description'
      description                      as Description
}
