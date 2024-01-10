@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface for S4 Demo Objects'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_DEMO_S4_OBJECTS
  as select from zdt_demo_s4_obj
  association to parent ZI_DEMO_S4_PROJECT_INTERFACE as _Projects on $projection.ProjectUUID = _Projects.ProjectUUID
{
  key object_uuid       as ObjectUUID,
      project_uuid      as ProjectUUID,
      project_name      as ProjectName,
      object_name       as ObjectName,
      object_line_item  as ObjectLineItem,
      object_type       as ObjectType,
      transport_request as TransportRequest,
      object_package    as ObjectPackage,
//      @Semantics.user.createdBy: true
      object_owner      as ObjectOwner,
//      @Semantics.systemDate.createdAt: true
      object_changed_at as ObjectOwnerLastChangedAt,
      @Semantics.user.createdBy: true
      created_by as CreatedBy,
      @Semantics.systemDate.createdAt: true
      created_at as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,
      /*Associations*/
      _Projects
}
