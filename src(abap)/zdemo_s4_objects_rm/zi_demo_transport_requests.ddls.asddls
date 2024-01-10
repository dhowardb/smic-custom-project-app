@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface Transport Request per charm'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_DEMO_TRANSPORT_REQUESTS
  as select from zdt_demo_tr
  association        to parent ZI_DEMO_CHARM         as _Charms   on $projection.CharmUuid = _Charms.CharmUuid
  association [1..1] to ZI_DEMO_S4_PROJECT_INTERFACE as _Projects on $projection.ProjectUuid = _Projects.ProjectUUID
{
  key transport_request_uuid as TransportRequestUuid,
      charm_uuid             as CharmUuid,
      project_uuid           as ProjectUuid,
      transport_request      as TransportRequest,
      description            as Description,
      @Semantics.user.createdBy: true
      created_by             as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at             as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by        as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at        as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at  as LocalLastChangedAt,

      //associations
      _Charms,
      _Projects
}
