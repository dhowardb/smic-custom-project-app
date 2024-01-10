@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface view for Demo worklog'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_DEMO_WORKLOG
  as select from zdt_demo_worklog as _Worklogs
  association to parent ZI_DEMO_S4_PROJECT_INTERFACE as _Projects on $projection.ProjectUuid = _Projects.ProjectUUID
{
  key worklog_uuid          as WorklogUuid,
  key project_uuid          as ProjectUuid,
      log_hours             as LogHours,
      description           as Description,
      
      case when progress_value > 100
           then 100
           else
      progress_value end    as ProgressValue,
      
      @Semantics.user.createdBy: true
      created_by            as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at            as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by       as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,
      /*Associations*/
      _Projects
}
