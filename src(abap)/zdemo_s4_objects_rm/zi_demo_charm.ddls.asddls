@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'S4 demo charm'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_DEMO_CHARM
  as select from zdt_demo_charm
  association        to parent ZI_DEMO_S4_PROJECT_INTERFACE as _Projects on $projection.ProjectUuid = _Projects.ProjectUUID
//  association [1..*] to ZI_DEMO_S4_OBJECTS                  as _Objects  on $projection.TransportRequest = _Objects.TransportRequest
  composition [0..*] of ZI_DEMO_TRANSPORT_REQUESTS as _TransportRequests 
{
  key charm_uuid            as CharmUuid,
      project_uuid          as ProjectUuid,
      charm_number          as CharmNumber,
      transport_request     as TransportRequest,
      description           as Description,
      date_created          as DateCreated,
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

      _Projects,
//      _Objects,
      _TransportRequests
}
