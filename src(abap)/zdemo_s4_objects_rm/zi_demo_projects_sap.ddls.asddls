@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SMIC Projects under SAP Program'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_DEMO_PROJECTS_SAP
  as select from ZI_DEMO_S4_PROJECT_INTERFACE
{
  key ITGroupAssigned as ITGroup,
      count( * )      as NumberProjectsPerGroup
}

//where
//  ITGroupAssigned = 'SAP PROGRAM'
group by
  ITGroupAssigned
