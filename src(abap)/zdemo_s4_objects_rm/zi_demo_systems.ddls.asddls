@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface CDS for DEMO systems'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
@Search.searchable: true
define view entity ZI_DEMO_SYSTEMS
  as select from zdt_demo_systems
{
  @Search.defaultSearchElement: true
  @EndUserText.label: 'System'
  key zsystem     as Zsystem,
  @EndUserText.label: 'Description'
      description as Description,
  @EndUserText.label: 'Type'      
      type        as Type,
  @EndUserText.label: 'Version'
      version     as Version,
  @EndUserText.label: 'Kernel'
  @UI.hidden: true
      kernel      as Kernel,
  @EndUserText.label: 'Address'
  @UI.hidden: true
      address     as Address
}
