@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface view for Action Items'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_DEMO_ACTIONS
  as select from zdt_demo_actions as _Actions
  association to parent ZI_DEMO_S4_PROJECT_INTERFACE as _Projects on $projection.ProjectUuid = _Projects.ProjectUUID
{
  key action_item_uuid      as ActionItemUuid,
  key project_uuid          as ProjectUuid,
      action_item           as ActionItem,
      description           as Description,
      date_of_action        as DateOfAction,
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

      _Projects
}
