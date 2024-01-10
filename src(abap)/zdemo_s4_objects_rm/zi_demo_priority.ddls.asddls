@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface view for Demo Priority'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZI_DEMO_PRIORITY
  as select from zdt_demo_prio
{
      @EndUserText.label: 'Priority'
      @ObjectModel.text.element: ['Description']
      @UI.textArrangement: #TEXT_LAST
  key value            as Value,
      @EndUserText.label: 'Description'
      description      as Description,
      @UI.hidden: true
      criticality      as Criticality,
      @UI.hidden: true
      criticality_desc as CriticalityDesc
}
