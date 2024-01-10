@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root analytics for S4 Demo'
define root view entity ZI_DEMO_PROJECTS_ROOT_ANAL
  as select from ZI_DEMO_S4_PROJECT_INTERFACE as _Projects
  composition [*] of ZI_DEMO_PROJECTS_STATUS_AGGR as _StatusAnalytics
  association [1..1] to ZI_DEMO_PROJECTS_STATUS_AGGR as _StatusAnalytics_2 on $projection.ITGroupAssigned = _StatusAnalytics_2.ITGroupAssigned
                                                                          and $projection.StatusDescription = _StatusAnalytics_2.StatusDescription
                                                                          and $projection.StartYear = _StatusAnalytics_2.StartYear
                                                                          
{
  key ITGroupAssigned     as ITGroupAssigned,
      StatusDescription   as StatusDescription,
      PriorityDescription as PriorityDescription,
      StartYear           as StartYear,
      count( * )          as countPerGroup,

      _StatusAnalytics,
      _StatusAnalytics_2
}

group by
  ITGroupAssigned,
  StatusDescription,
  PriorityDescription,
  StartYear
