@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Summary of Projects per priority'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_DEMO_PROJECT_PRIORITY_SAP
  as select from ZI_DEMO_S4_PROJECT_INTERFACE
{
  key ITGroupAssigned as ITGroup,
  key PriorityDescription as PriorityDescription,
      count( * )      as NumberProjectsPerGroup
}

//where
//  ITGroupAssigned = 'SAP PROGRAM'
group by
  ITGroupAssigned,
  PriorityDescription
