@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface Projects Status Analytics'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_DEMO_PROJECTS_STATUS_ANA
  as select from    ZI_DEMO_S4_PROJECT_INTERFACE as SMICProjects
    inner join ZI_DEMO_PROJECTS_SAP         as SAPProjects on SMICProjects.ITGroupAssigned = SAPProjects.ITGroup
{
  key  SMICProjects.ITGroupAssigned       as ITGroup,
  key  SMICProjects.StatusDescription     as StatusDescription,
       count( * )                         as StatusPerGroup,
       SAPProjects.NumberProjectsPerGroup as TotalProjectsPerGroup
}
group by
  SMICProjects.ITGroupAssigned,
  SMICProjects.StatusDescription,
  SAPProjects.NumberProjectsPerGroup
