@EndUserText.label: 'Projection view for S4 Worklog'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZC_DEMO_WORKLOG
  as projection on ZI_DEMO_WORKLOG

{
  key WorklogUuid,
  key ProjectUuid,
      LogHours,
      Description,
      ProgressValue,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LocalLastChangedAt,
      /* Associations */
      _Projects : redirected to parent ZC_DEMO_S4_PROJECT_INTERFACE
}
