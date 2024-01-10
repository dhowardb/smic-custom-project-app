@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface view for IT Groups'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define root view entity ZI_DEMO_ITGROUP
  as select from zdt_demo_itgroup
{
  key itgroup_uuid          as ItgroupUuid,
  
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.9
      it_group              as ItGroup,

      @Semantics.user.createdBy: true
      created_by            as CreatedBy,

      @Semantics.systemDateTime.createdAt: true
      created_at            as CreatedAt,

      @Semantics.user.lastChangedBy: true
      last_changed_by       as LastChangedBy,

      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt
}
