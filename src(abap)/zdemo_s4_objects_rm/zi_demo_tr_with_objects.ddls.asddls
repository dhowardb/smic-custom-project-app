@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Demo TR with objects'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_DEMO_TR_WITH_OBJECTS
  as select from e070  as tr_header
    inner join   e071  as tr_entries         on tr_header.trkorr = tr_entries.trkorr
    inner join   tadir as repository_objects on  repository_objects.object   = tr_entries.object
                                             and repository_objects.pgmid    = tr_entries.pgmid
                                             and repository_objects.obj_name = tr_entries.obj_name
    inner join   e07t  as tr_description     on tr_header.trkorr = tr_description.trkorr                                          
{
  key tr_header.trkorr            as TransportRequest,
      tr_description.as4text      as Description,
      tr_header.strkorr           as ParentTransportRequest,
      tr_header.trstatus          as TransportStatus,
      tr_entries.obj_name         as ObjectName,
      tr_entries.object           as ObjectType,
      tr_entries.objfunc          as ObjectFunction,
      tr_header.as4user           as ObjectCreatedBy,
      tr_header.as4date           as ObjectCreatedAt,
      repository_objects.devclass as ObjectPackage
}
where
      tr_header.trkorr  like 'D4S%'
  and tr_header.as4user like 'SMIC.%'
  or  tr_header.as4user like 'SMDC.%'
  or  tr_header.as4user like 'FISG.%'
