@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface view for custom tcodes'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_DEMO_TCODES
  as select from tstc
{
  @EndUserText.label: 'Transaction Code'
  key tcode as transactionCode,
  @EndUserText.label: 'Program Name'
      pgmna as programName
}

where
  tcode like 'Z%';
