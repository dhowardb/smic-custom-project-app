@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help Definition for IT Group'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZCVH_DEMO_ITGROUP
  as select from ZI_DEMO_ITGROUP
{
      @UI.hidden: true
  key ItgroupUuid,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.9
      @EndUserText.label: 'IT Group'
      ItGroup,

      @Semantics.user.createdBy: true
      @EndUserText.label: 'Created By'
      CreatedBy,

      @Semantics.systemDateTime.createdAt: true
      @EndUserText.label: 'Created At'
      CreatedAt,

      @Semantics.user.lastChangedBy: true
      @EndUserText.label: 'Last Changed By'
      LastChangedBy,

      @Semantics.systemDateTime.lastChangedAt: true
      @EndUserText.label: 'Last Changed At'
      LastChangedAt,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      @EndUserText.label: 'Local Last Changed At'
      LocalLastChangedAt
}
