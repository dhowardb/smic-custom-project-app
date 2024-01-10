@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface Demo Project status analytics'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_DEMO_PROJECTS_STATUS_AGGR
  as select distinct from ZI_DEMO_PROJECTS_ROOT_ANAL as _Status
  association to parent ZI_DEMO_PROJECTS_ROOT_ANAL as _Projects on $projection.ITGroupAssigned = _Projects.ITGroupAssigned 
{
  key ITGroupAssigned,
  key StatusDescription,
      StartYear,
      sum ( countPerGroup ) as countPerStatus,

      _Projects
}
group by
  _Status.StatusDescription,
  ITGroupAssigned,
  StartYear
